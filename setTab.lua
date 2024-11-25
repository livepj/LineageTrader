local tab = LineageTrader.setTab
local function CreateBlizzardItemSlot(parentFrame)
    -- Создаем слот на основе готового шаблона
    local slot = CreateFrame('Button', nil, parentFrame, 'ItemButtonTemplate')
    slot:SetPoint('CENTER') -- Размещение слота в центре

    -- Добавляем базовую обработку дропа предмета
    slot:SetScript('OnReceiveDrag', function(self)
        local cursorType, itemID, itemLink = GetCursorInfo()
        if cursorType == 'item' and itemLink then
            local itemName, _, _, _, _, _, _, _, _, itemIcon = GetItemInfo(itemLink)
            if itemIcon then
                -- Устанавливаем иконку в слот
                SetItemButtonTexture(self, itemIcon)
                -- Сохраняем ссылку на предмет
                self.itemLink = itemLink
                -- Очищаем курсор
                ClearCursor()
            end
        end
    end)

    -- Обработка подсказки (при наведении)
    slot:SetScript('OnEnter', function(self)
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        if self.itemLink then
            GameTooltip:SetHyperlink(self.itemLink)
        else
            GameTooltip:SetText('Перетащите сюда предмет')
        end
        GameTooltip:Show()
    end)

    slot:SetScript('OnLeave', function(self)
        GameTooltip:Hide()
    end)

    return slot
end

local setItemSlot = CreateBlizzardItemSlot(tab.panel)

setItemSlot:SetPoint('TOP', tab.panel, 'TOP', 0, -40)

-- Создаем поле для ввода
local inputCount = 0
local function createInput(isRight)
    local parentFrame = CreateFrame('Frame', nil, setItemSlot)
    parentFrame:SetSize(100, 20)
    local pivot = 'LEFT'
    if isRight then
        pivot = 'RIGHT'
    end
    parentFrame:SetPoint(pivot, tab.panel, pivot, 0, 50) -- Центрируем в окне

    local numberInput = CreateFrame('EditBox', 'unicInputName' .. inputCount, parentFrame, 'InputBoxTemplate')
    numberInput:SetSize(100, 20)
    numberInput:SetPoint('CENTER', parentFrame, 'CENTER', 0, 0) -- Центрируем в окне
    numberInput:SetAutoFocus(false) -- Не фокусироваться автоматически
    numberInput:SetNumeric(true) -- Только числовой ввод
    numberInput:SetMaxLetters(10) -- Максимум 10 символов
    inputCount = inputCount + 1
    return numberInput
end

local countInput = createInput()
local priceInput = createInput(true)

-- Создаем кнопку для линковки предмета в чат
local buttonCounter = 0
local function CreateButton(itemSlot, text)
    local button = CreateFrame('Button', 'LTUnicButton' .. buttonCounter, tab.panel, 'UIPanelButtonTemplate')
    button:SetSize(100, 30) -- Размер кнопки
    button:SetPoint('TOP', itemSlot, 'BOTTOM', 0, -10 - (30 * buttonCounter)) -- Размещаем кнопку под слотом
    button:SetText(text)
    buttonCounter = buttonCounter + 1
    return button
end

local addButton = CreateButton(setItemSlot, 'add')
addButton:SetScript('OnClick', function()
    if setItemSlot.itemLink then
        Emit('ADD', setItemSlot.itemLink, countInput:GetText(), priceInput:GetText())
    else
        print('Нет предмета для линковки.')
    end
end)
local clearButton = CreateButton(setItemSlot, 'clear')
clearButton:SetScript('OnClick', function()
    Emit('CLEAR')
end)
local startButton = CreateButton(setItemSlot, 'start')
startButton:SetScript('OnClick', function()
    Emit('START')
end)
local stopButton = CreateButton(setItemSlot, 'stop')
stopButton:SetScript('OnClick', function()
    Emit('STOP')
end)
local whatButton = CreateButton(setItemSlot, 'what')
whatButton:SetScript('OnClick', function()
    Emit('WHAT')
end)
