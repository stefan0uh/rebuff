local _, addon = ...

addon.group = {}
local group = addon.group

----------------------------

-- Missing buff checking
----------------------------

function group:check(category)
    local name, idx, online, raidRole = "", 1, nil, nil
    local missing = {}

    if GetNumGroupMembers() == 0 then idx = 0 end -- 0 means no group
    -- Check each player in the group/raid
    for groupIndex = idx, GetNumGroupMembers(), 1 do
        -- Check if solo (though not very useful outside of testing)
        if groupIndex == 0 then
            name = UnitName("player")
            online = true
        else
            name, _, _, _, _, _, _, online, _, raidRole = GetRaidRosterInfo(groupIndex)
        end
        if online and not string.isEmpty(name) then
            local role = addon.roles:get(name, raidRole)
            local roleSpells = addon.db.profile[category][role.name]
            local spells = addon.spell:getFromArray(roleSpells, addon[category])

            for _, buff in pairs(getMissingSpells(name, role, spells)) do
                if missing[buff.name] == nil then missing[buff.name] = {} end
                table.insert(missing[buff.name], name)
            end
        end
    end
    return missing
end

function getMissingSpells(player, role, spells)
    local missing = {}
    for _, spell in pairs(spells) do
        if not table.includes(role, spell.roles) then
            table.insert(missing, spell)

            local slot = 1
            local _, _, _, _, _, _, _, _, _, id = UnitBuff(player, slot)

            while id do
                if (table.includes(tonumber(id), spell.ids)) then table.remove(missing) end
                slot = slot + 1
                _, _, _, _, _, _, _, _, _, id = UnitBuff(player, slot)
            end
        end
    end
    return missing
end
