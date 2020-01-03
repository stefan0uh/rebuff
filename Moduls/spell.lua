local addonName, addon = ...

addon.spell = {}
addon.__index = spell

function addon:newSpell(name, ids, roles, group)
    local sp = {}
    setmetatable(sp, spell)

    -- Data
    if (group == "GROUP") then
        sp.name = name
    elseif(group  == "ITEM") then
        sp.name = GetItemInfo(name)
    else
        sp.name = GetSpellInfo(ids[1])
    end
    sp.ids = ids
    sp.roles = roles

    return sp
end
