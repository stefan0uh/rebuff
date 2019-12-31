local addonName, addon = ...

local AceGUI = LibStub("AceGUI-3.0")
local playerFaction = UnitFactionGroup("player")

local channel = nil
local checkBoxes = {}
local readyCheck = nil

local buffs, buffIDs = {}, {}

-- buff role speration
local roles = {"RAID", "TANKS"}

----------------------------
-- (SINGLEBUFF,GROUPBUFF) --
----------------------------
table.insert(buffIDs, {single = 10157, group = 23028}) -- Arcane Intellect, Arcane Brilliance
table.insert(buffIDs, {single = 10174}) -- Dampen Magic (Rank 5)
table.insert(buffIDs, {single = 9885, group = 21850}) -- Mark of the Wild, Gift of the Wild
table.insert(buffIDs, {single = 10938, group = 21564}) -- Power Word: Fortitude, Prayer of Fortitude
table.insert(buffIDs, {single = 10958, group = 27683}) -- Shadow Protection, Prayer of Shadow Protection
table.insert(buffIDs, {single = 27841, group = 27681}) -- Divine Spirit, Prayer of Spirit
table.insert(buffIDs, {single = 9910}) -- Thorns (Rank 6)

if playerFaction == "Alliance" then
    table.insert(buffIDs, {single = 20217, group = 25898}) -- Blessing of Kings, Greater Blessing of Kings
    table.insert(buffIDs, {single = 25291, group = 25916}) -- Blessing of Might, Greater Blessing of Might
    table.insert(buffIDs, {single = 1038, group = 25895}) -- Blessing of Salvation, Greater Blessing of Salvation
    table.insert(buffIDs, {single = 25290, group = 25918}) -- Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(buffIDs, {single = 20914, group = 25899}) -- Blessing of Sanctuary, Greater Blessing of Sanctuary
end

-- settings pannel spacer
local offset = 16

-- Main options panel
rebuffPanel = CreateFrame("Frame")
rebuffPanel.name = addonName

InterfaceOptions_AddCategory(rebuffPanel)

local title, description = nil
----------------------------
--          EVENTS        --
----------------------------
local function onEvent(self, event, arg1, ...)
    if (event == "ADDON_LOADED" and arg1 == "Rebuff") then
        title = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", rebuffPanel, "TOPLEFT", offset, -offset)
        title:SetText(addonName)

        description = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        description:SetPoint("TOPLEFT", title, "TOPLEFT", 0, -offset * 1.5)
        description:SetText("TANKS are needed to be marked as MAIN TANK or MAIN ASSIST in a raid.\nMelees(Rogues, Warriors) are not counted for INT or SPIRIT")
        description:SetJustifyH("LEFT")

        createBuffSelection(offset, -offset * 6)
        createChannelDropdown(offset, 80)
        createReadycheckCheckbox(250, 55)
    end
end

function createBuffSelection(x, y)
    local labelBuffs = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    labelBuffs:SetPoint("TOPLEFT", rebuffPanel, "TOPLEFT", x, y)
    labelBuffs:SetText("Buffs")

    local buffTitles = {}
    for i, class in pairs(roles) do
        checkBoxes[class] = {}

        local labelClassBuff = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        labelClassBuff:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 200 + (offset * 4 * i), 0)
        labelClassBuff:SetText(class)

        local buffList = Rebuff:getSV("buffs", class) or {}

        for index, buff in pairs(buffIDs) do
            local yOffset = ((4 - offset) + (-16)) * index
            local buffID = buff.group or buff.single

            local buffName, _, spellIcon = GetSpellInfo(buffID)

            if not buffTitles[index] then
                local buffIcon = CreateFrame("Button", nil, rebuffPanel)
                buffIcon:SetSize(24, 24)
                buffIcon:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 0, yOffset)
                buffIcon.t = buffIcon:CreateTexture(nil, "BACKGROUND")
                buffIcon.t:SetTexture(spellIcon)
                buffIcon.t:SetAllPoints()

                local title = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
                title:SetPoint("TOPLEFT", labelBuffs, 32, yOffset - 6)
                title:SetText(buffName)
                buffTitles[index] = title
            end

            if ("checkbuttons") then
                local checkName = class .. "checkBox"
                local checkBox = CreateFrame("CheckButton", checkName, rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
                checkBox.tooltipText = class .. " > " .. buffName
                checkBox:SetSize(24, 24)
                checkBox:SetHitRectInsets(0, 0, 0, 0)
                checkBox:SetPoint("TOPLEFT", labelClassBuff, "TOPLEFT", 0, yOffset)
                checkBox:SetScript("OnClick", function() addon:storeRebuffBuffs(class) end)
                checkBoxes[class][index] = checkBox

                -- Arcane Brilliance > 23028
                -- Prayer of Spirit > 27681
                -- Thorns (Rank 6) > 9910
                if (class == "TANKS" and (buffID == 23028 or buffID == 27681)) or (class == "RAID" and (buffID == 9910)) then
                    checkBoxes[class][index]:SetEnabled(false)
                    checkBoxes[class][index]:SetAlpha(.35)
                    checkBoxes[class][index]:SetChecked(false)
                else
                    checkBoxes[class][index]:SetChecked(buffList[index] ~= nil)
                end

            end
        end
    end
end

function createChannelDropdown(x, y)
    channel = Rebuff:getSV("options", "channel")

    local labelChannelDropdown = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    labelChannelDropdown:SetPoint("TOPLEFT", rebuffPanel, "BOTTOMLEFT", x, y)
    labelChannelDropdown:SetJustifyH("LEFT")
    labelChannelDropdown:SetText("Select a broadcast channel")

    if not sendChannelSelect then CreateFrame("Button", "sendChannelSelect", rebuffPanel, "UIDropDownMenuTemplate") end

    sendChannelSelect:ClearAllPoints()
    sendChannelSelect:SetPoint("TOPLEFT", labelChannelDropdown, "TOPLEFT", -14, -24)
    sendChannelSelect:Show()

    -- return dropdown selection
    local function OnClick(self)
        UIDropDownMenu_SetSelectedID(sendChannelSelect, self:GetID(), text, value)
        channel = self.value
    end

    -- dropdown box properties
    local function initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for index, chan in pairs({"RAID", "PARTY", "SAY", "PRINT"}) do
            info = UIDropDownMenu_CreateInfo()
            info.text = chan
            info.value = chan
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(sendChannelSelect, self:GetID(), text, value)
                channel = self.value
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end

    UIDropDownMenu_Initialize(sendChannelSelect, initialize)
    UIDropDownMenu_SetWidth(sendChannelSelect, 100)
    UIDropDownMenu_SetButtonWidth(sendChannelSelect, 100)
    UIDropDownMenu_JustifyText(sendChannelSelect, "LEFT")
    UIDropDownMenu_SetSelectedName(sendChannelSelect, channel)

end

function createReadycheckCheckbox(x, y)
    local checkReadyPrompt = CreateFrame("CheckButton", "checkReadyPrompt", rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
    local labelReadyPrompt = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

    labelReadyPrompt:SetPoint("TOPLEFT", checkReadyPrompt, "TOPLEFT", 32, -5)
    labelReadyPrompt:SetJustifyH("LEFT")
    labelReadyPrompt:SetText("Broadcast prompt after READYCHECK")

    checkReadyPrompt:SetSize(24, 24)
    checkReadyPrompt:SetHitRectInsets(0, 0, 0, 0)
    checkReadyPrompt:SetPoint("TOPLEFT", rebuffPanel, "BOTTOMLEFT", x, y)
    checkReadyPrompt:SetChecked(Rebuff:getSV("options", "readyCheck"))
    checkReadyPrompt:SetScript("OnClick", function() readyCheck = checkReadyPrompt:GetChecked() end)
end

----------------------------
--          EVENTS        --
----------------------------
function addon:storeRebuffBuffs(class)
    local storeBuffs = {}
    for i, buff in pairs(buffIDs) do if checkBoxes[class][i]:GetChecked() then table.insert(storeBuffs, i, buff) end end
    buffs[class] = storeBuffs
end

--------------------------------------------------
--- Save items when the Okay button is pressed ---
--------------------------------------------------
rebuffPanel.okay = function(self)
    for i, class in pairs(roles) do addon:storeRebuffBuffs(class) end

    RebuffDB["buffs"] = buffs
    RebuffDB["options"] = {channel = channel, readyCheck = readyCheck}
end

rebuffPanel:RegisterEvent("ADDON_LOADED")
rebuffPanel:SetScript("OnEvent", onEvent)

