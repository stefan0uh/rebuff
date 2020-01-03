local addonName, addon = ...

local buffs = {}

----------------------------
--          BUFFS         --
----------------------------
table.insert(buffs, addon:newSpell("INT", {23028, 10157}, {"CASTER"})) --  Arcane Brilliance Arcane Intellect
table.insert(buffs, addon:newSpell("DPM", {10174}, {"TANK", "PHYSICAL", "CASTER"})) --  Dampen Magic (Rank 5)
table.insert(buffs, addon:newSpell("DPM", {10174}, {"TANK", "PHYSICAL", "CASTER"}))
table.insert(buffs, addon:newSpell("MOT", {21850, 9885}, {"TANK", "PHYSICAL", "CASTER"})) --  Gift of the Wild Mark of the Wild
table.insert(buffs, addon:newSpell("STA", {21564, 10938}, {"TANK", "PHYSICAL", "CASTER"})) --  Prayer of Fortitude Power Word: Fortitude
table.insert(buffs, addon:newSpell("SHA", {27683, 10958}, {"TANK", "PHYSICAL", "CASTER"})) --  Prayer of Shadow Protection Shadow Protection
table.insert(buffs, addon:newSpell("SPI", {27681, 27841}, {"CASTER"})) --  Prayer of Spirit Divine Spirit
table.insert(buffs, addon:newSpell("THO", {9910}, {"TANK"})) --  Thorns (Rank 6)

if UnitFactionGroup("player") == "Alliance" then
    table.insert(buffs, addon:newSpell("KINGS", {25898, 20217}, {"TANK", "PHYSICAL", "CASTER"})) --  Blessing of Kings, Greater Blessing of Kings
    table.insert(buffs, addon:newSpell("MIGHT", {25916, 25291}, {"TANK", "PHYSICAL", "CASTER"})) --  Blessing of Might, Greater Blessing of Might
    table.insert(buffs, addon:newSpell("SALVA", {25895, 1038}, {"PHYSICAL", "CASTER"})) --  Blessing of Salvation, Greater Blessing of Salvation
    table.insert(buffs, addon:newSpell("WISDO", {25918, 25290}, {"TANK", "PHYSICAL", "CASTER"})) --  Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(buffs, addon:newSpell("SANCT", {25899, 20914}, {"TANK", "PHYSICAL", "CASTER"})) --  Blessing of Sanctuary, Greater Blessing of Sanctuary
end

----------------------------

function addon:getBuffsFromArray(arr)
    local tmp = {}
    for k, id in pairs(arr) do table.insert(tmp, addon:getBuffsById(id)) end
    return tmp
end

function addon:getBuffsById(id) for k, v in pairs(buffs) do if (addon:hasValue(v.ids, id)) then return v end end end

----------------------------

function addon:getBuffsForSelection(role)
    local tmp = {}
    for k, v in pairs(buffs) do if (addon:hasValue(v.roles, role)) then tmp[v.ids[1]] = GetSpellInfo(v.ids[1]) end end
    return tmp
end

