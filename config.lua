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
table.insert(buffIDs, "10157,23028") -- Arcane Intellect, Arcane Brilliance
table.insert(buffIDs, "10938,21564") -- Power Word: Fortitude, Prayer of Fortitude
table.insert(buffIDs, "10958,27683") -- Shadow Protection, Prayer of Shadow Protection
table.insert(buffIDs, "27841,27681") -- Divine Spirit, Prayer of Spirit
table.insert(buffIDs, "9885,21850") -- Mark of the Wild, Gift of the Wild
table.insert(buffIDs, "9910,9910") -- Thorns (Rank 6)

if playerFaction == "Alliance" then
    table.insert(buffIDs, "20217,25898") -- Blessing of Kings, Greater Blessing of Kings
    table.insert(buffIDs, "25291,25916") -- Blessing of Might, Greater Blessing of Might
    table.insert(buffIDs, "1038,25895") -- Blessing of Salvation, Greater Blessing of Salvation
    table.insert(buffIDs, "25290,25918") -- Blessing of Wisdom, Greater Blessing of Wisdom
    table.insert(buffIDs, "20914,25899") -- Blessing of Sanctuary, Greater Blessing of Sanctuary
end

-- settings pannel spacer
local offset = 16

-- Main options panel
rebuffPanel = CreateFrame("Frame")
rebuffPanel.name = addonName
InterfaceOptions_AddCategory(rebuffPanel)

local title = nil
----------------------------
--          EVENTS        --
----------------------------
local function onEvent(self, event, arg1, ...)
    if (event == "ADDON_LOADED" and arg1 == "Rebuff") then
        title = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
        title:SetPoint("TOPLEFT", rebuffPanel, "TOPLEFT", offset, -offset)
        title:SetText(addonName)

        createChannelDropdown()
        createReadycheckCheckbox()
        createBuffSelection()
    end
end

function createReadycheckCheckbox()
    local checkReadyPrompt = CreateFrame("CheckButton", "checkReadyPrompt", rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
    checkReadyPrompt:SetSize(24, 24)
    checkReadyPrompt:SetHitRectInsets(0, 0, 0, 0)
    checkReadyPrompt:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -offset * 4)
    checkReadyPrompt:SetChecked(Rebuff:getSV("options", "readyCheck"))
    checkReadyPrompt:SetScript("OnClick", function() readyCheck = checkReadyPrompt:GetChecked() end)

    local labelReadyPrompt = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    labelReadyPrompt:SetPoint("TOPLEFT", checkReadyPrompt, "TOPLEFT", 32, -6)
    labelReadyPrompt:SetJustifyH("LEFT")
    labelReadyPrompt:SetText("Broadcast after READYCHECK")
end

function createChannelDropdown()
    ----------------------------------------
    -- Drop Down Menu broadcast channels ---
    -----------------------------------------
    channel = Rebuff:getSV("options", "channel")

    if not sendChannelSelect then CreateFrame("Button", "sendChannelSelect", rebuffPanel, "UIDropDownMenuTemplate") end

    sendChannelSelect:ClearAllPoints()
    sendChannelSelect:SetPoint("TOPLEFT", title, "BOTTOMLEFT", -offset, -offset)
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

    local labelChannelDropdown = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    labelChannelDropdown:SetPoint("TOPLEFT", sendChannelSelect, "TOPLEFT", 148, -8)
    labelChannelDropdown:SetJustifyH("LEFT")
    labelChannelDropdown:SetText("Broadcast channel")
end

function createBuffSelection()
    local labelBuffs = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    labelBuffs:SetPoint("TOPLEFT", title, "TOPLEFT", 0, -(offset * 8))
    labelBuffs:SetText("Buffs")

    local buffTitles = {}
    for i, class in pairs(roles) do
        checkBoxes[class] = {}

        local labelClassBuff = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        labelClassBuff:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 200 + (offset * 4 * i), 0)
        labelClassBuff:SetText(class)

        local buffList = Rebuff:getSV("buffs", class) or {}

        for index, ids in pairs(buffIDs) do
            local yOffset = ((4 - offset) + (-16)) * index

            local singleID, groupID = string.split(",", ids)
            local groupBuff, _, spellIcon = GetSpellInfo(groupID)

            if not buffTitles[index] then
                local buffIcon = CreateFrame("Button", nil, rebuffPanel)
                buffIcon:SetSize(24, 24)
                buffIcon:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 0, yOffset)
                buffIcon.t = buffIcon:CreateTexture(nil, "BACKGROUND")
                buffIcon.t:SetTexture(spellIcon)
                buffIcon.t:SetAllPoints()

                local title = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
                title:SetPoint("TOPLEFT", labelBuffs, 32, yOffset - 6)
                title:SetText(groupBuff)
                buffTitles[index] = title
            end

            if ("checkbuttons") then
                local checkName = class .. "checkBox"
                local checkBox = CreateFrame("CheckButton", checkName, rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
                checkBox.tooltipText = class .. " > " .. groupBuff
                checkBox:SetSize(24, 24)
                checkBox:SetHitRectInsets(0, 0, 0, 0)
                checkBox:SetPoint("TOPLEFT", labelClassBuff, "TOPLEFT", 0, yOffset)
                -- -- Update list of buffs when a box is checked or unchecked
                checkBox:SetScript("OnClick", function() addon:storeRebuffBuffs(class) end)
                checkBoxes[class][index] = checkBox
                checkBoxes[class][index]:SetChecked(buffList[index] ~= nil)
            end
        end
    end
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

