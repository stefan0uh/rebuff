local addonName, addon = ...
local options = {}
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

----------------------------

-- Options
----------------------------

addon.channels = { "RAID", "PARTY", "SAY", "PRINT" }
addon.spells = { "buffs", "consumables", "worldbuffs" }

----------------------------

function defaultEntry()
    local default = {}
    default.profile = {}
    default.profile.options = {
        readyDialog = false,
        readyDirect = false,
        channel = 4,
        fullBuffedMessage = L["FULLBUFFED_MESSAGE"]
    }

    for _, v in ipairs(addon.spells) do
        default.profile[v] = { active = false, [addon.role.tank.name] = {}, [addon.role.physical.name] = {}, [addon.role.caster.name] = {} }
    end
    return default
end

function spellEntry(arr)
    return {
        name = L[arr],
        type = "group",
        order = 100,
        args = {
            head = { order = 10, name = L["SPELL_SETTING_HEADLINE"], type = "header" },
            active = {
                order = 11,
                name = L["SPELL_BROADCAST_LABEL"] .. " " .. L[arr],
                type = "toggle",
                width = "full",
                get = function() return addon.db.profile[arr].active end,
                set = function(_, val) addon.db.profile[arr].active = val end
            },
            subHead = { order = 20, name = L["SPELL_OVERVIEW_HEADLINE"], type = "header" },
            [addon.role.tank.name] = {
                order = 21,
                name = L["ROLE_TANK"],
                desc = function() return addon.roles:getFormated(addon.role.tank.name) end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon.spell:forSelection(addon[arr], addon.role.tank.name) end
            },
            [addon.role.physical.name] = {
                order = 22,
                name = L["ROLE_PHYSICAL"],
                desc = function() return addon.roles:getFormated(addon.role.physical.name) end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon.spell:forSelection(addon[arr], addon.role.physical.name) end
            },
            [addon.role.caster.name] = {
                order = 23,
                name = L["ROLE_CASTER"],
                desc = function() return addon.roles:getFormated(addon.role.caster.name) end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon.spell:forSelection(addon[arr], addon.role.caster.name) end
            }
        }
    }
end

function optionsEntry()
    local options = {
        name = L["TITLE"],
        descStyle = "inline",
        type = "group",
        childGroups = "tab",
        handler = options,
        args = {
            desc = { order = 10, name = "", type = "description", width = 2.5 },
            print = { order = 11, name = L["BROADCAST_ACTION"], type = "execute", confirm = true, width = 1, func = function() addon.broadcast:send() end },
            spacer = { order = 12, name = "", type = "header", width = "full" },
            options = {
                name = L["GENERAL_TAB"],
                type = "group",
                order = 20,
                args = {
                    head_1 = { order = 10, name = L["CHANNEL_HEADLINE"], type = "header", width = "full" },
                    channel = {
                        order = 11,
                        name = L["CHANNEL_SELECT_LABEL"],
                        desc = L["CHANNEL_DESCRIPTION"],
                        type = "select",
                        values = addon.channels,
                        width = "full",
                        get = function() return addon.db.profile.options.channel end,
                        set = function(_, val) addon.db.profile.options.channel = val end
                    },
                    desc_1 = { order = 12, name = L["CHANNEL_DESCRIPTION"], type = "description", width = "full" },
                    head_2 = { order = 20, name = L["READYCHECK_HEADLINE"], type = "header", width = "full" },
                    readyDialog = {
                        order = 21,
                        name = L["READYCHECK_DIALOG_LABEL"],
                        type = "toggle",
                        desc = L["READYCHECK_DIALOG_DESCRIPTION"],
                        descStyle = "inline",
                        disabled = function() return addon.db.profile.options.readyDirect end,
                        width = "full",
                        get = function() return addon.db.profile.options.readyDialog end,
                        set = function(_, val) addon.db.profile.options.readyDialog = val end
                    },
                    readyDirect = {
                        order = 22,
                        name = L["READYCHECK_DIRECT_LABEL"],
                        type = "toggle",
                        desc = L["READYCHECK_DIRECT_DESCRIPTION"],
                        descStyle = "inline",
                        width = "full",
                        disabled = function() return addon.db.profile.options.readyDialog end,
                        get = function() return addon.db.profile.options.readyDirect end,
                        set = function(_, val) addon.db.profile.options.readyDirect = val end
                    },
                    head_3 = { order = 30, name = L["EXTRA_HEADLINE"], type = "header", width = "full" },
                    fullBuffedMessage = {
                        order = 32,
                        name = L["FULLBUFFED_LABEL"],
                        type = "input",
                        desc = L["FULLBUFFED_DESCRIPTION"],
                        -- descStyle = "inline",
                        width = "full",
                        get = function() return addon.db.profile.options.fullBuffedMessage end,
                        set = function(_, val) addon.db.profile.options.fullBuffedMessage = val end
                    },
                    head_5 = { order = 50, name = L["RESET_HEADLINE"], type = "header", width = "full" },
                    reset = { order = 51, name = L["RESET_ACTION"], type = "execute", confirm = true, width = "full", func = function() addon.db:ResetProfile() end },
                    desc_5 = { order = 52, name = L["RESET_DESCRIPTION"], type = "description", width = "full" }
                }
            }
        }
    }

    for _, v in ipairs(addon.spells) do
        options.args[v] = spellEntry(v)
    end

    return options
end

----------------------------

addon.default = defaultEntry()
addon.options = optionsEntry()

----------------------------

function options:getSpell(info, value) return table.includes(value, addon.db.profile[info[1]][info[2]]) end

function options:setSpell(info, value)
    local db = addon.db.profile[info[1]][info[2]]
    if not table.includes(value, db) then
        table.insert(db, value)
    else
        table.remove(db, table.getKeyFromValue(db, value))
    end
end

