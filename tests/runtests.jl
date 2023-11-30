using Test

include("../src/Result.jl")

@testset "Basics" begin
    function safe_divide(a, b)::Result{Float64, DivideError}
        if b == 0
            return Err(DivideError()) |> Result{Float64, DivideError}
        else
            return Ok(a / b) |> Result{Float64, DivideError}
        end
    end

    @testset "Ok Values" begin
        div1 = safe_divide(1, 2)

        @test is_ok(div1)
        @test unwrap(div1) == 1/2
        @test unwrap_or(div1, 0) == 1/2
    end

    @testset "Err Values" begin
        div2 = safe_divide(1, 0)
        @test !is_ok(div2)
        @test_throws DivideError unwrap(div2)
        @test unwrap_or(div2, 0) == 0
    end
end;