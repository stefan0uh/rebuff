local _, addon = ...
addon.spell = {}

local Spell = addon.spell
Spell.__index = Spell

-------------------------------
-- name     - String/Int: if GROUP, ITEM or BUFF
-- ids      - Table: spell ids
-- roles    - Table: roles
-- def      - String: Definition.
-------------------------------
function Spell.new(name, ids, roles, def)
    local self = setmetatable({}, Spell)
    self.name = name
    self.ids = ids
    self.roles = roles
    self.def = def
    return self
end

----------------------------

function addon:createGroup(name, ids, roles) return Spell.new(name, Spell:remap(ids), roles, "GROUP") end

function addon:addConsumable(item, ids, roles) return Spell.new(GetItemInfo(item), ids, roles, "CONSUM") end

function addon:addBuff(ids, roles) return Spell.new(GetSpellInfo(ids[1]), ids, roles, "BUFF") end

----------------------------
function Spell:remap(arr)
    local tmp = {}
    for _, x in ipairs(arr) do table.insert(tmp, x.ids[1]) end
    return tmp
end

----------------------------
function Spell:byId(spells, id) for _, v in pairs(spells) do if (addon:hasValue(v.ids, id)) then return v end end end

function Spell:fromArray(spells, arr)
    local tmp = {}
    for _, id in pairs(arr) do table.insert(tmp, Spell:byId(spells, id)) end
    return tmp
end

----------------------------
function Spell:forSelection(spells, role)
    local tmp = {}
    for _, v in pairs(spells) do if (addon:hasValue(v.roles, role)) then tmp[v.ids[1]] = v.name end end
    return tmp
end
