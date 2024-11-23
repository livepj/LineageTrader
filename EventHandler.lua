function Subscribe(frame, eventName, callback)
    local oldCallback = frame:GetScript("OnEvent")
    frame:SetScript("OnEvent", function(self, originEventName, ...)
        if oldCallback then
            oldCallback(self, originEventName, ...)
        end
        if originEventName == eventName then
            callback(...)
        end
    end)
end

function Emit(frame, eventName, ...)
    local callback = frame:GetScript("OnEvent")
    if callback then
        callback(frame, eventName, ...)
    end
end
