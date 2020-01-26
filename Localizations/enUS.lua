local addonName, _ = ...
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true)

if L then
    L["TITLE"] = "Rebuff Options"
    L["ADDON_DESCRIPTION"] = "Rebuff Options"

    L["BROADCAST_ACTION"] = "Broadcast a report"
    L["SPACER_HEADLINE"] = "Settings & more"

    ----------------------------

    L["GENERAL_TAB"] = "General"
    L["CHANNEL_HEADLINE"] = "Broadcasting channel"
    L["CHANNEL_SELECT_LABEL"] = "Select a broadcast channel"
    L["CHANNEL_DESCRIPTION"] = "PRINT is only in your main chat window visible."

    ----------------------------

    L["READYCHECK_HEADLINE"] = "Readycheck"

    L["READYCHECK_DIALOG_LABEL"] = "Readycheck dialog"
    L["READYCHECK_DIALOG_DESCRIPTION"] = "Directly on a ready check, a dialog appears to broadcast the report."
    L["READYCHECK_DIALOG_MESSAGE"] = "Do you want to broadcast a rebuff report?"

    L["READYCHECK_DIRECT_LABEL"] = "Readycheck direct broadcast"
    L["READYCHECK_DIRECT_DESCRIPTION"] = "Directly when the ready check appears, a report is broadcasted."

    ----------------------------

    L["FULLBUFFED_LABEL"] = "Change the full buffed message"
    L["FULLBUFFED_DESCRIPTION"] = "The message appears when there no missing buffs."
    L["FULLBUFFED_MESSAGE"] = "All players are buffed!"

    ----------------------------

    L["EXTRA_HEADLINE"] = "Extra stuff"
    L["EXTRA_DESCRIPTION"] = "some small extra :D"

    L["CHECK_HEADLINE"] = "Full HARDCORE check"
    L["CHECK_LABEL"] = "Perform a full consumable check"
    L["CHECK_DESCRIPTION"] = "If you select this, players need all selected consumables instead of one."

    ----------------------------

    L["RESET_HEADLINE"] = "Reset"
    L["RESET_ACTION"] = "Reset options"
    L["RESET_DESCRIPTION"] = "In super rare cases, the broadcasted buff count can be wrong. It is possible that this happened after updating buff ids, use reset to fix this issue."

    L["YES"] = "Yes"
    L["NO"] = "No"

    ----------------------------

    L["SPELL_SETTING_HEADLINE"] = "Settings"
    L["SPELL_OVERVIEW_HEADLINE"] = "Overview"
    L["SPELL_BROADCAST_LABEL"] = "Broadcast"

    L["buffs"] = "Buffs"
    L["consumables"] = "Consumables"
    L["worldbuffs"] = "World Buffs"

    L["ROLE_TANK"] = "Tanking"
    L["ROLE_PHYSICAL"] = "Physical"
    L["ROLE_CASTER"] = "Caster"

    ----------------------------

    L["MISSING_PRINT_LABEL"] = "Missing"

    ----------------------------

    L["ERROR_NOPARTY"] = "You are not in a party or raid."
    L["ERROR_NOTHINGSELECTED_LABEL"] = "Select something in the options to broadcast a report."
    L["ERROR_FALSEROLE_LABEL"] = "player's role can be false."

    ----------------------------

    L["HINT_TEST_SETTINGS"] = "To test the addon, use PRINT in the channel settings."
end
