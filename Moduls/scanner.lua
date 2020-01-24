local _, addon = ...

function addon:groupCheck(spell)
    local name, idx, online, role = "", 1, nil, nil
    local missingBuffs = {}

    if GetNumGroupMembers() == 0 then idx = 0 end -- 0 means no group
    -- Check each player in the group/raid
    for groupIndex = idx, GetNumGroupMembers(), 1 do
        -- Check if solo (though not very useful outside of testing)
        if groupIndex == 0 then
            name = UnitName("player")
            online = true
        else
            name, _, _, _, _, _, _, online, _, role = GetRaidRosterInfo(groupIndex) --  DEV CLASSNAME (English)
        end
        if online and name ~= nil then
            role = addon.roles:get(name, role)
            local selectedBuffs = addon.db.profile[spell][role.name]
            local spells = addon.spell:fromArray(addon[spell], selectedBuffs)
            local playerMissing = addon:getMissingSpells(name, role, spells)
            for _, buff in pairs(playerMissing) do
                if missingBuffs[buff.name] == nil then missingBuffs[buff.name] = {} end
                table.insert(missingBuffs[buff.name], name)
            end
        end
    end
    return missingBuffs
end

function addon:getMissingSpells(player, role, buffs)
    local missing = {}
    for _, buff in pairs(buffs) do
        if addon:hasNOTValue(buff.roles, role) then
            local buffSlot = 1
            local _, _, _, _, _, _, _, _, _, spellID = UnitBuff(player, buffSlot)
            spellID = tonumber(spellID)
            table.insert(missing, buff)

            while spellID do
                if (addon:hasValue(buff.ids, spellID)) then table.remove(missing) end
                buffSlot = buffSlot + 1
                _, _, _, _, _, _, _, _, _, spellID = UnitBuff(player, buffSlot)
            end
        end
    end
    return missing
end

