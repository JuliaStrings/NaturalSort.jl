using NaturalSort
using Base.Test

# write your own tests here
STRS = [
    "a#",
    "a0",
    "a1",
    "a1b1",
    "a1b2",
    "a01b3",
    "a1b11",
    "a2",
    "a11",
    "a11b1",
    "a11b2",
    "a11b11",
    "a12",
    "a12b1",
    "a22",
    "abc",
    "b"
]

for i = 1:length(STRS)
    for j = 1:i-1
        @test natural(STRS[j], STRS[i])
    end
    for j = i:length(STRS)
        @test !natural(STRS[j], STRS[i])
    end
end

EQ_STRS = [
    ("a01", "a1"),
    ("a01b2", "a1b2")
]
for (str, eqto) in EQ_STRS
    for i = 1:findfirst(STRS, eqto)-1
        @test natural(STRS[i], str)
        @test !natural(str, STRS[i])
    end
    for i = findfirst(STRS, eqto)+1:length(STRS)
        @test !natural(STRS[i], str)
        @test natural(str, STRS[i])
    end
end
