local eventHandler = CreateFrame("Frame")
eventHandler:SetScript('OnEvent', function(_, eventType)
    if eventType == 'CHAT_MSG_WHISPER' then
        PlaySoundFile("Interface\\AddOns\\LineageTrader\\message.mp3")
    end
end)
eventHandler:RegisterEvent('CHAT_MSG_WHISPER')