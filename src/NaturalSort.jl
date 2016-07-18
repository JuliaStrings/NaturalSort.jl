module NaturalSort
export natural

function natural(x::AbstractString, y::AbstractString)
    statex = start(x)
    statey = start(y)
    donex = false
    doney = false
    while !(donex = done(x, statex)) & !(doney = done(y, statey))
        cx, statex = next(x, statex)
        cy, statey = next(y, statey)
        if isnumber(cx) && isnumber(cy)
            # Skip leading zeros
            while cx == '0' && !(donex = done(x, statex))
                cx, statex = next(x, statex)
            end
            while cy == '0' && !(doney = done(y, statey))
                cy, statey = next(y, statey)
            end

            # Begin comparing numbers
            diff = false
            lt = false
            while true
                isnumx = isnumber(cx)
                isnumy = isnumber(cy)
                if isnumx && isnumy
                    if !diff && cx != cy
                        # Keep track of how numbers differ, in case the lengths match
                        diff = true
                        lt = cx < cy
                    end

                    donex = done(x, statex)
                    doney = done(y, statey)
                    if donex || doney
                        if donex && !doney && isnumber(next(y, statey)[1])
                            # Number in y is longer than number in x
                            return true
                        elseif !donex && doney && isnumber(next(x, statex)[1])
                            # Number in x is longer than number in y
                            return false
                        end
                        # Both numbers ended and same length
                        return diff ? lt : donex && !doney
                    end

                    cx, statex = next(x, statex)
                    cy, statey = next(y, statey)
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
    end

    return donex && !doney
end
end # module
