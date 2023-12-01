#### Result
include("../src/Result.jl")

# Example 1
# check if the result is ok, unwrap it if it is, otherwise print an error message
function safe_divide(a::T, b::T)::Result{Float64, DivideError} where {T <: Number}
    if b == 0
        return Err(DivideError())
    else
        return Ok(a / b)
    end
end

for (num, den) in zip([-2, -1, 0, 1, 2], [-2, -1, 0, 1, 2])
    div = safe_divide(num, den)
    
    if is_ok(div)
        println("Result of $num / $den is $div -> $(unwrap(div))")
    else
        println("Result of $num / $den is $div")
    end
end

# Example 2
# unwrap the result with fallback value, print the result
for (num, den) in zip([-2, -1, 0, 1, 2], [-2, -1, 0, 1, 2])
    div = safe_divide(num, den)
    div_res = unwrap_or(div, NaN)
    
    println("Result of $num / $den is $div -> $div_res")
end

# Example 2
# parse result with match/cases
for (num, den) in zip([-2, -1, 0, 1, 2], [-2, -1, 0, 1, 2])
    div = safe_divide(num, den)
    
    @cases div begin
        Ok(val) => println("Result of $num / $den is $div -> $val")
        Err(err) => println("Error occurred for $num / $den -> $div")
    end
end

#### Option
include("../src/Option.jl")

# Example 1
function get_index(arr::Array{T}, index::I)::Option{T} where {T, I <: Int}
    if isassigned(arr, index) && 0 < index <= length(arr)
        return Some(arr[index])
    else
        return None
    end
end

dataset_A = [1, 2, 3, 4, 5]
dataset_B = [1, 2, 3, 4]

for i in 1:6
    val_A = get_index(dataset_A, i)
    val_B = get_index(dataset_B, i)
    
    if is_some(val_A) && is_some(val_B)
        println("A[$i] = $(unwrap(val_A)) \t B[$i] = $(unwrap(val_B))")
    elseif !is_some(val_A) && is_some(val_B)
        println("A[$i] = None \t B[$i] = $(unwrap(val_B))")
    elseif !is_some(val_B) && is_some(val_A)
        println("A[$i] = $(unwrap(val_A)) \t B[$i] = None")
    else
        println("A[$i] = None \t B[$i] = None")
    end
end