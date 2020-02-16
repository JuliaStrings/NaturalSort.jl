module NaturalSort
export natural

function natural(x::AbstractString, y::AbstractString)
    iterx = iterate(x)
    itery = iterate(y)
    while iterx !== nothing && itery !== nothing
        cx, statex = iterx
        cy, statey = itery
        if isnumeric(cx) && isnumeric(cy)
            # Skip leading zeros
            while cx == '0' && (iterx = iterate(x, statex)) !== nothing
                cx, statex = iterx
            end
            while cy == '0' && (itery = iterate(y, statey)) !== nothing
                cy, statey = itery
            end
            if iterx === nothing || itery === nothing
                break
            end

            # Begin comparing numbers
            diff = false
            lt = false
            while true
                isnumx = isnumeric(cx)
                isnumy = isnumeric(cy)
                if isnumx && isnumy
                    if !diff && cx != cy
                        # Keep track of how numbers differ, in case the lengths match
                        diff = true
                        lt = cx < cy
                    end

                    iterx = iterate(x, statex)
                    itery = iterate(y, statey)
                    if iterx === nothing || itery === nothing
                        if iterx === nothing && itery !== nothing && isnumeric(itery[1])
                            # Number in y is longer than number in x
                            return true
                        elseif iterx !== nothing && itery === nothing && isnumeric(iterx[1])
                            # Number in x is longer than number in y
                            return false
                        end
                        # Both numbers ended and same length
                        return diff ? lt : iterx === nothing && itery !== nothing
                    end

                    cx, statex = iterx
                    cy, statey = itery
                elseif isnumx
                    # Number in x is longer than number in y
                    return false
                elseif isnumy
                    # Number in y is longer than number in x
                    return true
                elseif diff
                    # Numbers were same length but different
                    return lt
                else
                    # Numbers were the same
                    break
                end
            end
        end
        if cx != cy
            return cx < cy
        end
        iterx = iterate(x, statex)
        itery = iterate(y, statey)
    end

    return iterx == nothing && itery != nothing
end
end # module
