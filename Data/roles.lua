local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.roles = {}
local roles = addon.roles

-- [0] MANA | [1] RAGE | [3] ENERGY
roles.tank = { name = "tank", power = { 0, 1 }, classes = { "DRUID", "WARRIOR" } }
roles.physical = { name = "physical", power = { 0, 1, 3 }, classes = { "DRUID", "HUNTER", "ROGUE", "WARRIOR", "SHAMAN" } }
roles.caster = { name = "caster", power = { 0 }, classes = { "DRUID", "MAGE", "PALADIN", "PRIEST", "SHAMAN", "WARLOCK" } }

----------------------------
-- GetRole        --
----------------------------
function roles:get(name, modifier)
    local _, class = UnitClass(name) -- DEV CLASSNAME (English)
    local nothing
    for _, role in pairs(roles) do
        if (modifier == "MAINTANK") and (role.name == roles.tank.name) and addon:hasValue(role.classes, class) then return role end
        if addon:hasValue(role.classes, class) then
            if (role.name == roles.physical.name) then if tonumber(UnitPowerMax(name, 0)) < 4500 and addon:hasValue(role.power, UnitPowerType(name)) then return role end end
            if (role.name == roles.caster.name) then if tonumber(UnitPowerMax(name, 0)) > 4500 and addon:hasValue(role.power, UnitPowerType(name)) then return role end end
        end
        if (addon:hasValue(role.classes, class)) then nothing = role end
    end
    addon:printError(name .. "|r " .. L["ERROR_FALSEROLE_LABEL"] .. " (" .. nothing.name .. ")")
    return nothing
end

function roles:getFormated(role)
    local tmp = roles[role]
    local t = {}
    for _, v in ipairs(tmp.classes) do t[#t + 1] = tostring(v) end
    return table.concat(t, ", ")
end
