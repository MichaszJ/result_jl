using SumTypes, Crayons

@sum_type Option{T} begin
    Some{T}(::T)
    None
end

unwrap(option::Option) = @cases option begin
    Some(val) => val
    None => throw(UndefVarError(:val))
end

unwrap_or(option::Option, fallback) = @cases option begin
    Some(val) => val
    None => fallback
end

is_some(option::Option) = @cases option begin
    Some => true
    None => false
end

SumTypes.show_sumtype(io::IO, opt::Option) = @cases opt begin
    Some(val) => print(
        io, 
        Crayon(foreground = :dark_gray)("Option::"), 
        Crayon(foreground = :green)("Some{$(typeof(val))} $val")
    )
    
    None => print(
        io, 
        Crayon(foreground = :dark_gray)("Option::"), 
        Crayon(foreground = :red)("None")
    )
end