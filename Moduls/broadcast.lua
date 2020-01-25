local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.broadcast = {}
local broadcast = addon.broadcast

----------------------------

-- Broadcasting
----------------------------

function broadcast:send()
    local channel = addon.channels[addon.db.profile.options.channel]
    local spaceAmount = #addon.db.profile.options.fullBuffedMessage * 1.3
    local active = #addon.spells
    local buffed = 0

    if string.match(channel, "PRINT") or GetNumGroupMembers() > 1 then
        for _, category in ipairs(addon.spells) do
            local spell = { active = addon.db.profile[category].active, count = 0 }
            if (spell.active) then
                spell.missing = addon.group:check(category)
                for _ in pairs(spell.missing) do spell.count = spell.count + 1 end
                if (spell.count > 0) then
                    toChannel(getSpacer(spaceAmount), channel)
                    toChannel(L["MISSING_PRINT_LABEL"] .. " " .. L[category] .. ":", channel)
                    toChannel(getSpacer(spaceAmount), channel)
                    for spell, players in table.sortyByKey(spell.missing) do
                        toChannel(spell .. " (" .. #players .. "): " .. formatPlayers(players), channel)
                    end
                else
                    buffed = buffed + 1
                end
            else
                active = active - 1
            end
        end

        if active == buffed and active > 0 then
            toChannel(getSpacer(spaceAmount), channel)
            toChannel(addon.db.profile.options.fullBuffedMessage, channel)
            toChannel(getSpacer(spaceAmount), channel)
        elseif (active == 0) then
            addon:printError(L["ERROR_NOTHINGSELECTED_LABEL"], addonName)
        end
    else
        addon:printError(L["ERROR_NOPARTY"], addonName)
    end
end

----------------------------

function toChannel(text, channel)
    if (string.match(channel, "PRINT")) then
        print(text)
    else
        if not string.isEmpty(text) then SendChatMessage(text, channel) end
    end
end

----------------------------

function formatPlayers(players)
    local str = ""
    for index, v in ipairs(players) do
        if index < #players and string.len(str .. " ...") < 200 then
            str = str .. v .. ", "
        elseif string.len(str .. " ...") < 200 then
            str = str .. v
        end
    end
    if (#players > 5) then
        return str .. "..."
    else
        return str
    end
end

function getSpacer(amount)
    local str = ""
    for _ = 0, amount, 1 do
        str = str .. "-"
    end
    return str
end
