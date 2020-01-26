local _, addon = ...

addon.worldbuffs = {}
local buffs = addon.worldbuffs

----------------------------

-- World buffs
----------------------------

-- Rend Buff
if UnitFactionGroup("player") == "Horde" then
    table.insert(buffs, addon:addBuff({ 16609 }, { "tank", "physical", "caster" })) --  Warchief's Blessing
end

-- Onyixa / Nefarian - Head
table.insert(buffs, addon:addBuff({ 22888 }, { "tank", "physical", "caster" })) --  Rallying Cry of the Dragonslayer

-- Zul'Gurub - The Heart of Hakkar
table.insert(buffs, addon:addBuff({ 24425 }, { "tank", "physical", "caster" })) --  Spirit of Zandalar

-- Felwood Buff
table.insert(buffs, addon:addBuff({ 15366 }, { "physical", "caster" })) --  Songflower Serenade

-- Dire Maul Buffs
table.insert(buffs, addon:addBuff({ 22818 }, { "tank", "physical", "caster" })) --  Mol'dar's Moxie
table.insert(buffs, addon:addBuff({ 22817 }, { "tank", "physical" })) --  Fengus' Ferocity
table.insert(buffs, addon:addBuff({ 22820 }, { "caster" })) --  Slip'kik's Savvy

-- Darkmoon Faire Fortune Buffs
local darkmoon = {}
local d_roles = { "tank", "physical", "caster" }
table.insert(darkmoon, addon:addBuff({ 17543 }, d_roles)) -- Sayge's Dark Fortune of Damage
table.insert(darkmoon, addon:addBuff({ 23769 }, d_roles)) -- Sayge's Dark Fortune of Resistance
table.insert(darkmoon, addon:addBuff({ 23767 }, d_roles)) -- Sayge's Dark Fortune of Armor
table.insert(darkmoon, addon:addBuff({ 23766 }, d_roles)) -- Sayge's Dark Fortune of Intelligence
table.insert(darkmoon, addon:addBuff({ 23738 }, d_roles)) -- Sayge's Dark Fortune of Spirit
table.insert(darkmoon, addon:addBuff({ 23737 }, d_roles)) -- Sayge's Dark Fortune of Stamina
table.insert(darkmoon, addon:addBuff({ 23735 }, d_roles)) -- Sayge's Dark Fortune of Strength
table.insert(darkmoon, addon:addBuff({ 23736 }, d_roles)) -- Sayge's Dark Fortune of Agility
table.insert(buffs, addon:createGroup("Darkmoon Faire Fortune Buffs", darkmoon, d_roles))
