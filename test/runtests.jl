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

# println(sort(["b##", "b#!##", "1", "a#", "b"], lt=NaturalSort.natural))
# println(sort(["a#", "b"], lt=NaturalSort.natural))

for i = 1:length(STRS)
    for j = 1:i-1
        # println("--- 1 ---")
        # println("i ", i)
        # println("j ", j)
        # println("STRS[i] ", STRS[i], " STRS[j] ", STRS[j])
        result = NaturalSort.natural(STRS[j], STRS[i])
        # println("result ", result)
        @test result
    end
    for j = i:length(STRS)
        # println("--- 2 ---")
        # println("i ", i)
        # println("j ", j)
        # println("STRS[i] ", STRS[i], " STRS[j] ", STRS[j])
        result = NaturalSort.natural(STRS[j], STRS[i])
        # println("result ", result)
        @test !NaturalSort.natural(STRS[j], STRS[i])
    end
end

EQ_STRS = [
    ("a01", "a1"),
    ("a01b2", "a1b2")
]

for (str, eqto) in EQ_STRS
    for i = 1:findfirst([j == eqto for j in STRS])-1
        # println("i", i)
        # println("STRS", STRS)
        @test NaturalSort.natural(STRS[i], str)
        @test !NaturalSort.natural(str, STRS[i])
    end
    for i = findfirst([j == eqto for j in STRS])+1:length(STRS)
        # println("i", i)
        # println("STRS", STRS)
        @test !NaturalSort.natural(STRS[i], str)
        @test NaturalSort.natural(str, STRS[i])
    end
end
