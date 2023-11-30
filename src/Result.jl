abstract type ResultOption end
struct Ok{T} <: ResultOption
    val::T
end

struct Err{T} <: ResultOption
    val::T
end

struct Result{O, T <: Exception} 
    res::Union{Ok, Err}
end

unwrap(result::Result) = result.res isa Err ? throw(result.res.val) : result.res.val
unwrap_or(result::Result, fallback) = result.res isa Err ? fallback : result.res.val

is_ok(result::Result) = result.res isa Ok

Base.show(io::IO, obj::Ok) = print(io, "OK{$(typeof(obj.val)), $(obj.val)}")
Base.show(io::IO, obj::Err) = print(io, "Err{$(typeof(obj.val))}")
Base.show(io::IO, obj::Result) = print(io, "Result{$(obj.res)}")