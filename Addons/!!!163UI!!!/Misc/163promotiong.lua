do return end
local _EventVehicle = CreateFrame("Frame", nil, UIParent);

_EventVehicle:SetScript("OnEvent", function(self)
    C_Timer.After(4.0, function()
        SendSystemMessage("魔兽新春打折季 大神有爱送补贴！");
        SendSystemMessage("复制链接到浏览器参与：");
        SendSystemMessage("http://dwz.date/efFp");
    end);
    self:UnregisterAllEvents();
    self:SetScript("OnEvent", nil);
end);
_EventVehicle:RegisterEvent("PLAYER_ENTERING_WORLD");
_EventVehicle = nil;
