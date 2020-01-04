local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

local roles = {}

-- [0] MANA | [1] RAGE | [3] ENERGY 
table.insert(roles, {name = "tank", power = {0, 1}, classes = {"DRUID", "WARRIOR", "WARLOCK"}, modifier = {"MAINTANK"}})
table.insert(roles, {name = "physical", power = {0, 1, 3}, classes = {"DRUID", "HUNTER", "ROGUE", "WARRIOR", "SHAMAN"}})
table.insert(roles, {name = "caster", power = {0}, classes = {"DRUID", "MAGE", "PALADIN", "PRIEST", "SHAMAN", "WARLOCK"}})

----------------------------
--         GetRole        --
----------------------------
function addon:getRole(name, modifier)
    local _, class = UnitClass(name) -- DEV CLASSNAME (English)
    local found = nil
    for index, role in ipairs(roles) do
        if modifier == nil and role.modifier == nil and addon:hasValue(role.classes, class) then -- player has no raid role and role no modifier attribute
            if (role.name == "physical") then if tonumber(UnitPowerMax(name, 0)) < 4500 and addon:hasValue(role.power, UnitPowerType(name)) then return role end end
            if (role.name == "caster") then if tonumber(UnitPowerMax(name, 0)) > 4500 and addon:hasValue(role.power, UnitPowerType(name)) then return role end end
            if addon:hasValue(role.power, UnitPowerType(name)) then return role end
        elseif addon:hasValue(role.modifier, modifier) and addon:hasValue(role.classes, class) then
            return role
        end
        if addon:hasValue(role.classes, class) then found = role end
    end
    addon:printError(name .. "|r " .. L["falseRole"] .. " (" .. found.name .. ")")
    return found
end

function addon:getRoleByName(role) for k, v in pairs(roles) do if (v.name == role) then return v end end end

function addon:getFormatedRoles(role)
    local tmp = addon:getRoleByName(role)
    return addon:listPrint(tmp.classes)
end

function addon:test()
    local name, idx = "", 1
    if GetNumGroupMembers() == 0 then idx = 0 end -- 0 means no group
    -- Check each player in the group/raid
    for groupIndex = idx, GetNumGroupMembers(), 1 do
        local online, role, class
        -- Check if solo (though not very useful outside of testing)
        if groupIndex == 0 then
            name = UnitName("player")
            online = true
            _, class = UnitClass("player")
        else
            name, _, _, _, _, class, _, online, _, role = GetRaidRosterInfo(groupIndex) --  DEV CLASSNAME (English)
        end
        if online and name ~= nil then
            role = addon:getRole(name, role)
            print(name .. "(" .. class .. ")>>>" .. role.name)
        end
    end
end
