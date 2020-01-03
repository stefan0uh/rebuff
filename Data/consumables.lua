local addonName, addon = ...

local consumables = {}

----------------------------
--       CONSUMABLES      --
----------------------------

-- GLOBAL
table.insert(consumables, addon:newSpell("Flasks", {17626, 17627, 17628, 17629}, {"tank", "physical", "caster"}, "GROUP"))
table.insert(consumables, addon:newSpell("Magic Protection Potion", {17543, 17549, 17544, 17546, 17548}, {"tank", "physical", "caster"}, "GROUP"))
table.insert(consumables, addon:newSpell("Food", {25661, 24799, 18191, 22730, 18194, 18222, 18192, 18193, 19710, 25941}, {"tank", "physical", "caster"}, "GROUP"))

-- ELIXIRS
table.insert(consumables, addon:newSpell("Defense Elixirs", {25804, 11348, 11371, 11405, 3593}, {"tank", "physical"}, "GROUP")) -- tank
table.insert(consumables, addon:newSpell("Physcial Elixirs", {17538, 16329, 16323, 17038}, {"tank", "physical"}, "GROUP")) -- physical 
table.insert(consumables, addon:newSpell("Caster Elixirs", {11474, 17539, 21920, 7844, 24361, 24363, 17535}, {"caster"}, "GROUP")) -- caster (caster)

-- DEFENSE
-- table.insert(consumables, addon:newSpell(13445, {11348}, {"tank"}, "ITEM")) -- Elixir of Superior Defense
-- table.insert(consumables, addon:newSpell(9088, {11371}, {"tank"}, "ITEM")) -- Gift of Arthas
-- table.insert(consumables, addon:newSpell(9206, {11405}, {"tank"}, "ITEM")) -- Elixir of the Giants
-- table.insert(consumables, addon:newSpell(21151, {25804}, {"tank", "physical", "caster"}, "ITEM")) -- Rumsey Rum Black Label

-- PHYSCIAL
-- table.insert(consumables, addon:newSpell(13452, {17538}, {"tank", "physical", "caster"}, "ITEM")) -- Elixir of the Mongoose
-- table.insert(consumables, addon:newSpell(12460, {16329}, {"tank", "physical"}, "ITEM")) -- Juju Might
-- table.insert(consumables, addon:newSpell(12451, {16323}, {"tank", "physical"}, "ITEM")) -- Juju Power
-- table.insert(consumables, addon:newSpell(12820, {17038}, {"tank", "physical"}, "ITEM")) -- Winterfall Firewater
-- table.insert(consumables, addon:newSpell(3825, {3593}, {"tank", "physical", "caster"}, "ITEM")) -- Elixir of Fortitude

-- SPELLS
-- table.insert(consumables, addon:newSpell(9264, {11474}, {"caster"}, "ITEM")) -- Elixir of Shadow Power
-- table.insert(consumables, addon:newSpell(13454, {17539}, {"caster"}, "ITEM")) -- Greater Arcane Elixir
-- table.insert(consumables, addon:newSpell(17708, {21920}, {"caster"}, "ITEM")) -- Elixir of Frost Power
-- table.insert(consumables, addon:newSpell(6373, {7844}, {"caster"}, "ITEM")) -- Elixir of Firepower
-- table.insert(consumables, addon:newSpell(20004, {24361}, {"caster"}, "ITEM")) -- Major Troll's Blood Potion

-- SURV
-- table.insert(consumables, addon:newSpell(20007, {24363}, {"caster"}, "ITEM")) -- Mageblood Potion
-- table.insert(consumables, addon:newSpell(13447, {17535}, {"caster"}, "ITEM")) -- Elixir of the Sages

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
