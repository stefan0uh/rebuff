local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

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
        default.profile[v] = { active = false, [addon.roles.tank.name] = {}, [addon.roles.physical.name] = {}, [addon.roles.caster.name] = {} }
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
            [addon.roles.tank.name] = {
                order = 21,
                name = L["ROLE_TANK"],
                desc = function() return addon.roles:getFormated(addon.roles.tank.name) end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon.spell:forSelection(addon[arr], addon.roles.tank.name) end
            },
            [addon.roles.physical.name] = {
                order = 22,
                name = L["ROLE_PHYSICAL"],
                desc = function() return addon.roles:getFormated(addon.roles.physical.name) end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon.spell:forSelection(addon[arr], addon.roles.physical.name) end
            },
            [addon.roles.caster.name] = {
                order = 23,
                name = L["ROLE_CASTER"],
                desc = function() return addon.roles:getFormated(addon.roles.caster.name) end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon.spell:forSelection(addon[arr], addon.roles.caster.name) end
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
        handler = addon,
        args = {
            desc = { order = 10, name = "", type = "description", width = 2.5 },
            print = { order = 11, name = L["BROADCAST_ACTION"], type = "execute", confirm = true, width = 1, func = function() addon:print() end },
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
                    head_5 = { order = 50, name = L["RESET"], type = "header", width = "full" },
                    reset = { order = 51, name = L["RESET_OPTIONS"], type = "execute", confirm = true, width = "full", func = function() addon.db:ResetProfile() end }
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

function addon:getSpell(info, value) return addon:hasValue(addon.db.profile[info[1]][info[2]], value) end

function addon:setSpell(info, value)
    local t = addon.db.profile[info[1]][info[2]]
    if (addon:hasNOTValue(t, value)) then
        table.insert(t, value)
    else
        table.remove(t, addon.KeyFromValue(t, value))
    end
    addon.db.profile[info[1]][info[2]] = t
end

