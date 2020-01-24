local addonName, addon = ...

addon.consumables = {}
local buffs = addon.consumables
----------------------------
--       CONSUMABLES      --
----------------------------

-- Food id's
table.insert(buffs, addon:new_Group("Food", {25661, 24799, 18191, 22730, 18194, 18222, 18192, 18193, 19710, 25941}, {"tank", "physical", "caster"}))

-- Flask
local flask = {}
table.insert(flask, addon:new_Consum(13510, {17626}, {"tank"})) -- Flask of the Titans
table.insert(flask, addon:new_Consum(13511, {17627}, {"caster"})) -- Flask of Distilled Wisdom
table.insert(flask, addon:new_Consum(13512, {17628}, {"caster"})) -- Flask of Supreme Power
table.insert(flask, addon:new_Consum(13513, {17629}, {"tank", "physical", "caster"})) -- Flask of Chromatic Resistance
table.insert(buffs, addon:new_Group("Flask", addon:spell_Remap(flask), {"tank", "physical", "caster"}))


-- Protection Potion
local potion = {}
local p_roles = {"tank", "physical", "caster"}
table.insert(potion, addon:new_Consum(13457, {17543}, p_roles)) -- Greater Fire Protection Potion
table.insert(potion, addon:new_Consum(13461, {17549}, p_roles)) -- Greater Arcane Protection Potion
table.insert(potion, addon:new_Consum(13456, {17544}, p_roles)) -- Greater Frost Protection Potion
table.insert(potion, addon:new_Consum(13458, {17546}, p_roles)) -- Greater Nature Protection Potion
table.insert(potion, addon:new_Consum(13459, {17548}, p_roles)) -- Greater Shadow Protection Potion
table.insert(buffs, addon:new_Group("Magic Protection Potion", addon:spell_Remap(potion), p_roles))

----------------------------
--         ELIXIRS        --
----------------------------

-- DEFENSE
local defense = {}
local d_roles = {"tank", "physical"}
table.insert(defense, addon:new_Consum(13445, {11348}, d_roles)) -- Elixir of Superior Defense
table.insert(defense, addon:new_Consum(9088, {11371}, d_roles)) -- Gift of Arthas
table.insert(defense, addon:new_Consum(9206, {11405}, d_roles)) -- Elixir of the Giants
table.insert(defense, addon:new_Consum(21151, {25804}, d_roles)) -- Rumsey Rum Black Label
table.insert(defense, addon:new_Consum(3825, {3593}, d_roles)) -- Elixir of Fortitude
table.insert(buffs, addon:new_Group("Defense Elixirs", addon:spell_Remap(defense), d_roles))

-- PHYSCIAL
local physical = {}
local p_roles = {"tank", "physical"}
table.insert(physical, addon:new_Consum(13452, {17538}, p_roles)) -- Elixir of the Mongoose
table.insert(physical, addon:new_Consum(12460, {16329}, p_roles)) -- Juju Might
table.insert(physical, addon:new_Consum(12451, {16323}, p_roles)) -- Juju Power
table.insert(physical, addon:new_Consum(12820, {17038}, p_roles)) -- Winterfall Firewater
table.insert(buffs, addon:new_Group("Physical Elixirs", addon:spell_Remap(physical), p_roles))

-- CASTER
local caster = {}
local c_roles = {"caster"}
table.insert(caster, addon:new_Consum(9264, {11474}, c_roles, "ITEM")) -- Elixir of Shadow Power
table.insert(caster, addon:new_Consum(9155, {11390}, c_roles, "ITEM")) -- Arcane Elixir
table.insert(caster, addon:new_Consum(13454, {17539}, c_roles, "ITEM")) -- Greater Arcane Elixir
table.insert(caster, addon:new_Consum(17708, {21920}, c_roles, "ITEM")) -- Elixir of Frost Power
table.insert(caster, addon:new_Consum(6373, {7844}, c_roles, "ITEM")) -- Elixir of Firepower
table.insert(caster, addon:new_Consum(20004, {24361}, c_roles, "ITEM")) -- Major Troll's Blood Potion
table.insert(caster, addon:new_Consum(20007, {24363}, c_roles, "ITEM")) -- Mageblood Potion
table.insert(caster, addon:new_Consum(13447, {17535}, c_roles, "ITEM")) -- Elixir of the Sages
table.insert(buffs, addon:new_Group("Caster Elixirs", addon:spell_Remap(caster), c_roles))
