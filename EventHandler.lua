local frame = CreateFrame('Frame')
local registeredEvents = {}
function Subscribe(eventName, callback)
    if not registeredEvents[eventName] then
        registeredEvents[eventName] = true
        frame:RegisterEvent(eventName)
    end
    local oldCallback = frame:GetScript('OnEvent')
    frame:SetScript('OnEvent', function(self, originEventName, ...)
        if oldCallback then
            oldCallback(self, originEventName, ...)
        end
        if originEventName == eventName then
            callback(...)
        end
    end)
end

function Emit(eventName, ...)
    local callback = frame:GetScript('OnEvent')
    if callback then
        callback(frame, eventName, ...)
    end
end
