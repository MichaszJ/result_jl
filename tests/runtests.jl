using Test

include("../src/Result.jl")
include("../src/Option.jl")

begin
    @testset "Result Type" begin
        function safe_divide(a::Float64, b::Float64)::Result{Float64, DivideError} 
            if b == 0
                return Err(DivideError())
            else
                return Ok(a / b)
            end
        end

        @testset "Ok Values" begin
            div1 = safe_divide(1.0, 2.0)

            @test is_ok(div1)
            @test unwrap(div1) == 1.0 / 2.0
            @test unwrap_or(div1, 0.0) == 1.0 / 2.0
        end

        @testset "Err Values" begin
            div2 = safe_divide(1.0, 0.0)
            @test !is_ok(div2)
            @test_throws DivideError unwrap(div2)
            @test unwrap_or(div2, 0.0) == 0.0
        end
    end

    @testset "Option Type" begin
        function get_index(arr::Array{T}, index::Int)::Option{T} where {T}
            if isassigned(arr, index) && 0 < index <= length(arr)
                return Some(arr[index])
            else
                return None
            end
        end
        
        opt1 = get_index([1, 2, 3], 2)

        @test is_some(opt1) == true
        @test unwrap(opt1) == 2
        @test unwrap_or(opt1, 0) == 2

        opt2 = get_index([1, 2, 3], 4)
        @test is_some(opt2) == false
        @test_throws UndefVarError unwrap(opt2)
        @test unwrap_or(opt2, 0) == 0
    end
end;