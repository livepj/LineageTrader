-- Создаем основное окно
local frame = CreateFrame("Frame", "LineageTraderMainFrame", UIParent)
frame:SetSize(400, 300) -- Размер окна
frame:SetPoint("CENTER") -- Размещаем окно в центре экрана
frame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
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
frame:RegisterEvent("TAB_BUTTON_CLICK")

local tabContainer = CreateFrame("Frame", nil, frame)
tabContainer:SetPoint("TOPLEFT", 10, -10)
tabContainer:SetSize(380, 30)

local tabCounter = 0
function CreateTabButton(text)
    local size = {
        width = 120,
        heigth = 30
    }
    local tab = CreateFrame("Button", nil, tabContainer)
    tab:SetSize(size.width, size.heigth)
    tab:SetPoint("LEFT", tabContainer, "LEFT", tabCounter * (size.width + 5), 0)
    tab:SetText(text)
    tab:SetNormalFontObject("GameFontNormal")
    tab:SetHighlightFontObject("GameFontHighlight")
    tabCounter = tabCounter + 1
    return tab
end

function CreateTabPanel()
    local panel = CreateFrame("Frame", nil, frame)
    panel:SetSize(380, 220)
    panel:SetPoint("TOPLEFT", tabContainer, "BOTTOMLEFT", 0, -5)
    panel:Hide()
    return panel
end

function CreateTab(tabText)
    local button = CreateTabButton(tabText)
    local panel = CreateTabPanel()
    Subscribe(frame, "TAB_BUTTON_CLICK", function(targetButton)
        if targetButton == button then
            panel:Show()
        else
            panel:Hide()
        end
    end)
    button:SetScript("OnClick", function()
        Emit(frame, "TAB_BUTTON_CLICK", button)
    end)
    local result = {
        button = button,
        panel = panel
    }
    return result
end

local setTab = CreateTab("Вкладка 1")
local listTab = CreateTab("Вкладка 2")

-- Добавляем элементы в панели
local setLabel = setTab.panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
setLabel:SetPoint("CENTER")
setLabel:SetText("setTab")

local label2 = listTab.panel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
label2:SetPoint("CENTER")
label2:SetText("listTab")

setTab.panel:Show()
