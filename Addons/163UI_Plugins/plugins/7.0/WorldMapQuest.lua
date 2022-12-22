--[[--
	PLUGIN: WorldMapQuest
--]]--

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;


if __ns.__client._TocVersion < 70000 then
	return;
end

local __meta = __ns.__meta;
local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

local _F_coreDebug = __meta._F_coreDebug;
----------------------------------------------------------------

-->	upvalue
local next, floor = next, floor;
local C_TaskQuest = C_TaskQuest;
local C_TaskQuest_GetQuestTimeLeftSeconds, C_TaskQuest_GetQuestsForPlayerByMapID = C_TaskQuest.GetQuestTimeLeftSeconds, C_TaskQuest.GetQuestsForPlayerByMapID
local WorldMapFrame = WorldMapFrame;
local font = GameFontNormal:GetFont();


local SECONDS_1m = 60;
local SECONDS_1h = SECONDS_1m * 60;
local SECONDS_1D = SECONDS_1h * 24;
local SECONDS_1M = SECONDS_1D * 30;
local SECONDS_1Y = SECONDS_1M * 12;

local L = {  };
if GetLocale() == "zhCN" then
	L["DAY"] = "天";
	L["HOUR"] = "时";
	L["MINUTE"] = "分";
	L["SECOND"] = "秒";
elseif GetLocale() == "zhTW" then
	L["DAY"] = "天";
	L["HOUR"] = "時";
	L["MINUTE"] = "分";
	L["SECOND"] = "秒";
else
	L["DAY"] = "d";
	L["HOUR"] = "h";
	L["MINUTE"] = "m";
	L["SECOND"] = "s";
end


do		--	time
	local _enabled = true;
	local pool = {  };
	local wqpr = nil;
	local activePins = nil;

	local function echo_time(quest)
		local pin = activePins[quest];
		if pin ~= nil then
			local sec = C_TaskQuest_GetQuestTimeLeftSeconds(quest);
			local text = pool[pin];
			if text == nil then
				text = pin:CreateFontString(nil, "OVERLAY");
				text:SetFont(font, 28);
				text:SetPoint("TOP", pin, "BOTTOM");
				pool[pin] = text;
				local mask = pin:CreateTexture(nil, "ARTWORK");
				mask:SetPoint("TOPLEFT", text, 0, -1);
				mask:SetPoint("BOTTOMRIGHT", text, 0, -2);
				mask:SetColorTexture(0.0, 0.0, 0.0, 0.5);
			else
				text:Show();
			end
			-- local scale = pin:GetEffectiveScale();
			-- text:SetScale(scale);_F_coreDebug(scale, pin:GetWidth())
			if sec ~= nil then
				if sec > 3600 then
					text:SetVertexColor(0.0, 1.0, 0.0);
				elseif sec > 1800 then
					text:SetVertexColor((3600 - sec) / 1800, 1.0, 0.0);
				else
					text:SetVertexColor(1.0, 1.0 - sec / 1800, 0.0);
				end
				local str = nil;
				if sec >= SECONDS_1D then
					local D = sec / SECONDS_1D; D = D - D % 1.0; sec = sec - D * SECONDS_1D;
					local h = sec / SECONDS_1h; h = h - h % 1.0; sec = sec - h * SECONDS_1h;
					local m = sec / SECONDS_1m; m = m - m % 1.0; sec = sec - m * SECONDS_1m;
					str = D .. L["DAY"] .. h .. L["HOUR"] .. m .. L["MINUTE"];
				elseif sec >= SECONDS_1h then
					local h = sec / SECONDS_1h; h = h - h % 1.0; sec = sec - h * SECONDS_1h;
					local m = sec / SECONDS_1m; m = m - m % 1.0; sec = sec - m * SECONDS_1m;
					str = h .. L["HOUR"] .. m .. L["MINUTE"];
				elseif sec >= SECONDS_1m then
					local m = sec / SECONDS_1m; m = m - m % 1.0; sec = sec - m * SECONDS_1m;
					str = m .. L["MINUTE"] .. sec .. L["SECOND"];
				else
					str = sec .. L["SECOND"];
				end
				text:SetText(str);
			else
				text:SetText(nil);
			end
		end
	end
	local function main()
		if _enabled then
			local mapID = WorldMapFrame:GetMapID();
			local taskInfo = C_TaskQuest_GetQuestsForPlayerByMapID(mapID);
			if taskInfo ~= nil then
				for _, info in next, taskInfo do
					echo_time(info.questId);
				end
			end
		end
	end

	local _isInitialized = false;
	local function _Init(loading)
		for pr, _ in next, WorldMapFrame.dataProviders do
			if pr.GetPinTemplate and pr:GetPinTemplate() == "WorldMap_WorldQuestPinTemplate" then
				wqpr = pr;
				activePins = pr.activePins;
			end
		end
		if activePins ~= nil then
			_isInitialized = true;
			hooksecurefunc(wqpr, "RefreshAllData", main);
		end
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and activePins ~= nil then
			main();
		end
	end
	local function _Disable(loading)
		_enabled = false;
		for pin, text in next, pool do
			text:Hide();
		end
	end

	__plugins['WorldMapQuestTime'] = { _Enable, _Disable, };
end

do		--	GameTooltip
	-- GameTooltip.ItemTooltip.Count
	local ItemTooltip = GameTooltip.ItemTooltip;
	ItemTooltip.Count:ClearAllPoints();
	ItemTooltip.Count:SetPoint("TOP", ItemTooltip.Icon, "BOTTOM", 0, 0);
	ItemTooltip.Count:SetFont(ItemTooltip.Count:GetFont(), 12, "OUTLINE");
	-- ItemTooltip.Count:SetDrawLayer("OVERLAY", 7);
end
