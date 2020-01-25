local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

addon.broadcast = {}
local broadcast = addon.broadcast

----------------------------

-- Broadcasting
----------------------------

function broadcast:send()
    local channel = addon.channels[addon.db.profile.options.channel]
    local spacerAmount = #addon.db.profile.options.fullBuffedMessage + (#addon.db.profile.options.fullBuffedMessage / 3 )
    local active = #addon.spells
    local buffed = 0

    for _, category in ipairs(addon.spells) do
        local spell = { active = addon.db.profile[category].active, count = 0 }
        if (spell.active) then
            spell.missing = addon.group:check(category)
            for _ in pairs(spell.missing) do spell.count = spell.count + 1 end
            if (spell.count > 0) then
                toChannel(getSpacer(spacerAmount), channel)
                toChannel(L["MISSING_PRINT_LABEL"] .. " " .. category .. ":", channel)
                toChannel(getSpacer(spacerAmount), channel)
                for spell, players in table.sortyByKey(spell.missing) do
                    local str = spell .. " (" .. #players .. ")"
                    toChannel(str .. ": " .. formatPlayers(players), channel)
                end
            else
                buffed = buffed + 1
            end
        else
            active = active - 1
        end
    end

    if active == buffed and active > 0 then
        toChannel(getSpacer(spacerAmount), channel)
        toChannel(addon.db.profile.options.fullBuffedMessage, channel)
        toChannel(getSpacer(spacerAmount), channel)
    elseif (active == 0) then
        addon:printError(addonName .. " |r" .. L["ERROR_NOTHINGSELECTED_LABEL"])
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
