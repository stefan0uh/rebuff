local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.roles = {}
local roles = addon.roles

----------------------------

-- Roles
-- [0] MANA | [1] RAGE | [3] ENERGY
----------------------------
roles.tank = { name = "tank", power = { 0, 1 }, classes = { "DRUID", "WARRIOR" } }
roles.physical = { name = "physical", power = { 0, 1, 3 }, classes = { "DRUID", "HUNTER", "ROGUE", "WARRIOR", "SHAMAN" } }
roles.caster = { name = "caster", power = { 0 }, classes = { "DRUID", "MAGE", "PALADIN", "PRIEST", "SHAMAN", "WARLOCK" } }

----------------------------

-- Raidrole = "MainTank", "MainAssist" or nil
function roles:get(name, raidRole)
    local _, class = UnitClass(name) -- DEV CLASSNAME (English)
    local nothing
    for _, role in pairs(roles) do
        if raidRole == "MAINTANK" and role.name == roles.tank.name and table.includes(class, role.classes) then return role end
        if table.includes(class, role.classes) then
            if role.name == roles.physical.name then if tonumber(UnitPowerMax(name, 0)) < 4500 and table.includes(UnitPowerType(name), role.power) then return role end end
            if role.name == roles.caster.name then if tonumber(UnitPowerMax(name, 0)) > 4500 and table.includes(UnitPowerType(name), role.power) then return role end end
        end
        if table.includes(class, role.classes) then nothing = role end
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
