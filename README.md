# NaturalSort

[![Build Status](https://travis-ci.org/simonster/NaturalSort.jl.svg?branch=master)](https://travis-ci.org/simonster/NaturalSort.jl)
[![codecov.io](http://codecov.io/github/simonster/NaturalSort.jl/coverage.svg?branch=master)](http://codecov.io/github/simonster/NaturalSort.jl?branch=master)

[Natural Sort Order](https://en.wikipedia.org/wiki/Natural_sort_order) in Julia

## Usage

Pass `lt=natural` to a [sorting function](http://docs.julialang.org/en/stable/stdlib/sort/#sorting-functions) such as `sort`.

## Example

```julia
julia> using NaturalSort

julia> sort(["a1", "a2", "a10"])
3-element Array{String,1}:
 "a1"
 "a10"
 "a2"

julia> sort(["a1", "a2", "a10"], lt=natural)
3-element Array{String,1}:
 "a1"
 "a2"
 "a10"
 ```
