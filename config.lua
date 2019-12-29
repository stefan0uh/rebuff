local addonName, addon = ...

local AceGUI = LibStub("AceGUI-3.0")
local playerFaction = UnitFactionGroup("player")

local channel = nil
local classes, checkBoxes = {}, {}

local buffs, buffIDs = {}, {}

local offset = 16

-- Main options panel
rebuffPanel = CreateFrame("Frame")
rebuffPanel.name = addonName
InterfaceOptions_AddCategory(rebuffPanel)

local title =
    rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", rebuffPanel, "TOPLEFT", offset, -offset)
title:SetText(addonName)

------------------
--    Events    --
------------------
local function onEvent(self, event, arg1, ...)
    if (event == "ADDON_LOADED" and arg1 == "Rebuff") then

        local labelChannelDropdown = rebuffPanel:CreateFontString(nil,"ARTWORK","GameFontHighlight")
        labelChannelDropdown:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -offset * 2)
        labelChannelDropdown:SetJustifyH("LEFT")
        labelChannelDropdown:SetText("Select the channel for broadcasts.")

        if ("Channel DROPDOWN") then
            ----------------------------------------
            -- Drop Down Menu broadcast channels ---
            -----------------------------------------
            channel = Rebuff:getSV("options", "channel")
            
            if not sendChannelSelect then
                CreateFrame("Button", "sendChannelSelect", rebuffPanel,"UIDropDownMenuTemplate")
            end

            sendChannelSelect:ClearAllPoints()
            sendChannelSelect:SetPoint("TOPLEFT", labelChannelDropdown, -offset, -offset * 2)
            sendChannelSelect:Show()

            -- return dropdown selection
            local function OnClick(self)
                UIDropDownMenu_SetSelectedID(sendChannelSelect, self:GetID(), text, value)
                channel = self.value
                -- return channel
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
            UIDropDownMenu_SetButtonWidth(sendChannelSelect, 124)
            UIDropDownMenu_JustifyText(sendChannelSelect, "LEFT")
            UIDropDownMenu_SetSelectedName(sendChannelSelect, channel)
        end

        local labelReadyPrompt = rebuffPanel:CreateFontString(nil,"ARTWORK","GameFontHighlight")
        labelReadyPrompt:SetPoint("TOPLEFT", title, "BOTTOMLEFT", offset * 4, -offset * 2)
        labelReadyPrompt:SetJustifyH("LEFT")
        labelReadyPrompt:SetText("Readycheck, prompt for broadcasts.")

        local labelBuffs = rebuffPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
        labelBuffs:SetPoint("TOPLEFT", labelChannelDropdown, "TOPLEFT", 0, -(offset * 6))
        labelBuffs:SetText("Buffs")

        if ("BUFF CHECKBOXS") then
            local buffTitles = {}

            classes = {"RAID", "TANKS"}
            buffIDs = {
                "10157,23028", "10938,21564", "10958,27683", "27841,27681",
                "9885,21850", "9910,9910",
            }

            if playerFaction == "Alliance" then
                table.insert(buffIDs, "20217,25898")
                table.insert(buffIDs, "25291,25916")
                table.insert(buffIDs, "1038,25895")
                table.insert(buffIDs, "25290,25918")
                table.insert(buffIDs, "20914,25899")
            end

            for i, class in pairs(classes) do
                checkBoxes[class] = {}

                local labelClassBuff = rebuffPanel:CreateFontString(nil, "ARTWORK","GameFontHighlight")
                labelClassBuff:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 200 + (offset * 4 * i) , 0)
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

                        local title = rebuffPanel:CreateFontString(nil,"ARTWORK", "GameFontHighlight")
                        title:SetPoint("TOPLEFT", labelBuffs, 32, yOffset - 6)
                        title:SetText(groupBuff)
                        buffTitles[index] = title
                    end

                    -- -- Create the checkbuttons
                    local checkName = class .. "checkBox"
                    local checkBox = CreateFrame("CheckButton", checkName,rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
                    checkBox.tooltipText = class .. " > " .. groupBuff
                    checkBox:SetSize(24, 24)
                    checkBox:SetHitRectInsets(0, 0, 0, 0)
                    checkBox:SetPoint("TOPLEFT", labelClassBuff, "TOPLEFT", 0, yOffset)
                    -- -- Update list of buffs when a box is checked or unchecked
                    checkBox:SetScript("OnClick", function()
                        addon:storeRebuffBuffs(class)
                    end)
                    checkBoxes[class][index] = checkBox
                    checkBoxes[class][index]:SetChecked(buffList[index] ~= nil)
                end
            end
        end
    end
end

function addon:storeRebuffBuffs(class)
    local storeBuffs = {}
    for i, buff in pairs(buffIDs) do
        if checkBoxes[class][i]:GetChecked() then
            table.insert(storeBuffs, i, buff)
        end
    end
    buffs[class] = storeBuffs
end

--------------------------------------------------
--- Save items when the Okay button is pressed ---
--------------------------------------------------
rebuffPanel.okay = function(self)
    for i, class in pairs(classes) do addon:storeRebuffBuffs(class) end

    RebuffDB["buffs"] = buffs
    RebuffDB["options"] = {channel = channel}
end

rebuffPanel:RegisterEvent("ADDON_LOADED")
rebuffPanel:SetScript("OnEvent", onEvent)

