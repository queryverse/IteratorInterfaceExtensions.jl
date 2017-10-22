using IteratorTraits
using Base.Test

struct MyType
end

@testset "IteratorTraits" begin

@test isiterable(MyType()) == false
@test isiterable([1,2,3]) == true

@test_throws ErrorException getiterator(MyType())

@test [1,2,3] == getiterator([1,2,3])

end
