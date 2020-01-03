local addonName, addon = ...

local consumables = {}

----------------------------
--       CONSUMABLES      --
----------------------------
table.insert(consumables, addon:newSpell("Flasks", {17626, 17627, 17628, 17629}, {"TANK", "MELEE", "RANGE"}, "CONSUM"))
table.insert(consumables, addon:newSpell("Magic Protection Potion", {17543, 17549, 17544, 17546, 17548}, {"TANK", "MELEE", "RANGE"}, "CONSUM"))
-- table.insert(consumables, addon:newSpell("Elixirs", {13454}, {"RANGE"}))
-- table.insert(consumables, addon:newSpell("Elixirs", {17538}, {"MELEE"}))
-- table.insert(consumables, addon:newSpell("Elixirs", {11348}, {"TANK"}))
-- table.insert(consumables, addon:newSpell("Food", {123}, {"RANGE"}))
-- table.insert(consumables, addon:newSpell("Food", {123}, {"MELEE"}))
-- table.insert(consumables, addon:newSpell("Food", {123}, {"TANK"}))

----------------------------

function addon:getConsumablesFromArray(arr)
    local tmp = {}
    for k, id in pairs(arr) do table.insert(tmp, addon:getConsumablesById(id)) end
    return tmp
end

function addon:getConsumablesById(id) for k, v in pairs(consumables) do if (addon:hasValue(v.ids, id)) then return v end end end

----------------------------

function addon:getConsumablesForSelection(role)
    local tmp = {}
    for k, v in pairs(consumables) do if (addon:hasValue(v.roles, role)) then tmp[v.ids[1]] = v.name end end
    return tmp
end
