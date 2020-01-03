local addonName, addon = ...

function addon:print()
    local channel = addon.broadcastChannels[addon.db.profile.options.channel]

    local active = #addon.spells
    local buffed = 0

    for i, v in ipairs(addon.spells) do
        local buffs = {active = addon.db.profile[v].active, count = 0}

        if (buffs.active) then
            buffs.missing = addon:groupCheck(v)
            for _ in pairs(buffs.missing) do buffs.count = buffs.count + 1 end

            if (buffs.count > 0) then
                addon:sendToChannel("-----------------------------", channel)
                addon:sendToChannel("Missing " .. v .. ":", channel)
                addon:sendToChannel("-----------------------------", channel)
                for spell, players in addon:pairsByKeys(buffs.missing) do
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
    if (buffed == active) then
        addon:sendToChannel("-----------------------------", channel)
        addon:sendToChannel("All players are buffed, YEAH!", channel)
        addon:sendToChannel("-----------------------------", channel)
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
        if (string.len(str .. " ...") < 200) then
            if (index < #players) then
                str = str .. v .. ", "
            else
                str = str .. v
            end
        end
    end
    return str
end
