local addonName, addon = ...

addon.roles = {}

table.insert(addon.roles, {name = "TANKS", classes = {"DRUID","WARRIOR"}, modifier = {"MAINTANK", "MAINASSIST"}})
table.insert(addon.roles, {name = "MELEE", classes = {"ROGUE", "WARRIOR"}})
table.insert(addon.roles, {name = "CASTER", classes = {"DRUID","HUNTER", "MAGE","PALADIN", "PRIEST", "SHAMAN", "WARLOCK"}})

----------------------------
--         GetRole        --
----------------------------
function addon:getRole(class, raidRole)
    for index, role in ipairs(addon.roles) do
         if raidRole ~= nil then
            if addon:hasValue(role.modifier, role) and addon:hasValue(role.classes, class) then
                return role 
            end
        elseif role.modifier == nil and addon:hasValue(role.classes, class) then
            return role 
        end 
    end
    return nil
end
