addprocs()

import StochasticSearch, JSON

@everywhere begin
    using StochasticSearch

    function create_unique_dir(settings::Dict{Symbol, Any})
        unique_dir = string(tempdir(), "/", Base.Random.uuid4())
        mkpath(unique_dir)

        cp(settings[:source_dir], "$unique_dir/$(settings[:source_dir])")
        return unique_dir
    end

    function generate_compile_command(configuration::Configuration,
                                      unique_dir::String,
                                      settings::Dict{Symbol, Any})
        command = split(strip(settings[:make_cmd]))

        if settings[:use_makefile]
            push!(command, "$unique_dir/$(settings[:source_dir])")

            append!(command, split(strip(settings[:flags_variable])))
            parameters = ""

            for parameter in keys(configuration.value)
                if typeof(configuration[parameter]) <: BoolParameter && configuration[parameter].value == true
                    parameters = string(parameters, " $parameter")
                elseif typeof(configuration[parameter]) <: EnumParameter
                    parameters = string(parameters, " $parameter$(configuration[parameter].current.value)")
                elseif typeof(configuration[parameter]) <: IntegerParameter
                    parameters = string(parameters, " $parameter$(configuration[parameter].value)")
                end
            end

            push!(command, parameters)
            return Cmd(`$(command[1]) $(command[2]) $(command[3]) $(command[4])\"$(command[5])\"`)
        else
            append!(command, split(strip(settings[:cuda_path])))

            for parameter in keys(configuration.value)
                if typeof(configuration[parameter]) <: BoolParameter && configuration[parameter].value == true
                    append!(command, split(strip(parameter)))
                elseif typeof(configuration[parameter]) <: EnumParameter
                    append!(command, split(strip("$parameter$(configuration[parameter].current.value)")))
                elseif typeof(configuration[parameter]) <: IntegerParameter
                    append!(command, split(strip("$parameter$(configuration[parameter].value)")))
                end
            end

            append!(command, ["$unique_dir/$(settings[:source_dir])/$(settings[:source])"])
            append!(command, ["-o", "$unique_dir/$(settings[:source_dir])/$(settings[:executable])"])

            return Cmd(`$command`)
        end
    end

    function execution_time(configuration::Configuration,
                            settings::Dict{Symbol, Any})
        unique_dir      = create_unique_dir(settings)
        compile_command = generate_compile_command(configuration, unique_dir, settings)

        try
            run(compile_command)
            time = @elapsed run(`/$unique_dir/$(settings[:source_dir])/$(settings[:executable])`)

            rm(unique_dir, recursive = true)
            return time
        catch exception
            rm(unique_dir, recursive = true)
            return Base.Inf
        end
    end
end

function generate_search_space(filename::String)
    json_data       = JSON.parsefile(filename)
    parameter_types = ["flags", "enumeration_parameters", "numeric_parameters"]
    parameters      = Array{Parameter, 1}()

    for key in keys(json_data)
        prefix = json_data[key]["prefix"]
        for parameter_type in parameter_types
            if !(isempty(json_data[key][parameter_type]))
                if parameter_type == "flags"
                    for parameter in json_data[key][parameter_type]
                        push!(parameters, BoolParameter(false, "$prefix $parameter"))
                    end
                elseif parameter_type == "enumeration_parameters"
                    for parameter in json_data[key][parameter_type]
                        values = Array{Parameter, 1}()
                        for value in parameter[2]
                            push!(values, StringParameter(value))
                        end

                        push!(parameters, EnumParameter(values, "$prefix $(parameter[1])"))
                    end
                else
                    for parameter in json_data[key][parameter_type]
                        push!(parameters, IntegerParameter(parameter[2]["min"],
                                                           parameter[2]["max"],
                                                           "$prefix $(parameter[1])"))
                    end
                end
            end
        end
    end
    return parameters
end

settings      = JSON.parsefile("settings/settings.json",
                               dicttype = Dict{Symbol, Any})

configuration = Configuration(generate_search_space("settings/nvcc_flags.json"),
                              "nvcc_configuration")

tuning_run = Run(cost                = execution_time,
                 cost_arguments      = settings,
                 cost_evaluations    = settings[:cost_evaluations],
                 starting_point      = configuration,
                 stopping_criterion  = elapsed_time_criterion,
                 measurement_method  = sequential_measure_mean!,
                 report_after        = settings[:report_after],
                 reporting_criterion = elapsed_time_reporting_criterion,
                 duration            = settings[:duration],
                 methods             = [[:simulated_annealing 1];
                                        [:randomized_first_improvement 1];])
                                        #[:iterated_local_search 1];
                                        #[:iterative_probabilistic_improvement 1];])

println("Starting tuning run...")

@spawn optimize(tuning_run)
result = take!(tuning_run.channel)

@printf("Time: %.2f Cost: %.4f (Found by %s)\n",
        result.current_time,
        result.cost_minimum,
        result.technique)

while !result.is_final
    result = take!(tuning_run.channel)
    @printf("Time: %.2f Cost: %.4f (Found by %s)\n",
            result.current_time,
            result.cost_minimum,
            result.technique)
end

println("Done.")
println("Generating autotuned command...")

file    = open("$(settings[:final_configuration])", "w+")
command = join(generate_compile_command(result.minimum, ".", settings), " ")

write(file, command)
close(file)

println("Done.")
