local addonName, addon = ...
local addonTitle = select(2, GetAddOnInfo(addonName))

local A = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.channels = {"RAID", "PARTY", "SAY", "PRINT"}
addon.spells = {"buffs", "consumables"}

local options = {
    name = L["title"],
    descStyle = "inline",
    type = "group",
    childGroups = "tab",
    handler = addon,
    args = {
        print = {order = 5, name = L["broadCastReport"], type = "execute", confirm = false, width = "full", func = function() addon:print() end},
        -- test = {order = 5, name = "test", type = "execute", confirm = false, width = "full", func = function() addon:test() end},
        options = {
            name = L["general"],
            type = "group",
            order = 1,
            args = {
                broadcasting = {order = 1, name = L["channel"], type = "header", width = "full"},
                channel = {
                    order = 2,
                    name = L["selectChannel"],
                    desc = L["channelDescription"],
                    type = "select",
                    values = addon.channels,
                    width = "full",
                    get = function() return addon.db.profile.options.channel end,
                    set = function(info, val) addon.db.profile.options.channel = val end
                },
                settings = {order = 3, name = L["generalExtra"], type = "header", width = "full"},
                readyCheck = {
                    order = 5,
                    name = L["readycheckDialog"],
                    type = "toggle",
                    desc = L["readycheckDialogDescription"],
                    descStyle = "inline",
                    width = "full",
                    get = function() return addon.db.profile.options.readyCheck end,
                    set = function(info, val) addon.db.profile.options.readyCheck = val end
                }
            }
        },
        [addon.spells[1]] = {
            name = L[addon.spells[1]],
            type = "group",
            order = 2,
            args = {
                header = {order = 1, name = L["settings"], type = "header"},
                active = {
                    order = 2,
                    name = L["broadcast"] .. " " .. L[addon.spells[1]],
                    type = "toggle",
                    width = "full",
                    get = function() return addon.db.profile[addon.spells[1]].active end,
                    set = function(info, val) addon.db.profile[addon.spells[1]].active = val end
                },
                subHead = {order = 3, name = L["overview"], type = "header"},
                tank = {
                    order = 4,
                    name = L["tank"],
                    desc = function() return addon:getFormatedRoles("tank") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[1]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getBuffsForSelection("tank") end
                },
                physical = {
                    order = 6,
                    name = L["physical"],
                    desc = function() return addon:getFormatedRoles("physical") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[1]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getBuffsForSelection("physical") end
                },
                caster = {
                    order = 8,
                    name = L["caster"],
                    desc = function() return addon:getFormatedRoles("caster") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[1]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getBuffsForSelection("caster") end
                }
            }
        },
        [addon.spells[2]] = {
            name = L[addon.spells[2]],
            type = "group",
            order = 2,
            args = {
                header = {order = 1, name = L["settings"], type = "header"},
                active = {
                    order = 2,
                    name = L["broadcast"] .. " " .. L[addon.spells[2]],
                    type = "toggle",
                    width = "full",
                    get = function() return addon.db.profile[addon.spells[2]].active end,
                    set = function(info, val) addon.db.profile[addon.spells[2]].active = val end
                },
                subHead = {order = 3, name = L["overview"], type = "header"},
                tank = {
                    order = 4,
                    name = L["tank"],
                    desc = function() return addon:getFormatedRoles("tank") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[2]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getConsumablesForSelection("tank") end
                },
                physical = {
                    order = 6,
                    name = L["physical"],
                    desc = function() return addon:getFormatedRoles("physical") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[2]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getConsumablesForSelection("physical") end
                },
                caster = {
                    order = 8,
                    name = L["caster"],
                    desc = function() return addon:getFormatedRoles("caster") end,
                    type = "multiselect",
                    disabled = function() return not addon.db.profile[addon.spells[2]].active end,
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return addon:getConsumablesForSelection("caster") end
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
            [addon.spells[1]] = {active = false, tank = {}, physical = {}, caster = {}},
            [addon.spells[2]] = {active = false, tank = {}, physical = {}, caster = {}}
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

function addon:OnEnable() self:RegisterEvent("READY_CHECK") end

function addon:READY_CHECK()
    StaticPopupDialogs["REBUFF_PRINT"] = {
        text = L["readycheckDialogText"],
        button1 = L["yes"],
        button2 = L["no"],
        OnAccept = function() addon:print() end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    }

    if (addon.db.profile.options.readyCheck) then StaticPopup_Show("REBUFF_PRINT") end
end

function addon:OpenConfig()
    InterfaceOptionsFrame_OpenToCategory(addonTitle)
    -- need to call it a second time as there is a bug where the first time it won't switch !BlizzBugsSuck has a fix
    InterfaceOptionsFrame_OpenToCategory(addonTitle)
end

_G[addonName] = addon
