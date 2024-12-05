local util = {}

-- Map: Applies a function to each element in a table
function util.map(func, tbl)
    local result = {}
    for i, v in ipairs(tbl) do
        result[i] = func(v)
    end
    return result
end

-- Filter: Filters elements based on a predicate
function util.filter(func, tbl)
    local result = {}
    for i, v in ipairs(tbl) do
        if func(v) then
            table.insert(result, v)
        end
    end
    return result
end

-- Reduce: Reduces a table to a single value
function util.reduce(func, tbl, initial)
    local result = initial
    for _, v in ipairs(tbl) do
        result = func(result, v)
    end
    return result
end

return util