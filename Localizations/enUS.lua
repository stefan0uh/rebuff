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
    L["generalreadyCheck"] = "Readycheck stuff"

    L["readyDialog"] = "Readycheck dialog"
    L["readyDialogText"] = "Do you want to broadcast a rebuff report?"
    L["readyDialogDescription"] = "Directly on a ready check, a dialog appears to broadcast the report."

    L["readyDirect"] = "Readycheck direct broadcast"
    L["readyDirectDescription"] = "Directly when the ready check appears, a report is broadcasted."

    L["yes"] = "Yes"
    L["no"] = "No"

    L["reset"] = "Reset"
    L["resetOptions"] = "Reset options"

    L["buffs"] = "Buffs"
    L["consumables"] = "Consumables"

    L["settings"] = "Settings"
    L["overview"] = "Overview"
    L["broadcast"] = "Broadcast"

    L["tank"] = "Tanking"
    L["physical"] = "Physical"
    L["caster"] = "Caster"

    L["missing"] = "Missing"

    L["fullBuffed"] = "Change the full buffed message"
    L["fullBuffedMessage"] = "All players are buffed, YAY!"
    L["fullBuffedDesc"] = "The message appears when there no missing buffs."

    L["nothingSelected"] = "Select something in the options to broadcast a report."

    L["falseRole"] = "player's role can be false."
end
