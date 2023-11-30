include("../src/Result.jl")

function safe_divide(a, b)::Result{Float64, DivideError}
    if b == 0
        return Err(DivideError()) |> Result{Float64, DivideError}
    else
        return Ok(a / b) |> Result{Float64, DivideError}
    end
end

# Example 1
# check if the result is ok, unwrap it if it is, otherwise print an error message
for (num, den) in zip([-2, -1, 0, 1, 2], [-2, -1, 0, 1, 2])
    div = safe_divide(num, den)
    
    if is_ok(div)
        println("Result of $num / $den is $(unwrap(div))")
    else
        println("Result of $num / $den is an error")
    end
end

# Example 2
# unwrap the result with fallback value, print the result
for (num, den) in zip([-2, -1, 0, 1, 2], [-2, -1, 0, 1, 2])
    div = safe_divide(num, den)
    div_res = unwrap_or(div, NaN)
    
    println("Result of $num / $den is $div_res")
end