using Test

@assert 1 == 1

@assert 1 == 2

@assert 1 == 2 "Very Bad Error"

@macroexpand @assert 1 == 2 "Very Bad Error"

@macroexpand @assert 1 == 2

@test 1 == 1

@testset "Helpful Tests" begin
    @testset "Tautologies" begin
        @test 1 == 1
        @test "a" == "a"
        @test pi == 3.1415
    end
    @testset "Hopefully True" begin
        @test isapprox(2, 2.0002, atol = 1)
        @test isapprox(2 + 2, 5, atol = 1)
        @test isapprox(2 + 2, 3)
        @test isapprox(1e-10, 2e-9, atol = 1e-8)
    end
end
