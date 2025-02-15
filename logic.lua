LineageTrader = {}

local list = {}

Subscribe('PLAYER_LOGIN', function()
    if not LineageTraderSaved then
        LineageTraderSaved = {}
    end
    list = LineageTraderSaved
end)

local function Say(text)
    SendChatMessage(text, "CHANNEL", nil, 7)
end

local i = 1
local function SaySell()
    if #list > 0 then
        local msg = 'Продам '
        local newMsg = ''
        local firstI = i
        repeat
            newMsg = list[i].link
            msg = msg .. newMsg
            i = i + 1
            while i > #list do
                i = i - #list
            end
        until #msg + #list[i].link >= 255 or i == firstI
        Say(msg)
    end
end

Subscribe("ADD", function(link, number, price)
    table.insert(list, {
        link = link,
        number = number,
        price = price
    })
end)

local updateFrame = CreateFrame('frame')

Subscribe('START', function()
    SaySell()
    local elapsedTime = 0
    local targetTime = 30 + math.random() * 30
    updateFrame:SetScript("OnUpdate", function(_, deltaTime)
        elapsedTime = elapsedTime + deltaTime
        if (elapsedTime >= targetTime) then
            SaySell()
            elapsedTime = 0
            targetTime = 30 + math.random() * 30
        end
    end)
end)

Subscribe('CLEAR', function()
    i = 1
    while #list > 0 do
        table.remove(list, #list)
    end
end)

Subscribe('STOP', function()
    updateFrame:SetScript("OnUpdate", nil)
end)

Subscribe('WHAT', function()
    local msg = ""
    for i, item in ipairs(list) do
        msg = msg .. item.link
    end
    print(msg)
end)
