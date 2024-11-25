local frame = CreateFrame('Frame', 'LineageTraderMainFrame', UIParent)
frame:SetSize(400, 300)
frame:SetPoint('CENTER')
frame:SetBackdrop({
    bgFile = 'Interface\\DialogFrame\\UI-DialogBox-Background',
    edgeFile = 'Interface\\DialogFrame\\UI-DialogBox-Border',
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {
        left = 5,
        right = 5,
        top = 5,
        bottom = 5
    }
})
frame:Hide()

local tabContainer = CreateFrame('Frame', nil, frame)
tabContainer:SetPoint('TOPLEFT', 10, -10)
tabContainer:SetSize(380, 30)

local tabCounter = 0
local function CreateTabButton(text)
    local size = {
        width = 120,
        heigth = 30
    }
    local tab = CreateFrame('Button', nil, tabContainer)
    tab:SetSize(size.width, size.heigth)
    tab:SetPoint('LEFT', tabContainer, 'LEFT', tabCounter * (size.width + 5), 0)
    tab:SetText(text)
    tab:SetNormalFontObject('GameFontNormal')
    tab:SetHighlightFontObject('GameFontHighlight')
    tabCounter = tabCounter + 1
    return tab
end

local function CreateTabPanel()
    local panel = CreateFrame('Frame', nil, frame)
    panel:SetSize(380, 220)
    panel:SetPoint('TOPLEFT', tabContainer, 'BOTTOMLEFT', 0, -5)
    panel:Hide()
    return panel
end

local function CreateTab(tabText)
    local button = CreateTabButton(tabText)
    local panel = CreateTabPanel()
    Subscribe('TAB_BUTTON_CLICK', function(targetButton)
        if targetButton == button then
            panel:Show()
        else
            panel:Hide()
        end
    end)
    button:SetScript('OnClick', function()
        Emit('TAB_BUTTON_CLICK', button)
    end)
    local result = {
        button = button,
        panel = panel
    }
    return result
end

LineageTrader.setTab = CreateTab('Вкладка 1')
LineageTrader.listTab = CreateTab('Вкладка 2')

LineageTrader.setTab.panel:Show()

local function ToggleFrame()
    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end

SLASH_LINEAGETRADER1 = '/lt'
SlashCmdList['LINEAGETRADER'] = ToggleFrame
