function add5(n)
    n + 5
end

function return15()
    a::Int64 = 9
    add5(a + 1)
end

function square(n)
    n * n
end

function square_string()
    square("1")
end

function add_kr_li(n, k, l)
    n + Complex(k, l)
end

println("add5, Int64:")
code_native(add5, (Int64,), syntax = :intel)

println("add5, Float64:")
code_native(add5, (Float64,), syntax = :intel)

println("return15:")
code_native(return15, (), syntax = :intel)

# println("square, Int64:")
# code_native(square, (Int64,), syntax = :intel)
#
# println("square, Float64:")
# code_native(square, (Float64,), syntax = :intel)
#
# println("square, String:")
# code_native(square, (String,), syntax = :intel)
#
# println("square_string:")
# code_native(square_string, (), syntax = :intel)
