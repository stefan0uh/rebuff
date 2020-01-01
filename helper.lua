local addonName, addon = ...
------------------------
---      HELPER       ---
-------------------------

function addon:listvalues(s)
    local t = {}
    for k, v in ipairs(s) do t[#t + 1] = tostring(v) end
    return table.concat(t, ",")
end

function addon:hasNOTValue(tbl, val) return not addon:hasValue(tbl, val) end

function addon:hasValue(tbl, val)
    if (tbl ~= nil) then for index, value in ipairs(tbl) do if value == val then return true end end end
    return false
end

------------------------
---      HELPER       ---
-------------------------
function addon:pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function() -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end
