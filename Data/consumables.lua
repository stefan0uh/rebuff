local _, addon = ...

addon.consumables = {}
local buffs = addon.consumables

----------------------------

-- CONSUMABLES
----------------------------

local full_roles = { "tank", "physical", "caster" }

-- Food id's
local food = {}
table.insert(food, addon:addConsumable(21023, { 17626 }, { "tank" })) -- Increased Stamina (25)
table.insert(food, addon:addConsumable(13927, { 17628 }, { "tank" })) -- Increased Stamina (10)
table.insert(food, addon:addConsumable(13932, { 18222 }, { "tank" })) -- Health Regeneration 6hp/5
table.insert(food, addon:addConsumable(20452, { 24799 }, { "physical" })) -- Well Fed (20 Strength)
table.insert(food, addon:addConsumable(13928, { 18192 }, { "physical" })) -- Increased Agility (10)
table.insert(food, addon:addConsumable(18254, { 22730 }, { "caster" })) -- Increased Intellect (10)
table.insert(food, addon:addConsumable(13929, { 18193 }, { "caster" })) -- Increased Spirit (10)
table.insert(food, addon:addConsumable(12218, { 19710 }, { "tank", "caster" })) -- Well Fed (12 Stamina & Spirit)
table.insert(food, addon:addConsumable(25889, { 25941 }, { "caster" })) -- Well Fed (6mp/5)
table.insert(buffs, addon:createGroup("Food", food, full_roles))

-- Flask
local flask = {}
table.insert(flask, addon:addConsumable(13510, { 17626 }, { "tank" })) -- Flask of the Titans
table.insert(flask, addon:addConsumable(13511, { 17627 }, { "caster" })) -- Flask of Distilled Wisdom
table.insert(flask, addon:addConsumable(13512, { 17628 }, { "caster" })) -- Flask of Supreme Power
table.insert(flask, addon:addConsumable(13513, { 17629 }, { "tank", "physical", "caster" })) -- Flask of Chromatic Resistance
table.insert(buffs, addon:createGroup("Flask", flask, full_roles))

-- Protection Potion
local potion = {}
table.insert(potion, addon:addConsumable(13457, { 17543 }, p_roles)) -- Greater Fire Protection Potion
table.insert(potion, addon:addConsumable(13461, { 17549 }, p_roles)) -- Greater Arcane Protection Potion
table.insert(potion, addon:addConsumable(13456, { 17544 }, p_roles)) -- Greater Frost Protection Potion
table.insert(potion, addon:addConsumable(13458, { 17546 }, p_roles)) -- Greater Nature Protection Potion
table.insert(potion, addon:addConsumable(13459, { 17548 }, p_roles)) -- Greater Shadow Protection Potion
table.insert(buffs, addon:createGroup("Magic Protection Potion", potion, full_roles))

----------------------------
-- ELIXIRS        --
----------------------------

-- DEFENSE
local defense = {}
table.insert(defense, addon:addConsumable(13445, { 11348 }, d_roles)) -- Elixir of Superior Defense
table.insert(defense, addon:addConsumable(9088, { 11371 }, d_roles)) -- Gift of Arthas
table.insert(defense, addon:addConsumable(9206, { 11405 }, d_roles)) -- Elixir of the Giants
table.insert(defense, addon:addConsumable(21151, { 25804 }, d_roles)) -- Rumsey Rum Black Label
table.insert(defense, addon:addConsumable(3825, { 3593 }, d_roles)) -- Elixir of Fortitude
table.insert(buffs, addon:createGroup("Defense Elixirs", defense, full_roles))

-- PHYSCIAL
local physical = {}
local p_roles = { "tank", "physical" }
table.insert(physical, addon:addConsumable(13452, { 17538 }, p_roles)) -- Elixir of the Mongoose
table.insert(physical, addon:addConsumable(12460, { 16329 }, p_roles)) -- Juju Might
table.insert(physical, addon:addConsumable(12451, { 16323 }, p_roles)) -- Juju Power
table.insert(physical, addon:addConsumable(12820, { 17038 }, p_roles)) -- Winterfall Firewater
table.insert(buffs, addon:createGroup("Physical Elixirs", physical, p_roles))

-- CASTER
local caster = {}
local c_roles = { "caster" }
table.insert(caster, addon:addConsumable(9264, { 11474 }, c_roles, "ITEM")) -- Elixir of Shadow Power
table.insert(caster, addon:addConsumable(9155, { 11390 }, c_roles, "ITEM")) -- Arcane Elixir
table.insert(caster, addon:addConsumable(13454, { 17539 }, c_roles, "ITEM")) -- Greater Arcane Elixir
table.insert(caster, addon:addConsumable(17708, { 21920 }, c_roles, "ITEM")) -- Elixir of Frost Power
table.insert(caster, addon:addConsumable(6373, { 7844 }, c_roles, "ITEM")) -- Elixir of Firepower
table.insert(caster, addon:addConsumable(20004, { 24361 }, c_roles, "ITEM")) -- Major Troll's Blood Potion
table.insert(caster, addon:addConsumable(20007, { 24363 }, c_roles, "ITEM")) -- Mageblood Potion
table.insert(caster, addon:addConsumable(13447, { 17535 }, c_roles, "ITEM")) -- Elixir of the Sages
table.insert(buffs, addon:createGroup("Caster Elixirs", caster, c_roles))
