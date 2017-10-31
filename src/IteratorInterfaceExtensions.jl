__precompile__(true)
module IteratorInterfaceExtensions

export getiterator, isiterable, iteratorsize2

isiterable(x::T) where {T} = method_exists(start, Tuple{T})

function getiterator(x)
    if !isiterable(x)
        error("Can't get iterator for non iterable source.")
    end
    return x
end

struct HasLengthAfterStart <: Base.IteratorSize end

iteratorsize2(x) = iteratorsize2(typeof(x))
iteratorsize2(::Type{T}) where {T} = Base.iteratorsize(T)

end # module
