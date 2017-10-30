# IteratorTraits

[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/davidanthoff/IteratorTraits.jl.svg?branch=master)](https://travis-ci.org/davidanthoff/IteratorTraits.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/n4lyqi32q7n66eui/branch/master?svg=true)](https://ci.appveyor.com/project/davidanthoff/iteratortraits-jl/branch/master)
[![IteratorTraits](http://pkg.julialang.org/badges/IteratorTraits_0.6.svg)](http://pkg.julialang.org/?pkg=IteratorTraits)
[![codecov.io](http://codecov.io/github/davidanthoff/IteratorTraits.jl/coverage.svg?branch=master)](http://codecov.io/github/davidanthoff/IteratorTraits.jl?branch=master)

IteratorTraits defines a small number of traits for iterators.

## Overview

This package adds a couple of extensions to the standard [iterator interface](https://docs.julialang.org/en/latest/manual/interfaces/#man-interface-iteration-1)
in julia.

### ``isiterable`` and ``getiterator``

The first extension is comprised of the functions ``isiterable`` and
``getiterator``. ``isiterable(x)`` will return ``true`` or ``false``,
indicating whether ``x`` can be iterated. It is important to note that
a ``true`` return value does *not* indicate that one can call the
``start`` method on ``x``, instead a consumer *must* call ``getiterator(x)``
if ``isiterable(x)`` returned true, and can then call ``start`` on the
instance that is returned by ``getiterator``. The proper pattern for
consumer code therefore looks like this:
````julia
if isiterable(x)
    it = getiterator(x)
    for i in it
        # Custom code
    end
end
````
This consumer pattern will work with iterators that don't opt into the
extensions in this package and with iterators that have opted into
the extended interface defined in this package.

There are two scenarios when a source might participate in this extended
iterator interface.

The first scenario is one where a source could not
implement a type-stable version of ``start``, ``next`` and ``done`` because
the primary source type lacks the necessary type information. Such a
source can add a method to ``getiterator`` that returns an instance
of a different type with enough type information for a type stable
implementation of the core iterator interface that iterates the elements
of the original source.

Second, sometimes such a source might not want to implement the ``start``, ``next``
and ``done`` method at all for its core type. If that is the case, this
source can add a method to ``isiterable`` that returns ``true``, even
though the source does not have a ``start`` method. As long as this source
still implements the ``getiterator`` function, it still complies with the
extended iterator contract defined in this package.

### ``iteratorsize2``

``iteratorsize2`` extends ``Base.iteratorsize`` with an additional return
value, namely ``HasLengthAfterStart()``. An iterator consumer that can
provide an optimized implementation for iterators that know their length
after the ``start`` method has been called, can call ``iteratorsize2``
instead of ``Base.iteratorsize``. The return value will either be one of
the possible return values of ``Base.iteratorsize``, or
``HasLengthAfterStart()``. If the return value is ``HasLengthAfterStart()``,
the consumer can call ``length(x, state)`` to obtain the number of
elements the iterator will return. Here ``x`` is the same value that
``start`` was called on, and ``state`` is the value returned by
``start(x)``.

An iterator that implements ``iteratorsize2(x::MyType) = HasLengthAfterStart()``
must also implement ``Base.iteratorsize(x::MyType) = Base.SizeUnknown()``.
