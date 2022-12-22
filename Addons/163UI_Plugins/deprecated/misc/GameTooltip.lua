--[[--
	ala
--]]--
do return end
----------------------------------------------------------------------------------------------------
local math,table,string,pairs,type,select,tonumber,unpack=math,table,string,pairs,type,select,tonumber,unpack;
local strmatch, format, gsub = strmatch, format, gsub;
local ItemRefTooltip = ItemRefTooltip
----------------------------------------------------------------------------------------------------
local SupportedLinkType={
	["item"] = 1,
	["spell"] = 1,
	["achievement"] = 1,
	["currency"] = 1,
	["quest"] = 1,
	["instancelock"] = 1,
	["enchant"] = 1,
	["talent"] = 1,
};

local _LINK, _TYPE, _ID = nil, nil, nil;

local _tempTooltip20121001120030 = CreateFrame("GameTooltip", "_tempTooltip20121001120030", UIParent, "GameTooltipTemplate");
_tempTooltip20121001120030:Hide();
_tempTooltip20121001120030:SetOwner(UIParent, "ANCHOR_NONE");
local function GetLinkName(body)
	_tempTooltip20121001120030:ClearLines();
	_tempTooltip20121001120030:SetHyperlink(body);
	return _tempTooltip20121001120030TextLeft1:GetText() or "name missing";
end

local GetLLink = {
	item = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				local _, _, body = strfind(pat, "(item:[0-9a-zA-Z:-]+)");
				local _, link = GetItemInfo(id);
				return gsub(link, "item:[0-9a-zA-Z:-]+", body);
			end
		end
	end,
	spell = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				return GetSpellLink(id);
			end
		end
	end,
	achievement = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				local _, _, body = strfind(pat, "(achievement:[0-9a-zA-Z:-]+)");
				local _, name = GetAchievementInfo(id);
				return format("\124cffffff00\124H%s\124h[%s]\124h\124r", body, name);
			end
		end
	end,
	currency = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				return C_CurrencyInfo.GetCurrencyLink(id, 0);
			end
		end
	end,
	quest = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				local _, _, body = strfind(pat, "(quest:[0-9a-zA-Z:-]+)");
				local _, _, level = strfind(body, "(%d+$)");
				level = level and tonumber(level) or UnitLevel("player");
				local color = GetQuestDifficultyColor(level);
				return format("\124cff%.2x%.2x%.2x\124H%s\124h[%s]\124h\124r", color.r * 255, color.g * 255, color.b * 255, body, GetLinkName(pat));
			end
		end
	end,
	instancelock = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				local _, _, body = strfind(pat, "(instancelock:[0-9a-zA-Z:-]+)");
				local _, _, inst = strfind(body, "instancelock:[^:]+:(%d+)");
				local name = nil;
				if inst ~= nil and inst ~= "" then
					name = GetRealZoneText(tostring(inst));
				end
				if name == nil then
					local _ = nil;
					_, _, name = strfind(GetLinkName(pat), "在(.+)副本中");
				end
				return format("\124cffff8000\124H%s\124h[%s]\124h\124r", body, name);
			end
		end
	end,
	enchant = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				local link = GetSpellLink(id);
				return gsub(link, "\124cff71d5ff\124Hspell[0-9:]+", "\124cffffd000\124Henchant:" .. id);
			end
		end
	end,
	talent = function(id, pat)
		if pat ~= nil and pat ~= "" then
			if strfind(pat, "%[") then
				return pat;
			else
				local _, _, body = strfind(pat, "(%l+:[0-9a-zA-Z:-]+)");
				local sname, sid = ItemRefTooltip:GetSpell();
				local link = GetSpellLink(sid);
				return gsub(link, "spell:[0-9:]+", body);
			end
		end
	end,
};
--------------------------------------------------GameTooltip
local function _setHyperLink(self, _link, ...)
	local _type, _id = strmatch(_link, "(%D+):(%d+)");
	if SupportedLinkType[_type] then
		if _id ~= nil then
			_LINK = _link;
			_TYPE = _type;
			_ID = tonumber(_id);
		else
			_LINK = _link;
			_TYPE = nil;
			_ID = nil;
		end
	else
		_LINK = nil;
		_TYPE = nil;
		_ID = nil;
	end
	-- self:AddDoubleLine("id:",_id)
	-- self:Show()
end
hooksecurefunc(ItemRefTooltip, "SetHyperlink", _setHyperLink);

local function onDragStart(self)
	ItemRefTooltip:StartMoving();
end
local function onDragStop(self)
	ItemRefTooltip:StopMovingOrSizing();
end
local function onClick(self,b,d)
	if IsModifiedClick() then
		if _LINK ~= nil then
			local func = GetLLink[_TYPE];
			if func ~= nil then
				local link = func(_ID, _LINK);
				if _TYPE == "instancelock" then
					local eb = ChatEdit_ChooseBoxForSend();
					if eb:HasFocus() then
						eb:Insert(link);
					end
				else
					if IsAltKeyDown() then
						local _id = strmatch(_link, "achievement:(%d+):");
						if _id ~= nil then
							_id = tonumber(_id);
							local editBox = ChatEdit_ChooseBoxForSend()
							editBox:Show()
							editBox:SetFocus()
							editBox:Insert(GetAchievementLink(_id))
						else
							HandleModifiedItemClick(link);
						end
					else
						if InCombatLockdown() and IsControlKeyDown() and (DressUpFrame == nil or not DressUpFrame:IsShown()) then
						else
							HandleModifiedItemClick(link);
						end
					end
				end
			end
		end
	else
		if _TYPE == "achievement" then
			if not AchievementFrame then
				AchievementFrame_LoadUI();
			end
			if not AchievementFrame:IsShown() then
				if InCombatLockdown() then
					AchievementFrame:Show();
				else
					AchievementFrame_ToggleAchievementFrame();
				end
			end
			AchievementFrame_SelectAchievement(_ID);
		elseif _TYPE == "quest" then
			local index = GetQuestLogIndexByID(_ID);
			--if index>0 then QuestLog_OpenToQuest(index) end
		end
	end
end

local _button = CreateFrame("button", nil, ItemRefTooltip);
_button:Show();
_button:SetPoint("TOPLEFT", ItemRefTooltipTextLeft1, "TOPLEFT");
_button:SetPoint("BOTTOMRIGHT", ItemRefTooltipTextLeft1, "BOTTOMRIGHT");
ItemRefTooltip._button = _button;

_button:RegisterForDrag("LeftButton","RightButton");
_button:SetScript("OnDragStart",onDragStart);
_button:SetScript("OnDragStop",onDragStop);

_button:RegisterForClicks("AnyUp")
_button:SetScript("OnClick",onClick)

----------
do return end
local LinkHover = {}
LinkHover.show = {
   ["achievement"] = true,
   ["enchant"]     = true,
   ["glyph"]       = true,
   ["item"]        = true,
   ["quest"]       = true,
   ["spell"]       = true,
   ["talent"]      = true,
   ["unit"]        = true,
   ["instancelock"]= true,
   ["currency"]    = true,
}
---------------- > Show tooltips when hovering a link in chat (credits to Adys for his LinkHover)
function LinkHover.OnHyperlinkEnter(_this, linkData, link)
 	if not linkData then return;end
  local t = linkData:match("^(.-):")
   if LinkHover.show[t] then
      ShowUIPanel(GameTooltip)
      GameTooltip:SetOwner(_this, "ANCHOR_RIGHT")
      GameTooltip:SetHyperlink(link)
      GameTooltip:Show()
   end
end
function LinkHover.OnHyperlinkLeave(_this, linkData, link)
	if not linkData then return;end
   local t = linkData:match("^(.-):")
   if LinkHover.show[t] then
      HideUIPanel(GameTooltip)
   end
end
local function main()
   for i = 1, NUM_CHAT_WINDOWS do
      local frame = _G["ChatFrame"..i]
      frame:SetScript("OnHyperlinkEnter", LinkHover.OnHyperlinkEnter)
      frame:SetScript("OnHyperlinkLeave", LinkHover.OnHyperlinkLeave)
   end
end
main()
