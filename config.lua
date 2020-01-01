local addonName, addon = ...

local AceGUI = LibStub("AceGUI-3.0")

local checkBoxes = {}
local options = {}

local selectedBuffs = {}

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
        createCheckBox("readyCheck", {x = 250, y = 55}, "Broadcast prompt after READYCHECK", readyCheck)
        createCheckBox("potions", {x = 250, y = 90}, "Use elixis", potions)
    end
end

function createBuffSelection(x, y)
    local labelBuffs = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    labelBuffs:SetPoint("TOPLEFT", rebuffPanel, "TOPLEFT", x, y)
    labelBuffs:SetText("Buffs")

    local buffTitles = {}
    for i, role in pairs(addon.roles) do

        local name = role.name
        checkBoxes[name] = {}

        local labelClassBuff = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
        labelClassBuff:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 200 + (offset * 4 * i), 0)
        labelClassBuff:SetText(name)

        local selectedBuffs = Rebuff:getSV("buffs", name) or {}

        for index, buff in pairs(addon.ids.buffs) do
            local yOffset = ((4 - offset) + (-16)) * index
            local spellId = buff.ids[1]

            local _, _, spellIcon = GetSpellInfo(spellId)

            if not buffTitles[index] then
               
                local buffIcon = CreateFrame("Button", nil, rebuffPanel)
                buffIcon:SetSize(24, 24)
                buffIcon:SetPoint("TOPLEFT", labelBuffs, "TOPLEFT", 0, yOffset)
                buffIcon.t = buffIcon:CreateTexture(nil, "BACKGROUND")
                buffIcon.t:SetTexture(spellIcon)
                buffIcon.t:SetAllPoints()

    
                local title = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
                title:SetPoint("TOPLEFT", labelBuffs, 32, yOffset - 6)
                title:SetText(buff.name)
                buffTitles[index] = title
            end

            if ("checkbuttons") then
                local checkName = name .. "checkBox"
                local checkBox = CreateFrame("CheckButton", checkName, rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
                checkBox.tooltipText = name .. " > " .. buff.name
                checkBox:SetSize(24, 24)
                checkBox:SetHitRectInsets(0, 0, 0, 0)
                checkBox:SetPoint("TOPLEFT", labelClassBuff, "TOPLEFT", 0, yOffset)
                checkBox:SetScript("OnClick", function() addon:storeRebuffBuffs(name) end)
                checkBoxes[name][index] = checkBox

                if (addon:hasNOTValue(buff.roles, name)) then
                    checkBoxes[name][index]:SetEnabled(false)
                    checkBoxes[name][index]:SetAlpha(.35)
                    checkBoxes[name][index]:SetChecked(false)
                else
                    checkBoxes[name][index]:SetChecked(selectedBuffs[index] ~= nil)
                end

            end
        end
    end
end

function createChannelDropdown(x, y)
    options["channel"] = Rebuff:getSV("options", "channel")

    local labelChannelDropdown = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    labelChannelDropdown:SetPoint("TOPLEFT", rebuffPanel, "BOTTOMLEFT", x, y)
    labelChannelDropdown:SetJustifyH("LEFT")
    labelChannelDropdown:SetText("Select a broadcast channel")

    if not sendChannelSelect then CreateFrame("Button", "sendChannelSelect", rebuffPanel, "UIDropDownMenuTemplate") end

    sendChannelSelect:ClearAllPoints()
    sendChannelSelect:SetPoint("TOPLEFT", labelChannelDropdown, "TOPLEFT", -14, -24)
    sendChannelSelect:Show()

    -- dropdown box properties
    local function initialize(self, level)
        local info = UIDropDownMenu_CreateInfo()
        for index, chan in pairs({"RAID", "PARTY", "SAY", "PRINT"}) do
            info = UIDropDownMenu_CreateInfo()
            info.text = chan
            info.value = chan
            info.func = function(self)
                UIDropDownMenu_SetSelectedID(sendChannelSelect, self:GetID(), text, value)
                options["channel"] = self.value
            end
            UIDropDownMenu_AddButton(info, level)
        end
    end

    UIDropDownMenu_Initialize(sendChannelSelect, initialize)
    UIDropDownMenu_SetWidth(sendChannelSelect, 100)
    UIDropDownMenu_SetButtonWidth(sendChannelSelect, 100)
    UIDropDownMenu_JustifyText(sendChannelSelect, "LEFT")
    UIDropDownMenu_SetSelectedName(sendChannelSelect, options["channel"])

end

function createCheckBox(name, pos, text, var)
    local checkbox = CreateFrame("CheckButton", name, rebuffPanel, "InterfaceOptionsCheckButtonTemplate")
    local label = rebuffPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

    label:SetPoint("TOPLEFT", checkbox, "TOPLEFT", 32, -5)
    label:SetJustifyH("LEFT")
    label:SetText(text)

    checkbox:SetSize(24, 24)
    checkbox:SetHitRectInsets(0, 0, 0, 0)
    checkbox:SetPoint("TOPLEFT", rebuffPanel, "BOTTOMLEFT", pos.x, pos.y)
    checkbox:SetChecked(Rebuff:getSV("options", name))
    checkbox:SetScript("OnClick", function() options[name] = checkbox:GetChecked() end)
end

----------------------------
--          EVENTS        --
----------------------------
function addon:storeRebuffBuffs(class)
    local storeBuffs = {}
    for i, buff in pairs(addon.buffs) do if checkBoxes[class][i]:GetChecked() then table.insert(storeBuffs, i, buff) end end
    selectedBuffs[class] = storeBuffs
end

--------------------------------------------------
--  Save items when the Okay button is pressed  --
--------------------------------------------------
rebuffPanel.okay = function(self)
    for i, role in pairs(addon.roles) do addon:storeRebuffBuffs(role.name) end

    RebuffDB["buffs"] = selectedBuffs
    RebuffDB["options"] = options
end

rebuffPanel:RegisterEvent("ADDON_LOADED")
rebuffPanel:SetScript("OnEvent", onEvent)

