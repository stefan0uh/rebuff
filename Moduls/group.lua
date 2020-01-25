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
            local selectedBuffs = addon.db.profile[category][role.name]
            local spells = addon.spell:fromArray(addon[category], selectedBuffs)

            for _, buff in pairs(getMissingBuffs(name, role, spells)) do
                if missing[buff.name] == nil then missing[buff.name] = {} end
                table.insert(missing[buff.name], name)
            end
        end
    end
    return missing
end

function getMissingBuffs(player, role, buffs)
    local missing = {}
    for _, buff in pairs(buffs) do
        if not table.includes(role, buff.roles) then
            local buffSlot = 1
            local _, _, _, _, _, _, _, _, _, spellID = UnitBuff(player, buffSlot)
            spellID = tonumber(spellID)
            table.insert(missing, buff)

            while spellID do
                if (table.includes(spellID, buff.ids)) then table.remove(missing) end
                buffSlot = buffSlot + 1
                _, _, _, _, _, _, _, _, _, spellID = UnitBuff(player, buffSlot)
            end
        end
    end
    return missing
end
