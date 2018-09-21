module NaturalSort
export natural

function natural(x::AbstractString, y::AbstractString)
    cx, statex = iterate(x)
    cy, statey = iterate(y)

    donex = false
    doney = false
    i = 0
    while !(donex) & !(doney)
        i += 1
        if isnumeric(cx) && isnumeric(cy)
            # Skip leading zeros
            while cx == '0' && !donex
                x_it = iterate(x, statex)

                if x_it != nothing
                    cx, statex = x_it
                else
                    donex = true
                end
            end

            while cy == '0' && !doney
                y_it = iterate(y, statey)
                if y_it != nothing
                    cy, statey = y_it
                else
                    doney = true
                end
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

                    x_it = iterate(x, statex)
                    y_it = iterate(y, statey)

                    if x_it != nothing
                        cx, statex = x_it
                    else
                        donex = true
                    end

                    if y_it != nothing
                        cy, statey = y_it
                    else
                        doney = true
                    end

                    if donex || doney

                        if donex && !doney
                            it_y = iterate(y, statey)

                            if y_it != nothing
                                cy, statey = y_it
                            else
                                doney = true
                            end

                        elseif doney && !donex
                            it_x = iterate(x, statex)


                            if x_it != nothing
                                cx, statex = x_it
                            else
                                donex = true
                            end
                        end

                        if donex && !doney && isnumeric(cy)
                            # Number in y is longer than number in x
                            return true
                        elseif !donex && doney && isnumeric(cx)
                            # Number in x is longer than number in y
                            return false
                        end
                        # Both numbers ended and same length
                        return diff ? lt : donex && !doney
                    end

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

        x_it = iterate(x, statex)
        y_it = iterate(y, statey)

        if x_it != nothing
            cx, statex = x_it
        else
            donex = true
        end

        if y_it != nothing
            cy, statey = y_it
        else
            doney = true
        end

    end

    return donex && !doney
end
end # module
