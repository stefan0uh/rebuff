local addonName = ...
local addonTitle = select(2, GetAddOnInfo(addonName))

Rebuff = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Rebuff", true)

local broadcastChannels = {"RAID", "PARTY", "SAY", "PRINT"}
local defaults = {
	profile = {
        options = {
            readyCheck = false,
            channel = 4,
        },
        buffs = {
            active = false,
            TANK = {},
            MELEE = {},
            RANGE = {}
        },
        consumables = {
            active = false,
            TANK = {},
            MELEE = {},
            RANGE = {}
        },
    },
}
local options = {
    name = L["Rebuff Options"],
	descStyle = "inline",
    type = "group",
    childGroups = "tab",
    handler = Rebuff,
    args = {
        print = {
            order = 5,
            name = "Broadcast a report",
            type = "execute",
            confirm = true,
            width = "full",
            func = function () print("HI") end
        },
        options = {
            name = L["General"],
            type = "group",
            order = 1,
            args = {
                broadcasting = {
                    order = 1,
                    name = L["Broadcasting"],
                    type = "header",
                    width = "full" 
                },
                channel = {
                    order = 2,
                    name = L["Select broadcast channel"],
                    type = "select",
                    values = {"RAID", "PARTY", "SAY", "PRINT"},
                    width = "full",
                    set = "setOptions",
                    get = "getOptions",
                },
                channelDesc = {
                    order = 3,
                    name = L["Print is only for you visible."],
                    type = "description",
                    width = "full" 
                },
                settings = {
                    order = 4,
                    name = L["Extra Stuff"],
                    type = "header",
                    width = "full" 
                }, 
                readyCheck = {
                    order = 6,
                    name = L["Readycheck prompt"],
                    type = "toggle",
                    desc = L["After a readycheck a prompt appears for sharing the report."],
                    descStyle = "inline",
                    width = "full",
                    set = "setOptions",
                    get = "getOptions",
                },
            }
        },
        buffs = {
            name = L["Buffs"],
            type = "group",
            order = 2,
            args = {
                header = {
                    order = 1,
                    name = "Buff settings",
                    type = "header",
                },
                active = {
                    order = 2,
                    name = "Broadcast buffs",
                    type = "toggle",
                    width = "full",
                    set = "setActive",
                    get = "getActive",
                },
                subHead = {
                    order = 3,
                    name = "Buff overview",
                    type = "header",
                },
                TANK = {
                    order = 4,
                    name = "Buffs for TANK",
                    type = "multiselect",
                    disabled = "checkActive",
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return Rebuff:getBuffs("TANK") end
                },
                MELEE = {
                    order = 5,
                    name = "Buffs for MELEE",
                    type = "multiselect",
                    disabled = "checkActive",
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return Rebuff:getBuffs("MELEE") end
                },
                RANGE = {
                    order = 6,
                    name = "Buffs for RANGE",
                    type = "multiselect",
                    disabled = "checkActive",
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return Rebuff:getBuffs("RANGE") end
                }
            }
        },
        consumables = {
            name = L["Consumables"],
            type = "group",
            order = 3,
            args = {
                header = {
                    order = 1,
                    name = "Consumables settings",
                    type = "header",
                },
                active = {
                    order = 2,
                    name = "Broadcast Consumables",
                    type = "toggle",
                    width = "full",
                    set = "setActive",
                    get = "getActive",
                },
                subHead = {
                    order = 3,
                    name = "Consumables overview",
                    type = "header",
                },
                TANK = {
                    order = 4,
                    name = "Consumables for TANK",
                    type = "multiselect",
                    disabled = "checkActive",
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return Rebuff:getConsumables("TANK") end
                },
                MELEE = {
                    order = 5,
                    name = "Consumables for MELEE",
                    type = "multiselect",
                    disabled = "checkActive",
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return Rebuff:getConsumables("MELEE") end
                },
                RANGE = {
                    order = 6,
                    name = "Consumables for RANGE",
                    type = "multiselect",
                    disabled = "checkActive",
                    set = "setSpell",
                    get = "getSpell",
                    values = function() return Rebuff:getConsumables("RANGE") end
                }
            }
        }
    },
}

local optionsTable = LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"rb", "rebuff", "Rebuff"})
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

function Rebuff:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New(addonName .. "DB", defaults) -- set default values here as well with an additional parameter
    AceConfigDialog:AddToBlizOptions(addonName, addonTitle)
end

function Rebuff:getOptions(info)
    return Rebuff.db.profile.options[info[2]]
end

function Rebuff:setOptions(info, input)
    Rebuff.db.profile.options[info[2]] = input
end

----------------------

function Rebuff:checkActive(info)
    return not Rebuff.db.profile[info[1]].active
end

function Rebuff:getActive(info)
    return Rebuff.db.profile[info[1]].active
end

function Rebuff:setActive(info, value)
    Rebuff.db.profile[info[1]].active = value
end

function Rebuff:getSpell(info, value)
    return Rebuff:hasValue(Rebuff.db.profile[info[1]][info[2]], value)
end

function Rebuff:setSpell(info, value)
    local t = Rebuff.db.profile[info[1]][info[2]]
    if(Rebuff:hasNOTValue(t, value)) then
        table.insert(t, value)
    else
        table.remove(t, Rebuff.KeyFromValue(t,value))
    end
    Rebuff.db.profile[info[1]][info[2]] = t
end

-- Give your addon a method to pop open the config settings
function Rebuff:OpenConfig()
	InterfaceOptionsFrame_OpenToCategory(addonTitle)
	-- need to call it a second time as there is a bug where the first time it won't switch !BlizzBugsSuck has a fix
	InterfaceOptionsFrame_OpenToCategory(addonTitle)
end