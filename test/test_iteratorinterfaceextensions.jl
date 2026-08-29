@testitem "IteratorInterfaceExtensions" begin
    struct MyType
    end

    @test isiterable(MyType()) == false
    @test isiterable([1,2,3]) == true

    @test_throws ErrorException getiterator(MyType())

    @test [1,2,3] == getiterator([1,2,3])

    @test IteratorSize2([1,2,3]) == Base.HasShape{1}()
end
