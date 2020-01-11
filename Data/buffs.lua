local addonName, addon = ...

local buffs = {}

----------------------------
--          BUFFS         --
----------------------------
table.insert(buffs, addon:new_Buff({23028, 10157}, {"caster"})) --  Arcane Brilliance, Arcane Intellect
table.insert(buffs, addon:new_Buff({10174}, {"tank", "physical", "caster"})) --  Dampen Magic (Rank 5)
table.insert(buffs, addon:new_Buff({21850, 9885}, {"tank", "physical", "caster"})) --  Gift of the Wild, Mark of the Wild
table.insert(buffs, addon:new_Buff({21564, 10938}, {"tank", "physical", "caster"})) --  Prayer of Fortitude, Power Word: Fortitude
table.insert(buffs, addon:new_Buff({27683, 10958}, {"tank", "physical", "caster"})) --  Prayer of Shadow, Protection Shadow Protection
table.insert(buffs, addon:new_Buff({27681, 27841}, {"caster"})) --  Prayer of Spirit, Divine Spirit
table.insert(buffs, addon:new_Buff({9910}, {"tank"})) --  Thorns (Rank 6)

if UnitFactionGroup("player") == "Alliance" then
    table.insert(buffs, addon:new_Buff({25898, 20217}, {"tank", "physical", "caster"})) --  Blessing of Kings, Greater Blessing of Kings
    table.insert(buffs, addon:new_Buff({25782, 19838, 25916, 25291}, {"tank", "physical", "caster"})) --  Blessing of Might, Greater Blessing of Might
    table.insert(buffs, addon:new_Buff({25895, 1038}, {"physical", "caster"})) --  Blessing of Salvation, Greater Blessing of Salvation
    table.insert(buffs, addon:new_Buff({25918, 25290, 25894, 19854}, {"tank", "physical", "caster"})) --  Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(buffs, addon:new_Buff({25899, 20914}, {"tank", "physical", "caster"})) --  Blessing of Sanctuary, Greater Blessing of Sanctuary
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

