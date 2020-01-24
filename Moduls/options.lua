local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.channels = { "RAID", "PARTY", "SAY", "PRINT" }
addon.spells = { "buffs", "consumables", "worldbuffs" }

function addon:menuEntry(arr)
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
            tank = {
                order = 21,
                name = L["ROLE_TANK"],
                desc = function() return addon:getFormatedRoles("tank") end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon:getSpellsForSelection(addon[arr], "tank") end
            },
            physical = {
                order = 22,
                name = L["ROLE_PHYSICAL"],
                desc = function() return addon:getFormatedRoles("physical") end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon:getSpellsForSelection(addon[arr], "physical") end
            },
            caster = {
                order = 23,
                name = L["ROLE_CASTER"],
                desc = function() return addon:getFormatedRoles("caster") end,
                type = "multiselect",
                disabled = function() return not addon.db.profile[arr].active end,
                set = "setSpell",
                get = "getSpell",
                values = function() return addon:getSpellsForSelection(addon[arr], "caster") end
            }
        }
    }
end

addon.default = {
    profile = {
        options = { readyDialog = false, readyDirect = false, channel = 4, fullBuffedMessage = L["FULLBUFFED_MESSAGE"] },
        [addon.spells[1]] = { active = false, tank = {}, physical = {}, caster = {} },
        [addon.spells[2]] = { active = false, tank = {}, physical = {}, caster = {} },
        [addon.spells[3]] = { active = false, tank = {}, physical = {}, caster = {} }
    }
}

addon.options = {
    name = L["TITLE"],
    descStyle = "inline",
    type = "group",
    childGroups = "tab",
    handler = addon,
    args = {
        desc = { order = 10, name = "", type = "description", width = 2.5 },
        print = { order = 12, name = L["BROADCAST_ACTION"], type = "execute", confirm = true, width = 1, func = function() addon:print() end },
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
        },
        [addon.spells[1]] = addon:menuEntry(addon.spells[1]),
        [addon.spells[2]] = addon:menuEntry(addon.spells[2]),
        [addon.spells[3]] = addon:menuEntry(addon.spells[3]),
    }
}

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

