local addonName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

if L then
    L["title"] = "Rebuff Options"
    L["broadCastReport"] = "Broadcast a report"

    L["general"] = "General"
    L["channel"] = "Broadcasting channel"
    L["selectChannel"] = "Select a broadcast channel"
    L["channelDescription"] = "PRINT is only for you visible."

    L["generalExtra"] = "Extra stuff"

    L["readycheckDialog"] = "Readycheck dialog"
    L["readycheckDialogText"] = "Do you want to share a rebuff report?"
    L["readycheckDialogDescription"] = "After a readycheck a dialog appears for sharing the report."
    L["yes"] = "Yes"
    L["no"] = "No"

    L["buffs"] = "Buffs"
    L["consumables"] = "Consumables"

    L["settings"] = "Settings"
    L["overview"] = "Overview"
    L["broadcast"] = "Broadcast"

    L["tank"] = "Tanking"
    L["physical"] = "Physical"
    L["caster"] = "Caster"

    L["missing"] = "Missing"
    L["fullBuffed"] = "All players are buffed, YEAH!"
    L["nothingSelected"] = "Select something in the options to broadcast a report."

    L["falseRole"] = "Players' role can be false."
end
