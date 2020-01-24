local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

function addon:print()
    local channel = addon.channels[addon.db.profile.options.channel]

    local active = #addon.spells
    local buffed = 0

    for _, v in ipairs(addon.spells) do
        local spell = { active = addon.db.profile[v].active, count = 0 }

        if (spell.active) then
            spell.missing = addon:groupCheck(v)
            for _ in pairs(spell.missing) do spell.count = spell.count + 1 end

            if (spell.count > 0) then
                sendToChannel("-----------------------------", channel)
                sendToChannel(L["MISSING_PRINT_LABEL"] .. " " .. v .. ":", channel)
                sendToChannel("-----------------------------", channel)
                for spell, players in addon:sortByKey(spell.missing) do
                    local str = spell .. " (" .. #players .. ")"
                    sendToChannel(str .. ": " .. formatPlayers(players), channel)
                end
            else
                buffed = buffed + 1
            end
        else
            active = active - 1
        end
    end

    if active == buffed and active > 0 then
        sendToChannel("-----------------------------", channel)
        sendToChannel(addon.db.profile.options.fullBuffedMessage, channel)
        sendToChannel("-----------------------------", channel)
    elseif (active == 0) then
        printError(addonName .. " |r" .. L["ERROR_NOTHINGSELECTED_LABEL"])
    end
end

function sendToChannel(text, channel)
    if (string.match(channel, "PRINT")) then
        print(text)
    else
        if (text ~= nil) then SendChatMessage(text, channel) end
    end
end

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

function printError(text) print("|cFFFF0000" .. text) end
