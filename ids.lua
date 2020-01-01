local addonName, addon = ...

addon.ids = {}
addon.ids.buffs = {}
addon.ids.consumables = {}

----------------------------
--          BUFFS         --
----------------------------
table.insert(addon.ids.buffs, {name = GetSpellInfo(23028), ids = {23028, 10157}, roles = {"CASTER"}}) --  Arcane Brilliance Arcane Intellect
table.insert(addon.ids.buffs, {name = GetSpellInfo(10174), ids = {10174}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Dampen Magic (Rank 5)
table.insert(addon.ids.buffs, {name = GetSpellInfo(21850), ids = {21850, 9885}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Gift of the Wild Mark of the Wild
table.insert(addon.ids.buffs, {name = GetSpellInfo(21564), ids = {21564, 10938}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Prayer of Fortitude Power Word: Fortitude
table.insert(addon.ids.buffs, {name = GetSpellInfo(27683), ids = {27683, 10958}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Prayer of Shadow Protection Shadow Protection
table.insert(addon.ids.buffs, {name = GetSpellInfo(27681), ids = {27681, 27841}, roles = {"CASTER"}}) --  Prayer of Spirit Divine Spirit
table.insert(addon.ids.buffs, {name = GetSpellInfo(9910), ids = {9910}, roles = {"TANKS"}}) --  Thorns (Rank 6)

if UnitFactionGroup("player") == "Alliance" then
    table.insert(addon.ids.buffs, {name = GetSpellInfo(25898), ids = {25898, 20217}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Blessing of Kings, Greater Blessing of Kings
    table.insert(addon.ids.buffs, {name = GetSpellInfo(25916), ids = {25916, 25291}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Blessing of Might, Greater Blessing of Might
    table.insert(addon.ids.buffs, {name = GetSpellInfo(25895), ids = {25895, 1038}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Blessing of Salvation, Greater Blessing of Salvation
    table.insert(addon.ids.buffs, {name = GetSpellInfo(25918), ids = {25918, 25290}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(addon.ids.buffs, {name = GetSpellInfo(25899), ids = {25899, 20914}, roles = {"TANKS", "MELEE", "CASTER"}}) --  Blessing of Sanctuary, Greater Blessing of Sanctuary
end

-- ----------------------------
-- --       CONSUMABLES      --
-- ----------------------------
-- table.insert(addon.ids.consumables, {name = "Flasks", ids = {17626, 17627, 17628, 17629}, roles = {"TANKS", "MELEE", "CASTER"}})
-- table.insert(addon.ids.consumables, {name = "Protection Potion", ids = {17543, 17549, 17544, 17546, 17548}, roles = {"TANKS", "MELEE", "CASTER"}})
-- table.insert(addon.ids.consumables, {name = "Elixirs", ids = {17543, 17549, 17544, 17546, 17548}, roles = {"TANKS", "MELEE", "CASTER"}})
