local addonName, addon = ...

function addon:groupCheck(spell)
    local name, idx = "", 1
    local missingBuffs = {}

    if GetNumGroupMembers() == 0 then idx = 0 end -- 0 means no group
    -- Check each player in the group/raid
    for groupIndex = idx, GetNumGroupMembers(), 1 do
        local online, role
        -- Check if solo (though not very useful outside of testing)
        if groupIndex == 0 then
            name = UnitName("player")
            online = true
        else
            name, _, _, _, _, _, _, online, _, role = GetRaidRosterInfo(groupIndex) --  DEV CLASSNAME (English)
        end
        if online and name ~= nil then
            role = addon:getRole(name, role)
            local selectedBuffs = addon.db.profile[spell][role.name]
            local spells = addon:getSpells(spell, selectedBuffs)
            local playerMissing = addon:getMissingSpells(name, role, spells)
            for index, buff in pairs(playerMissing) do
                if missingBuffs[buff.name] == nil then missingBuffs[buff.name] = {} end
                table.insert(missingBuffs[buff.name], name)
            end
        end
    end
    return missingBuffs
end

function addon:getMissingSpells(player, role, buffs)
    local missing = {}
    for index, buff in pairs(buffs) do
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

function addon:getSpells(spell, selectedBuffs)
    if (spell == addon.spells[1]) then
        return addon:getBuffsFromArray(selectedBuffs)
    else
        return addon:getConsumablesFromArray(selectedBuffs)
    end
end

