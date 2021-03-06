local _, addon = ...

addon.consumables = {}
local buffs = addon.consumables

----------------------------

-- CONSUMABLES
----------------------------

local full_roles = { "tank", "physical", "caster" }

-- Food id's
local food = {}
table.insert(food, addon:addConsumable(21023, { 25661 }, { "tank" })) -- Increased Stamina (25) - Dirge's Kickin' Chimaerok Chops
table.insert(food, addon:addConsumable(12218, { 19710 }, { "tank", "caster" })) -- Well Fed (12 Stamina & Spirit) - Monster Omelet
table.insert(food, addon:addConsumable(13927, { 18191 }, { "tank" })) -- Increased Stamina (10) - Cooked Glossy Mightfish
table.insert(food, addon:addConsumable(13932, { 18222 }, { "tank" })) -- Health Regeneration 6hp/5 - Poached Sunscale Salmon
table.insert(food, addon:addConsumable(20452, { 24799 }, { "physical" })) -- Well Fed (20 Strength) - Smoked Desert Dumplings
table.insert(food, addon:addConsumable(13928, { 18192 }, { "physical" })) -- Increased Agility (10) - Grilled Squid
table.insert(food, addon:addConsumable(18254, { 22730 }, { "caster" })) -- Increased Intellect (10) - Runn Tum Tuber Surprise
table.insert(food, addon:addConsumable(13929, { 18193 }, { "caster" })) -- Increased Spirit (10) - Hot Smoked Bass
table.insert(food, addon:addConsumable(13931, { 18194 }, { "caster" })) -- Well Fed (8mp/5) - Nightfin Soup
table.insert(food, addon:addConsumable(21217, { 25941 }, { "caster" })) -- Well Fed (6mp/5) - Sagefish Delight
table.insert(buffs, addon:createGroup("Food", food, full_roles))

-- Blasted Lands
local blasted = {}
table.insert(blasted, addon:addConsumable(8423, { 10692 }, { "caster" })) -- Cerebral Cortex Compound
table.insert(blasted, addon:addConsumable(8424, { 10693 }, { "caster" })) -- Gizzard Gum
table.insert(blasted, addon:addConsumable(8411, { 10668 }, full_roles)) -- Lung Juice Cocktail
table.insert(buffs, addon:createGroup("Blasted Land Consumables", blasted, full_roles))

-- Zul'Gurub Zanzas
local zanzas = {}
table.insert(zanzas, addon:addConsumable(20079, { 24382 }, full_roles)) -- Spirit of Zanza
table.insert(zanzas, addon:addConsumable(20080, { 24417 }, full_roles)) -- Sheen of Zanza
table.insert(zanzas, addon:addConsumable(20081, { 24383 }, full_roles)) -- Swiftness of Zanza
table.insert(buffs, addon:createGroup("Zul'Gurub Zanzas", zanzas, full_roles))

-- Drinks
local drinks = {}
table.insert(drinks, addon:addConsumable(21151, { 25804 }, p_roles)) -- Rumsey Rum Black Label
table.insert(drinks, addon:addConsumable(21114, { 25722 }, p_roles)) -- Rumsey Rum Dark
table.insert(drinks, addon:addConsumable(18269, { 22789 }, p_roles)) -- Gordok Green Grog
table.insert(drinks, addon:addConsumable(18284, { 22790 }, p_roles)) -- Kreeg's Stout Beatdown
table.insert(buffs, addon:createGroup("Rumsey/Gordok", drinks, full_roles))


-- JuJu Physical
local jujuP = {}
table.insert(jujuP, addon:addConsumable(12460, { 16329 }, {"tank", "physical"})) -- Juju Might
table.insert(jujuP, addon:addConsumable(12451, { 16323 }, {"tank", "physical"})) -- Juju Power
table.insert(buffs, addon:createGroup("Juju Physical", jujuP, {"tank", "physical"}))

-- JuJu Resistance
local jujuP = {}
table.insert(jujuP, addon:addConsumable(12457, { 16325 }, full_roles)) -- Juju Chill
table.insert(jujuP, addon:addConsumable(12455, { 16326 }, full_roles)) -- Juju Ember
table.insert(buffs, addon:createGroup("Juju Resistance", jujuP, full_roles))

-- Protection Potion
local potion = {}
table.insert(potion, addon:addConsumable(13457, { 17543 }, p_roles)) -- Greater Fire Protection Potion
table.insert(potion, addon:addConsumable(13461, { 17549 }, p_roles)) -- Greater Arcane Protection Potion
table.insert(potion, addon:addConsumable(13456, { 17544 }, p_roles)) -- Greater Frost Protection Potion
table.insert(potion, addon:addConsumable(13458, { 17546 }, p_roles)) -- Greater Nature Protection Potion
table.insert(potion, addon:addConsumable(13459, { 17548 }, p_roles)) -- Greater Shadow Protection Potion
table.insert(buffs, addon:createGroup("Magic Protection Potion", potion, full_roles))

-- Flask
local flask = {}
table.insert(flask, addon:addConsumable(13510, { 17626 }, { "tank" })) -- Flask of the Titans
table.insert(flask, addon:addConsumable(13511, { 17627 }, { "caster" })) -- Flask of Distilled Wisdom
table.insert(flask, addon:addConsumable(13512, { 17628 }, { "caster" })) -- Flask of Supreme Power
table.insert(flask, addon:addConsumable(13513, { 17629 }, full_roles)) -- Flask of Chromatic Resistance
table.insert(buffs, addon:createGroup("Flask", flask, full_roles))

----------------------------
-- ELIXIRS        --
----------------------------

-- DEFENSE
local defense = {}
table.insert(defense, addon:addConsumable(13445, { 11348 }, d_roles)) -- Elixir of Superior Defense
table.insert(defense, addon:addConsumable(9088, { 11371 }, d_roles)) -- Gift of Arthas
table.insert(defense, addon:addConsumable(9206, { 11405 }, d_roles)) -- Elixir of the Giants
table.insert(defense, addon:addConsumable(3825, { 3593 }, d_roles)) -- Elixir of Fortitude
table.insert(defense, addon:addConsumable(13445, { 11348 }, d_roles)) -- Elixir of Superior Defense
table.insert(defense, addon:addConsumable(20004, { 24361 }, c_roles)) -- Major Troll's Blood Potion
table.insert(buffs, addon:createGroup("Defense Elixirs", defense, full_roles))

-- PHYSCIAL
local physical = {}
local p_roles = { "tank", "physical" }
table.insert(physical, addon:addConsumable(13452, { 17538 }, p_roles)) -- Elixir of the Mongoose
table.insert(physical, addon:addConsumable(12820, { 17038 }, p_roles)) -- Winterfall Firewater
table.insert(physical, addon:addConsumable(9206, { 11405 }, p_roles)) -- Elixir of Giants
table.insert(buffs, addon:createGroup("Physical Elixirs", physical, p_roles))

-- CASTER
local caster = {}
local c_roles = { "caster" }
table.insert(caster, addon:addConsumable(21546, { 26276 }, c_roles)) -- Elixir of Greater Firepower
table.insert(caster, addon:addConsumable(6373, { 7844 }, c_roles)) -- Elixir of Firepower
table.insert(caster, addon:addConsumable(9264, { 11474 }, c_roles)) -- Elixir of Shadow Power
table.insert(caster, addon:addConsumable(17708, { 21920 }, c_roles)) -- Elixir of Frost Power
table.insert(caster, addon:addConsumable(13454, { 17539 }, c_roles)) -- Greater Arcane Elixir
table.insert(caster, addon:addConsumable(9155, { 11390 }, c_roles)) -- Arcane Elixir
table.insert(caster, addon:addConsumable(20007, { 24363 }, c_roles)) -- Mageblood Potion
table.insert(buffs, addon:createGroup("Caster Elixirs", caster, c_roles))
