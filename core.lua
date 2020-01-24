local addonName, addon = ...
local addonTitle = select(2, GetAddOnInfo(addonName))

local A = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

function addon:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, self.options, { "rb", "rebuff", "Rebuff" })
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addonTitle)

    self.db = LibStub("AceDB-3.0"):New(addonName .. "DB", self.default)
    -- Events
    self:RegisterEvent("READY_CHECK")
end

----------------------

function addon:READY_CHECK()
    StaticPopupDialogs["REBUFF_PRINT"] = {
        text = L["READYCHECK_DIALOG_MESSAGE"],
        button1 = L["YES"],
        button2 = L["NO"],
        OnAccept = function() addon:print() end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    }

    if (addon.db.profile.options.readyDialog) then StaticPopup_Show("REBUFF_PRINT") end
    if (addon.db.profile.options.readyDirect) then addon:print() end
end

_G[addonName] = addon
