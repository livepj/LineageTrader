local function InitializeLineageTrader()
    if not LineageTraderMainFrame then
        DEFAULT_CHAT_FRAME:AddMessage("LineageTrader: Main frame not loaded!");
        return;
    end

    SLASH_LINEAGETRADER1 = "/lineagetrader";
    SLASH_LINEAGETRADER2 = "/lt";

    SlashCmdList["LINEAGETRADER"] = function()
        if LineageTraderMainFrame:IsShown() then
            LineageTraderMainFrame:Hide();
        else
            LineageTraderMainFrame:Show();
        end
    end
end

local eventFrame = CreateFrame("Frame");
eventFrame:RegisterEvent("ADDON_LOADED");
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if arg1 == "LineageTrader" then
        InitializeLineageTrader();
    end
end);