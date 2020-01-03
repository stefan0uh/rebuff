local addonName, addon = ...
local addonTitle = select(2, GetAddOnInfo(addonName))

local A = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.broadcastChannels = {"RAID", "PARTY", "SAY", "PRINT"}
addon.spells = {"BUFFS", "CONSUMABLES"}

local options = {
    name = L["Rebuff Options"],
    descStyle = "inline",
    type = "group",
    childGroups = "tab",
    handler = addon,
    args = {
        print = {order = 5, name = "Broadcast a report", type = "execute", confirm = false, width = "full", func = function() addon:print() end},
        options = {
            name = L["General"],
            type = "group",
            order = 1,
            args = {
                broadcasting = {order = 1, name = L["Broadcasting"], type = "header", width = "full"},
                channel = {
                    order = 2,
                    name = L["Select broadcast channel"],
                    type = "select",
                    values = addon.broadcastChannels,
                    width = "full",
                    get = function() return addon.db.profile.options.channel end,
                    set = function(info, val) addon.db.profile.options.channel = val end
                },
                channelDesc = {order = 3, name = L["Print is only for you visible."], type = "description", width = "full"},
                settings = {order = 4, name = L["Extra Stuff"], type = "header", width = "full"},
                readyCheck = {
                    order = 6,
                    name = L["Readycheck prompt"],
                    type = "toggle",
                    desc = L["After a readycheck a prompt appears for sharing the report."],
                    descStyle = "inline",
                    width = "full",
                    get = function() return addon.db.profile.options.readyCheck end,
                    set = function(info, val) addon.db.profile.options.readyCheck = val end
                }
            }
        },
        [addon.spells[1]] = {
            name = "Buffs",
            type = "group",
            order = 2,
            args = {
                header = {order = 1, name = "Settings", type = "header"},
                active = {
                    order = 2,
                    name = "Broadcast buffs",
                    type = "toggle",
                    width = "full",
                    get = function() return addon.db.profile[addon.spells[1]].active end,
                    set = function(info, val) addon.db.profile[addon.spells[1]].active = val end
                },
                subHead = {order = 3, name = "Overview", type = "header"},
                TANK = {
                    order = 4,
                    name = function() return "Tanking " .. addon:getFormatedRoles("TANK") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[1]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getBuffsForSelection("TANK") end
                },
                MELEE = {
                    order = 5,
                    name = function() return "Melee " .. addon:getFormatedRoles("MELEE") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[1]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getBuffsForSelection("MELEE") end
                },
                RANGE = {
                    order = 6,
                    name = function() return "Range " .. addon:getFormatedRoles("RANGE") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[1]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getBuffsForSelection("RANGE") end
                }
            }
        },
        [addon.spells[2]] = {
            name = "Consumables",
            type = "group",
            order = 3,
            args = {
                header = {order = 1, name = "Settings", type = "header"},
                active = {
                    order = 2,
                    name = "Broadcast consumables",
                    type = "toggle",
                    width = "full",
                    get = function() return addon.db.profile[addon.spells[2]].active end,
                    set = function(info, val) addon.db.profile[addon.spells[2]].active = val end
                },
                subHead = {order = 3, name = "Overview", type = "header"},
                TANK = {
                    order = 4,
                    name = function() return "Tanking " .. addon:getFormatedRoles("TANK") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[2]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getConsumablesForSelection("TANK") end
                },
                MELEE = {
                    order = 5,
                    name = function() return "Melee " .. addon:getFormatedRoles("MELEE") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[2]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getConsumablesForSelection("MELEE") end
                },
                RANGE = {
                    order = 6,
                    name = function() return "Range " .. addon:getFormatedRoles("RANGE") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[2]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getConsumablesForSelection("RANGE") end
                }
            }
        }
    }
}
----------------------

function addon:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"rb", "rebuff", "Rebuff"})
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addonTitle)

    self.db = LibStub("AceDB-3.0"):New(addonName .. "DB", {
        profile = {
            options = {readyCheck = false, channel = 4},
            [addon.spells[1]] = {active = false, TANK = {}, MELEE = {}, RANGE = {}},
            [addon.spells[2]] = {active = false, TANK = {}, MELEE = {}, RANGE = {}}
        }
    })
end

function addon:getSpell(info, value) return Rebuff:hasValue(Rebuff.db.profile[info[1]][info[2]], value) end

function addon:setSpell(info, value)
    local t = Rebuff.db.profile[info[1]][info[2]]
    if (Rebuff:hasNOTValue(t, value)) then
        table.insert(t, value)
    else
        table.remove(t, Rebuff.KeyFromValue(t, value))
    end
    Rebuff.db.profile[info[1]][info[2]] = t
end

----------------------

function addon:OpenConfig()
    InterfaceOptionsFrame_OpenToCategory(addonTitle)
    -- need to call it a second time as there is a bug where the first time it won't switch !BlizzBugsSuck has a fix
    InterfaceOptionsFrame_OpenToCategory(addonTitle)
end

_G[addonName] = addon
