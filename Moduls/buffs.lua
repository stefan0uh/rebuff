local addonName, addon = ...

local buffs = {}

----------------------------
--          BUFFS         --
----------------------------
table.insert(buffs, addon:newSpell("INT", {23028, 10157}, {"RANGE"})) --  Arcane Brilliance Arcane Intellect
table.insert(buffs, addon:newSpell("DPM", {10174}, {"TANK", "MELEE", "RANGE"})) --  Dampen Magic (Rank 5)
table.insert(buffs, addon:newSpell("DPM", {10174}, {"TANK", "MELEE", "RANGE"}))
table.insert(buffs, addon:newSpell("MOT", {21850, 9885}, {"TANK", "MELEE", "RANGE"})) --  Gift of the Wild Mark of the Wild
table.insert(buffs, addon:newSpell("STA", {21564, 10938}, {"TANK", "MELEE", "RANGE"})) --  Prayer of Fortitude Power Word: Fortitude
table.insert(buffs, addon:newSpell("SHA", {27683, 10958}, {"TANK", "MELEE", "RANGE"})) --  Prayer of Shadow Protection Shadow Protection
table.insert(buffs, addon:newSpell("SPI", {27681, 27841}, {"RANGE"})) --  Prayer of Spirit Divine Spirit
table.insert(buffs, addon:newSpell("THO", {9910}, {"TANK"})) --  Thorns (Rank 6)

if UnitFactionGroup("player") == "Alliance" then
    table.insert(buffs, addon:newSpell("KINGS", {25898, 20217}, {"TANK", "MELEE", "RANGE"})) --  Blessing of Kings, Greater Blessing of Kings
    table.insert(buffs, addon:newSpell("MIGHT", {25916, 25291}, {"TANK", "MELEE", "RANGE"})) --  Blessing of Might, Greater Blessing of Might
    table.insert(buffs, addon:newSpell("SALVA", {25895, 1038}, {"MELEE", "RANGE"})) --  Blessing of Salvation, Greater Blessing of Salvation
    table.insert(buffs, addon:newSpell("WISDO", {25918, 25290}, {"TANK", "MELEE", "RANGE"})) --  Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(buffs, addon:newSpell("SANCT", {25899, 20914}, {"TANK", "MELEE", "RANGE"})) --  Blessing of Sanctuary, Greater Blessing of Sanctuary
end

function addon:test() return buffs[1].localized end

function addon:getBuffs(role)
    local tmp = {}
    for k, v in pairs(buffs) do if (addon:hasValue(v.roles, role)) then tmp[v.ids[1]] = GetSpellInfo(v.ids[1]) end end
    return tmp
end

