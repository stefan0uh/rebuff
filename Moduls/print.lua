local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

function addon:print()
    local channel = addon.channels[addon.db.profile.options.channel]

    local active = #addon.spells
    local buffed = 0

    for i, v in ipairs(addon.spells) do
        local spell = {active = addon.db.profile[v].active, count = 0}

        if (spell.active) then
            spell.missing = addon:groupCheck(v)
            for _ in pairs(spell.missing) do spell.count = spell.count + 1 end

            if (spell.count > 0) then
                addon:sendToChannel("-----------------------------", channel)
                addon:sendToChannel(L["missing"] .. " " .. v .. ":", channel)
                addon:sendToChannel("-----------------------------", channel)
                for spell, players in addon:pairsByKeys(spell.missing) do
                    local str = spell .. " (" .. #players .. ")"
                    addon:sendToChannel(str .. ": " .. addon:getPlayers(players), channel)
                end
            else
                buffed = buffed + 1
            end
        else
            active = active - 1
        end
    end

    if active == buffed and active > 0 then
        addon:sendToChannel("-----------------------------", channel)
        addon:sendToChannel(L["fullBuffed"], channel)
        addon:sendToChannel("-----------------------------", channel)
    elseif (active == 0) then
        addon:printError(addonName .. " |r" .. L["nothingSelected"])
    end
end

function addon:sendToChannel(text, channel)
    if (string.match(channel, "PRINT")) then
        print(text)
    else
        if (text ~= nil) then SendChatMessage(text, channel) end
    end
end

function addon:getPlayers(players)
    local str = ""
    for index, v in ipairs(players) do
        if index < #players and string.len(str .. " ...") < 200 then
            str = str .. v .. ", "
        elseif string.len(str .. " ...") < 200 then
            str = str .. v
        end
    end
    if (#players > 5) then
        return str.. "..."
    else
        return str
    end
end

function addon:printError(text) print("|cFFFF0000" .. text) end
