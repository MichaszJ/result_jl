using SumTypes, Crayons

@sum_type Result{T, E} begin
    Ok{T}(::T)
    Err{E}(::E)
end

unwrap(result::Result) = @cases result begin
    Ok(val) => val
    Err(err) => throw(err)
end

unwrap_or(result::Result, fallback) = @cases result begin
    Ok(val) => val
    Err(err) => fallback
end

is_ok(result::Result) = @cases result begin
    Ok => true
    Err => false
end

SumTypes.show_sumtype(io::IO, result::Result) = @cases result begin
    Ok(val) => print(
        io, 
        Crayon(foreground = :dark_gray)("Result::"), 
        Crayon(foreground = :green)("OK{$(typeof(val))} $val")
    )
    
    Err(err) => print(
        io, 
        Crayon(foreground = :dark_gray)("Result::"), 
        Crayon(foreground = :red)("Err{$(typeof(err))}")
    )
end