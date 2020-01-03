local addonName, addon = ...

local roles = {}

table.insert(roles, {name = "TANK", classes = {"DRUID", "WARRIOR"}, modifier = {"MAINTANK", "MAINASSIST"}})
table.insert(roles, {name = "MELEE", classes = {"ROGUE", "WARRIOR"}})
table.insert(roles, {name = "RANGE", classes = {"DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "SHAMAN", "WARLOCK"}})

----------------------------
--         GetRole        --
----------------------------
function addon:getRole(class, role)
    for index, value in ipairs(roles) do
        if role ~= nil then
            if addon:hasValue(value.modifier, role) and addon:hasValue(value.classes, class) then return value end
        elseif value.modifier == nil and addon:hasValue(value.classes, class) then
            return value
        end
    end
    return nil
end

function addon:getRoleByName(role) for k, v in pairs(roles) do if (v.name == role) then return v end end end

function addon:getFormatedRoles(role)
    local tmp = addon:getRoleByName(role)
    return "(" .. addon:listPrint(tmp.classes) .. ")"
end
