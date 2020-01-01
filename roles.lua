local addonName, addon = ...

addon.roles = {}

table.insert(addon.roles, {name = "TANKS", classes = {"DRUID", "WARRIOR"}, modifier = {"MAINTANK", "MAINASSIST"}})
table.insert(addon.roles, {name = "MELEE", classes = {"ROGUE", "WARRIOR"}})
table.insert(addon.roles, {name = "CASTER", classes = {"DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "SHAMAN", "WARLOCK"}})

----------------------------
--         GetRole        --
----------------------------
function addon:getRole(class, role)
    for index, value in ipairs(addon.roles) do
        if role ~= nil then
            if addon:hasValue(value.modifier, role) and addon:hasValue(value.classes, class) then return value end
        elseif value.modifier == nil and addon:hasValue(value.classes, class) then
            return value
        end
    end
    return nil
end
