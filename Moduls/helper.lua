local addonName, addon = ...

----------------------------

-- Addon helper functions
----------------------------
function addon:printError(text, prefix)
    if (prefix) then
        print("|cFFFF0000" .. prefix .. " | |r" .. text)
    else
        print("|cFFFF0000" .. text)
    end
end

function addon:printHelp(text, prefix)
    if (prefix) then
        print("|cFFFF0000" .. prefix .. " | |cAAAAAA00" .. text)
    else
        print("|cAAAAAA00" .. text)
    end
end

function addon:isInGroup()
    return GetNumGroupMembers() > 1
end

------------------------

-- Table enhancements
-------------------------
function table.sortyByKey(t, f)
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

function table.includes(val, tbl)
    if (tbl ~= nil) then for _, value in pairs(tbl) do if value == val then return true end end end
    return false
end

function table.getKeyFromValue(tbl, val) for key, value in pairs(tbl) do if (value == val) then return key end end end

------------------------

-- String enhancements
-------------------------

function string.isEmpty(s)
    return s == nil or s == ''
end
