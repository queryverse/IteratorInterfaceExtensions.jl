module IteratorTraits

export getiterator, isiterable

isiterable(x::T) where {T} = method_exists(start, Tuple{T})

function getiterator(x)
    if !isiterable(x)
        error("Can't get iterator for non iterable source.")
    end
    return x
end

end # module
