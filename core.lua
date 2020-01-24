local addonName, addon = ...
local addonTitle = select(2, GetAddOnInfo(addonName))

local A = LibStub("AceAddon-3.0"):NewAddon(addon, addonName, "AceConsole-3.0", "AceEvent-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)



function addon:OnInitialize()
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, addon.options, {"rb", "rebuff", "Rebuff"})
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName, addonTitle)
    self.db = LibStub("AceDB-3.0"):New(addonName .. "DB", addon.default)

    -- Events
    self:RegisterEvent("READY_CHECK")
end

----------------------

--function addon:OnEnable() self:RegisterEvent("READY_CHECK") end

function addon:READY_CHECK()
    StaticPopupDialogs["REBUFF_PRINT"] = {
        text = L["readyDialogText"],
        button1 = L["yes"],
        button2 = L["no"],
        OnAccept = function() addon:print() end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        preferredIndex = 3
    }

    if (addon.db.profile.options.readyDialog) then StaticPopup_Show("REBUFF_PRINT") end
    if (addon.db.profile.options.readyDirect) then addon:print() end
end

function addon:OpenConfig()
    InterfaceOptionsFrame_OpenToCategory(addonTitle)
    -- need to call it a second time as there is a bug where the first time it won't switch !BlizzBugsSuck has a fix
    InterfaceOptionsFrame_OpenToCategory(addonTitle)
end

_G[addonName] = addon
