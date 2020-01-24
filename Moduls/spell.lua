local addonName, addon = ...

addon.spell = {}
addon.__index = spell

-------------------------------
-- name - String or ItemID (if GROUP, ITEM or BUFF)
-- ids - Table with spell ids to check
-------------------------------
function addon:new_Spell(name, ids, roles, def)
    local sp = {}
    setmetatable(sp, spell)
    sp.name = name
    sp.ids = ids
    sp.roles = roles
    sp.def = def
    return sp
end

function addon:new_Group(name, ids, roles) return addon:new_Spell(name, ids, roles, "GROUP") end

function addon:new_Consum(item, ids, roles) return addon:new_Spell(GetItemInfo(item), ids, roles, "CONSUM") end

function addon:new_Buff(ids, roles) return addon:new_Spell(GetSpellInfo(ids[1]), ids, roles, "BUFF") end

----------------------------

function addon:spell_Remap(t)
    local tmp = {}
    for _, x in pairs(t) do table.insert(tmp, x.ids[1]) end
    return tmp
end


function addon:getSpellsFromArray(spells, arr)
    local tmp = {}
    for _, id in pairs(arr) do table.insert(tmp, addon:getSpellById(spells, id)) end
    return tmp
end

function addon:getSpellById(spells, id) for k, v in pairs(spells) do if (addon:hasValue(v.ids, id)) then return v end end end

----------------------------

function addon:getSpellsForSelection(spells, role)
    local tmp = {}
    for _, v in pairs(spells) do
        if (addon:hasValue(v.roles, role)) then
            tmp[v.ids[1]] = v.name
        end
    end
    return tmp
end
