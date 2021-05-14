function simple1(a::Int, b::Int)::Int
    c::Int = a + b

    if c > 5
        c = 2 * c
    else
        c = 3 * c
    end

    return c
end

function multiply(a::Int, b::Int)::Int
    return a * b
end

function divide(a::Int, b::Int)::Int
    return a / b
end

function simple2(a::Int)::Int
    return multiply(a, 2)
end

function simple3(a::Int)::Int
    return divide(a, 2)
end

function simple4(a::Int)::Int
    return multiply(a, 3)
end

function simple5(limit::Int)::Int
    sum::Int = 0

    for i = 1:limit
        sum += i
    end

    return sum
end

function array_ops(size::Int)::Array{Int, 1}
    a::Array{Int, 1} = ones(size)

    b::Array{Int, 1} = a .* 2

    b = b .+ 2

    b = b .- 2

    b = b ./ 2

    return b
end
