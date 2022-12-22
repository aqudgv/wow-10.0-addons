U1PLUG["FiveCombo"] = function()
--------------------------------------------------------------------------------
-- FiveCombo.lua
-- 作者：盒子哥
-- 日期：2012-05-07
-- 描述：盗贼、德鲁伊的5星技能提示
-- 版权所有（c）多玩游戏网
--------------------------------------------------------------------------------

--[[
斩击 2098
切割 315496,
刺骨196819,
肾击408,
正中眉心315341,
割裂1943,
毒伤32645,
猩红风暴121411,
黑火药319175,
影分身280719, 

野蛮咆哮 52610
割裂 1079
割碎      22570
凶猛撕咬 22568
]]
local OverlayedSpellID = {};
-- 盗贼
OverlayedSpellID["ROGUE"] = {
	2098,
	315496,
	196819,
	408,
	315341,
	1943,
	32645,
	121411,
	319175,
	280719,  
};
-- 德鲁伊
OverlayedSpellID["DRUID"] = {
	52610,
	1079,
	22568,
	22570,
};

local GlowSpells = {}
for k,v in pairs(OverlayedSpellID) do
    for _, spell in ipairs(v) do
        GlowSpells[spell] = true
    end
end

local function comboEventFrame_OnEvent(self, event, ...)
	local parent = self:GetParent();
	local points = UnitPower("player", 4)
	local spellType, id, subType  = GetActionInfo(parent.action);

    local spellId
    if spellType == "spell" then
        spellId = id
    elseif spellType == "macro" then
        spellId = GetMacroSpell(id)
    end

    if not spellId or (not GlowSpells[spellId] and not IsSpellOverlayed(spellId)) then
        CoreUIHideOverlayGlow(parent)
        return
    end

	if (points == UnitPowerMax("player", 4)) then
        CoreUIShowOverlayGlow(parent);
	elseif not IsSpellOverlayed(spellId) then
		CoreUIHideOverlayGlow(parent);
	end
end

local function myActionButton_OnUpdate(self, elapsed)
	if self == nil then
		return;
	end
    if self.comboEventFrame then return end
	self.comboEventFrame = CreateFrame("Frame", nil, self);
	self.comboEventFrame.countTime = 0;
	self.comboEventFrame:RegisterEvent("UNIT_POWER_UPDATE");
	self.comboEventFrame:RegisterEvent('UNIT_POWER_FREQUENT')
	self.comboEventFrame:RegisterEvent('UNIT_MAXPOWER')
	self.comboEventFrame:SetScript("OnEvent", comboEventFrame_OnEvent);
end

if ActionBarActionButtonMixin ~= nil then
	for i = 1, 12 do
		myActionButton_OnUpdate(_G["ActionButton"..i]);
		myActionButton_OnUpdate(_G["MultiBarBottomLeftButton"..i]);
		myActionButton_OnUpdate(_G["MultiBarBottomRightButton"..i]);
		myActionButton_OnUpdate(_G["MultiBarLeftButton"..i]);
		myActionButton_OnUpdate(_G["MultiBarRightButton"..i]);
	end
	hooksecurefunc(ActionBarActionButtonMixin, "OnUpdate", myActionButton_OnUpdate);
elseif ActionButton_UpdateHotkeys ~= nil then
	hooksecurefunc("ActionButton_OnUpdate", myActionButton_OnUpdate);
end

end