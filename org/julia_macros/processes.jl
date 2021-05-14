using Distributed

nprocs()

addprocs(5)

nprocs()

function count_heads(n)
    c::Int = 0
    for i = 1:n
        c += rand(Bool)
    end
    c
end

a = @spawnat :any count_heads(100000000)

fetch(a)

@everywhere function count_heads(n)
    c::Int = 0
    for i = 1:n
        c += rand(Bool)
    end
    c
end

a = @spawnat :any count_heads(100000000)

fetch(a)

b = @spawnat :any count_heads(100000000)

fetch(a) + fetch(b)

nheads = @distributed (+) for i = 1:200000000
    Int(rand(Bool))
end

a = zeros(100000)

@distributed for i = 1:100000
    a[i] = i
end

a

using SharedArrays

a = SharedArray{Float64}(10)

@distributed for i = 1:10
    a[i] = i
end

a










