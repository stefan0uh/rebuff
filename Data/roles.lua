local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.roles = {} -- Global function storage
addon.role = {} -- Global roles storage
local roles = addon.role

----------------------------

-- Roles
-- [0] MANA | [1] RAGE | [3] ENERGY
-- DRUID, WARRIOR, HUNTER, ROGUE, SHAMAN, PALADIN, MAGE, WARLOCK
----------------------------

roles.tank = { name = "tank", power = { 0, 1 }, classes = { "DRUID", "WARRIOR" } };
roles.physical = { name = "physical", power = { 0, 1, 3 }, classes = { "DRUID", "HUNTER", "ROGUE", "WARRIOR", "SHAMAN" } };
roles.caster = { name = "caster", power = { 0 }, classes = { "DRUID", "MAGE", "PALADIN", "PRIEST", "SHAMAN", "WARLOCK" } };

----------------------------

-- Raidrole = "MAINTANK" or nil
function addon.roles:get(name, raidRole)
    local _, class = UnitClass(name) -- DEV CLASSNAME (English)
    local nothing
    for _, role in pairs(roles) do
        if table.includes(class, role.classes) then
            if not string.isEmpty(raidRole) and isTank(role, raidRole) then
                return role
            else
                if isPhysical(role, name) then return role end
                if isCaster(role, name) then return role end
                nothing = role
            end
        end
    end
    addon:printError(L["ERROR_FALSEROLE_LABEL"] .. " (" .. nothing.name .. ")", addonName .. " " .. name)
    return nothing
end

----------------------------
function isTank(role, raidRole)
    return (role.name == roles.tank.name) and (raidRole == "MAINTANK")
end

function isPhysical(role, name)
    return (role.name == roles.physical.name) and (tonumber(UnitPowerMax(name, 0)) < 4500) and table.includes(UnitPowerType(name), role.power)
end

function isCaster(role, name)
    return (role.name == roles.caster.name) and (tonumber(UnitPowerMax(name, 0)) > 4500) and table.includes(UnitPowerType(name), role.power)
end

----------------------------
function addon.roles:getFormated(role)
    local classes = roles[role].classes
    local t = {}
    for _, v in ipairs(classes) do t[#t + 1] = tostring(v) end
    return table.concat(t, ", ")
end
