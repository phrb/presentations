function arithmetic(n)
    sum = 0
    for i = 1:n
        sum += i
    end
    return sum
end

function main()
    n::Int64 = 12
    arithmetic(n)
end

# println("arithmetic, Int64:")
# code_native(arithmetic, (Int64,), syntax = :intel)

# println("arithmetic, Float64:")
# code_native(arithmetic, (Float64,), syntax = :intel)

# println("main:")
# code_native(main, (), syntax = :intel)
