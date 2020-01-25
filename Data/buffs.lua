local _, addon = ...

addon.buffs = {}
local buffs = addon.buffs

----------------------------

-- BUFFS
----------------------------

-- Mage
table.insert(buffs, addon:addBuff({ 23028, 10157 }, { "caster" })) --  Arcane Brilliance, Arcane Intellect
table.insert(buffs, addon:addBuff({ 10174 }, { "tank", "physical", "caster" })) --  Dampen Magic (Rank 5)

-- Druid
table.insert(buffs, addon:addBuff({ 21850, 9885 }, { "tank", "physical", "caster" })) --  Gift of the Wild, Mark of the Wild
table.insert(buffs, addon:addBuff({ 9910 }, { "tank" })) --  Thorns (Rank 6)

-- Priest
table.insert(buffs, addon:addBuff({ 21564, 10938 }, { "tank", "physical", "caster" })) --  Prayer of Fortitude, Power Word: Fortitude
table.insert(buffs, addon:addBuff({ 27683, 10958 }, { "tank", "physical", "caster" })) --  Prayer of Shadow, Protection Shadow Protection
table.insert(buffs, addon:addBuff({ 27681, 27841 }, { "caster" })) --  Prayer of Spirit, Divine Spirit

-- Paladin
if UnitFactionGroup("player") == "Alliance" then
    table.insert(buffs, addon:addBuff({ 25898, 20217 }, { "tank", "physical", "caster" })) --  Blessing of Kings, Greater Blessing of Kings
    table.insert(buffs, addon:addBuff({ 25782, 19838, 25916, 25291 }, { "tank", "physical", "caster" })) --  Blessing of Might, Greater Blessing of Might
    table.insert(buffs, addon:addBuff({ 25895, 1038 }, { "physical", "caster" })) --  Blessing of Salvation, Greater Blessing of Salvation
    table.insert(buffs, addon:addBuff({ 25918, 25290, 25894, 19854 }, { "tank", "physical", "caster" })) --  Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(buffs, addon:addBuff({ 25899, 20914 }, { "tank", "physical", "caster" })) --  Blessing of Sanctuary, Greater Blessing of Sanctuary
end
