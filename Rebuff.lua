local addonName, addon = ...
-- Saved Variables
RebuffDB = {}

Rebuff = LibStub("AceAddon-3.0"):NewAddon("Rebuff", "AceEvent-3.0")

_G[addonName] = addon
addon.healthCheck = true

-------------------------
---     Functions     ---
-------------------------
function addon:print()
    local channel = addon:getSV("options", "channel")

    local partyBuffs = addon:groupCheck()
    local partyBuffAmount = 0

    for _ in pairs(partyBuffs) do partyBuffAmount = partyBuffAmount + 1 end

    if partyBuffAmount > 0 then
        addon:sendtoChannel("-----------------------------", channel)
        addon:sendtoChannel("Missing Buffs:", channel)
        addon:sendtoChannel("-----------------------------", channel)
        for buff, players in pairsByKeys(partyBuffs) do
            local str = buff .. " (" .. #players .. ")"
            if (#players < 5) then
                addon:sendtoChannel(str .. ": " .. addon:getPlayers(players), channel)
            else
                addon:sendtoChannel(str, channel)
                addon:sendtoChannel(addon:getPlayers(players) .. " ...", channel)
            end
        end
    else
        addon:sendtoChannel("-----------------------------", channel)
        addon:sendtoChannel("All players are buffed, YEAH!", channel)
        addon:sendtoChannel("-----------------------------", channel)
    end
end

function addon:groupCheck()
    local name, idx = "", 1
    local missingBuffs = {}

    if GetNumGroupMembers() == 0 then idx = 0 end -- 0 means no group
    -- Check each player in the group/raid
    for groupIndex = idx, GetNumGroupMembers(), 1 do
        local subgroup, online, isDead, role

        -- Check if solo (though not very useful outside of testing)
        if groupIndex == 0 then
            name = UnitName("player")
            online = true
        else
            name, _, subgroup, _, _, _, _, online, isDead, role = GetRaidRosterInfo(groupIndex)
        end
        if online and name ~= nil then
            local playerMissing = addon:getMissingBuffs(name, role)
            for index, buff in pairs(playerMissing) do
                buff = GetSpellInfo(buff)
                if missingBuffs[buff] == nil then missingBuffs[buff] = {} end
                table.insert(missingBuffs[buff], name)
            end
        end
    end
    return missingBuffs
end

function addon:getMissingBuffs(player, role)
    local missingBuffs = {}
    local class = "RAID"
    local _, className = UnitClass(player)

    if role == "MAINTANK" or role == "MAINASSIST" then class = "TANKS" end

    local buffList = addon:getSV("buffs", class)

    for index, buff in pairs(buffList) do
        local group = buff.group or buff.single

        -- Arcane Brilliance > 23028
        -- Prayer of Spirit > 27681
        if not ((className == "ROGUE" or className == "WARRIOR") and (group == 23028 or group == 27681)) then
            local buffSlotOnPlayer = 1
            local buff, _, _, _, _, _, _, _, _, spellID = UnitBuff(player, buffSlotOnPlayer)
            spellID = tonumber(spellID)
            table.insert(missingBuffs, group)

            while buff do
                if (buff.single == spellID or group == spellID) then table.remove(missingBuffs) end
                buffSlotOnPlayer = buffSlotOnPlayer + 1
                buff, _, _, _, _, _, _, _, _, spellID = UnitBuff(player, buffSlotOnPlayer)
            end
        end
    end
    return missingBuffs
end

function addon:sendtoChannel(text, channel)
    if (string.match(channel, "PRINT")) then
        print(text)
    else
        if (text ~= nil) then SendChatMessage(text, channel) end
    end
end

function addon:getPlayers(players)
    local str = ""
    for index, v in ipairs(players) do
        if (string.len(str .. " ...") < 220) then
            if (index < #players) then
                str = str .. v .. ", "
            else
                str = str .. v
            end
        end
    end
    return str
end

-------------------------
---      HELPER       ---
-------------------------
function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function() -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end

-------------------------
---  Saved Variables  ---
-------------------------
function addon:getSV(category, variable)
    local vartbl = RebuffDB[category]

    if vartbl == nil then vartbl = {} end

    -- return the full table if no variable is given
    if variable == nil then return vartbl end

    -- return the requested variable
    if (vartbl[variable] ~= nil) then
        return vartbl[variable]
    else
        return nil
    end
end

-------------------------
---      Dialog       ---
-------------------------
StaticPopupDialogs["REBUFF_PRINT"] = {
    text = "Do you want to share a rebuff report?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function() addon:print() end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3
}

-------------------------
---      EVENTS       ---
-------------------------
local frame = CreateFrame("FRAME", "REBUFF_PRINT")
frame:RegisterEvent("READY_CHECK")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event)
    if (event == "READY_CHECK") and (Rebuff:getSV("options", "readyCheck")) then StaticPopup_Show("REBUFF_PRINT") end
    if (event == "ADDON_LOADED" and prefix == "Rebuff") then RebuffDB.db = LibStub("AceDB-3.0"):New("RebuffDB", SettingsDefaults) end
end)

-------------------------
---     Commands      ---
-------------------------
SlashCmdList["Rebuff"] = function(inArgs)
    local args = strtrim(inArgs)
    if args == "print" then
        addon:print()
    elseif args == "config" then
        InterfaceOptionsFrame_OpenToCategory(rebuffPanel)
        InterfaceOptionsFrame_OpenToCategory(rebuffPanel)
    else
        if (Rebuff:getSV("options", "readyCheck")) then StaticPopup_Show("REBUFF_PRINT") end

        print("|cFFFF0000Rebuff broadcast")
        print("|r/rebuff |cFF00FF00print |r(Share the buff report)")
        print("|r/rebuff |cFF00FF00config")
    end

end
SLASH_Rebuff1 = "/rebuff"
SLASH_Rebuff2 = "/rb"
