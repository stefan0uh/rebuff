local addonName, addon = ...

addon.spell = {}
addon.__index = spell

function addon:newSpell(name, ids, roles, consum)
    local sp = {}
    setmetatable(sp, spell)

    -- Data
    if (consum == "CONSUM") then
        sp.name = name
    else
        sp.name = GetSpellInfo(ids[1])
    end
    sp.ids = ids
    sp.roles = roles

    return sp
end
