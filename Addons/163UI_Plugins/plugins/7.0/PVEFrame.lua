--[[--
	PLUGIN: PVEFrame		--	Emmmmmmm, it contains PVPUI...
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
local format, next, min = string.format, next, math.min;
local C_ChallengeMode_GetMapUIInfo = C_ChallengeMode.GetMapUIInfo;
local C_ChallengeMode_GetGuildLeaders = C_ChallengeMode.GetGuildLeaders;
local C_Texture_GetAtlasInfo = C_Texture.GetAtlasInfo;
local C_MythicPlus_GetSeasonBestForMap = C_MythicPlus.GetSeasonBestForMap;
local GetAchievementInfo = GetAchievementInfo;
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo;
local GameTooltip = GameTooltip;
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;


local _WeeklyChestRewardsInfo = {
	-- levels        1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17    18    19    20
	--	drop, weekly, currency
	["bfa-s4"] = {
		Challenges = {
			D = { nil,  435,  435,  440,  445,  445,  450,  455,  455,  455,  460,  460,  460,  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,  465, },
			W = { nil,  440,  445,  450,  450,  455,  460,  460,  460,  465,  465,  470,  470,  470,  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,  475, },
			C = { nil,  nil,  nil,  nil,  nil,   75,  330,  365,  400, 1700, 1790, 1880, 1970, 2060, 2150, 2240, 2330, 2420, 2510, 2600, 2665, 2730, 2795, 2860, 2915, },
		},
		PVP = {
			R =  { "0000~1399", "1400~1599", "1600~1799", "1800~2099", "2100~2399", "2400~9999" },
			D =  { 430,         440,         450,         455,         460,         465 },
			W =  { 445,         455,         460,         465,         470,         475 },
			W2 = { 445,         460,         460,         475,         475,         475 },
		},
	},
	["sl-s1"] = {
		Challenges = {
			D = { nil,  187,  190,  194,  194,  197,  200,  200,  200,  207,  207,  207,  207,  207,  210, },
			W = { nil,  200,  203,  207,  210,  210,  213,  216,  216,  220,  220,  223,  223,  226,  226, },
			C = { nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil, },
		},
		PVP = {
			R =  { "0000~1399", "1400~1599", "1600~1799", "1800~2099", "2100~2399", "2400~9999" },
			-- D =  { 430,         440,         450,         455,         460,         465 },
			W =  { 200,         207,         213,         220,         226,         "226/武器233" },
		},
	},
	["sl-s2"] = {
		Challenges = {
			D = { nil,  210,  213,  216,  220,  223,  223,  226,  226,  229,  229,  233,  233,  236,  236, },
			C = { nil,  210,  210,  213,  216,  220,  220,  223,  223,  226,  226,  229,  229,  233,  233, },
			W = { nil,  226,  226,  226,  229,  229,  233,  236,  236,  239,  242,  246,  246,  249,  252, },
			-- C = { nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil, },
		},
		PVP = {
			R =  { "0000~1399", "1400~1599", "1600~1799", "1800~2099", "2100~2399", "2400~9999" },
			-- D =  { 430,         440,         450,         455,         460,         465 },
			W =  { 200,         207,         213,         220,         226,         "226/武器233" },
		},
	},
	["sl-s3"] = {
		Challenges = {
			D =	time() < 1646866800 and
					{ nil,  236,  239,  242,  246,  249,  249,  252,  252,  255,  255,  255,  255,  255,  255, }
				or	{ nil,  236,  239,  242,  246,  249,  249,  252,  252,  255,  255,  259,  259,  262,  262, },
			C =	time() < 1646866800 and
					{ nil,  236,  239,  242,  246,  249,  249,  252,  252,  255,  255,  259,  259,  262,  262, }
				or	{ nil,  236,  239,  242,  246,  249,  249,  252,  252,  255,  255,  255,  255,  255,  255, },
			W =	time() < 1646866800 and
					{ nil,  226,  226,  226,  229,  229,  233,  236,  236,  239,  242,  246,  246,  249,  252, }
				or	{ nil,  252,  252,  252,  255,  255,  259,  262,  262,  265,  268,  272,  272,  275,  278, },
			-- C = { nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil,  nil, },
		},
		PVP = {
			R =  { nil, "1200~1399", "1400~1599", "1600~1799", "1800~1949", "1950~2099", "2100~2399", "2400~9999" },
			-- D =  { nil, 430,         440,         450,         455,         460,         465 },
			W =  { nil, "255(268)",  "259(272)",  "262(275)",  "265(278)",  "268(281)",  "272(285)",  "275(285)" },
		},
	},
};
local _MapID_BFA = { 244, 245, 249, 252, 353, 250, 247, 251, 246, 248, 369, 370, };
local _MapID_SL = { 376, 379, 375, 378, 381, 382, 377, 380, };
local _AchievementInfo = {
	leg = { 11185, nil, nil, },
	["bfa-s4"] = { 14144, 14145, _MapID_BFA, },
	["bfa-s3"] = { 13780, 13781, _MapID_BFA, },
	["bfa-s2"] = { 13448, 13449, _MapID_BFA, },
	["bfa-s1"] = { 13079, 13080, _MapID_BFA, },
	["sl-s1"] = { 14531, 14532, _MapID_SL, },
	["sl-s2"] = { 14531, 14532, _MapID_SL, },
	["sl-s3"] = { 14531, 14532, _MapID_SL, },
};
local _current = "sl-s3";
--/run local A,t=GetAchievementCriteriaInfo,{} for i=375,382 do t[C_ChallengeMode.GetMapUIInfo(i)]=i;end for i=1,8 do local n1,n2=A(14531,i),A(14532,i) print(i,t[n1],t[n2],n1) end
--/run local t={} for i=375,382 do t[C_ChallengeMode.GetMapUIInfo(i)]=i;end for i=1,8 do local n=GetAchievementCriteriaInfo(14531,i) print(i,t[n],n) end
--/run local t={} for i=375,382 do t[C_ChallengeMode.GetMapUIInfo(i)]=i;end for i=1,8 do local n=GetAchievementCriteriaInfo(14532,i) print(i,t[n],n) end
--/run for i, icon in pairs(ChallengesFrame.DungeonIcons) do print(C_ChallengeMode.GetMapUIInfo(icon.mapID), icon.mapID) end
--/run for i=1,12 do print(GetAchievementCriteriaInfo(14144,i),GetAchievementCriteriaInfo(14145,i)) end


do		--	史诗地下城标签
	local _enabled = true;

	local _ChallengesFrameGuildBest = nil;
	local _GuildBestLines = {  };

	local function _LineOnEnter(self)
		local _info = self._info;

		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
		local name = C_ChallengeMode_GetMapUIInfo(_info.mapChallengeModeID);
		GameTooltip:SetText(name, 1, 1, 1);
		GameTooltip:AddLine(format(CHALLENGE_MODE_POWER_LEVEL, _info.keystoneLevel));
		for i = 1, #_info.members do
			GameTooltip:AddLine(format(
				CHALLENGE_MODE_GUILD_BEST_LINE,
				RAID_CLASS_COLORS[_info.members[i].classFileName].colorStr,
				_info.members[i].name
			));
		end
		GameTooltip:Show();
	end
	local function _LineOnLeave(self)
		if GameTooltip:GetOwner() == self then
			GameTooltip:Hide();
		end
	end
	local function main()
		if _enabled and _ChallengesFrameGuildBest ~= nil then
			local _LeaderInfos = C_ChallengeMode_GetGuildLeaders();
			local _NumLeaderInfos = #_LeaderInfos;
			if _NumLeaderInfos > 0 then
				_ChallengesFrameGuildBest:Show();
				for _index = 1, _NumLeaderInfos do
					local _info = _LeaderInfos[_index];
					local _line = _GuildBestLines[_index];
					if _line == nil then
						_line = CreateFrame('FRAME', nil, _ChallengesFrameGuildBest);
							_line:SetSize(130, 18)
							_line:SetPoint("TOPLEFT", _ChallengesFrameGuildBest._Title, "BOTTOMLEFT", 0, 11 - 18 * _index)
							_line:SetScript("OnEnter", _LineOnEnter)
							local _CharacterName = _line:CreateFontString(nil, "ARTWORK", "GameFontNormal");
								_CharacterName:SetWidth(104);
								_CharacterName:SetPoint("LEFT");
								_CharacterName:SetJustifyH("LEFT");
							_line._CharacterName = _CharacterName;
							local _Level = _line:CreateFontString(nil, "ARTWORK", "GameFontNormal");
								_Level:SetWidth(26);
								_Level:SetPoint("RIGHT");
								_Level:SetJustifyH("RIGHT");
							_line._Level = _Level;
						_GuildBestLines[_index] = _line;
					end
					_line._info = _info;
					_line._CharacterName:SetText(format(
						_info.isYou and CHALLENGE_MODE_GUILD_BEST_LINE_YOU or CHALLENGE_MODE_GUILD_BEST_LINE,
						RAID_CLASS_COLORS[_info.classFileName].colorStr,
						_info.name
					));
					_line._Level:SetText(_info.keystoneLevel);
					_line:Show();
				end
			else
				_ChallengesFrameGuildBest:Hide();
			end
			for _index = _NumLeaderInfos + 1, #_GuildBestLines do
				_GuildBestLines[_index]:Hide();
			end
		end
	end

	local _ChallengesData = _WeeklyChestRewardsInfo[_current].Challenges;
	local _PVPData = _WeeklyChestRewardsInfo[_current].PVP;
	local _AchievementData = _AchievementInfo[_current];

	local _CD, _CW, _CC = _ChallengesData.D, _ChallengesData.W, _ChallengesData.C;
	local _CN = max(#_CD, #_CW, #_CC);
	local function _ChallengesWeeklyChestOnEnter(self)
		if GameTooltip:IsVisible() then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine("   层数     限时     超时     周箱");
			for _level = 2, _CN do
				if _CW[_level] or _CC[_level] then
					local line = "  %2d层   |T130758:10:15:0:0:32:32:10:22:10:22|t %s    |T130758:10:10:0:0:32:32:10:22:10:22|t %s |T130758:10:15:0:0:32:32:10:22:10:22|t %4d";
					local d = _CD[_level] or " ? ";
					local w = _CW[_level] or " ? ";
					local c = _CC[_level] or "  ? ";
					if _level == self.level then line = "|cff00ff00" .. line .. "|r" end
					GameTooltip:AddLine(format(line, _level, d, c, w))
				else
					break
				end
			end
			GameTooltip:Show()
		end
	end

	local _PR, _PW = _PVPData.R, _PVPData.W;
	local _PN = max(#_PR, #_PW);
	local function _PVPWeeklyChestOnEnter(self)
		if GameTooltip:IsVisible() then
			GameTooltip:AddLine(" ");
			GameTooltip:AddLine("  PVP等级          低保");	--	PVP等级  比赛结束  低保散件  低保特质
			for _level = 2, _PN do
				if _PR[_level] or _PW[_level] then
					-- local line = " %s |T130758:10:28:0:0:32:32:10:22:10:22|t %4s |T130758:10:35:0:0:32:32:10:22:10:22|t %s";
					local line = " %s |T130758:10:28:0:0:32:32:10:22:10:22|t %4s";
					local r = _PR[_level] or " ? ";
					local w = _PW[_level] or " ? ";
					if _level == self.level then line = "|cff00ff00" .. line .. "|r" end
					GameTooltip:AddLine(format(line, r, w));
				else
					break
				end
			end
			GameTooltip:Show()
		end
	end

	local _AID10, _AID15, _AMapID = _AchievementData[1], _AchievementData[2], _AchievementData[3];
	--[==[
	local _crits_completed = {  };
	local function _ChallengesFrame_IconOnEnter(self)
		local _mapID = self.mapID;
		local _, _, _, _completed10, _, _, _, _, _, _, _, _, _wasEarnedByMe = GetAchievementInfo(_AID10);
		local _, _, _, _completed15, _, _, _, _, _, _, _, _, _wasEarnedByMe = GetAchievementInfo(_AID15);
		local _Level = _crits_completed[_mapID] or 0;
		if _completed15 or _completed10 or _Level >= 10 then
			GameTooltip:AddLine("  ");
			GameTooltip:AddLine("有爱提供：");
			--https://wow.tools/dbc/?dbc=uitextureatlasmember&build=8.3.0.33237#search=VignetteKillElite&page=1
			--https://wow.tools/dbc/?dbc=manifestinterfacedata&build=8.3.0.33237#search=1121272&page=1
			if _completed10 or _Level >= 10 then
				local atlas = C_Texture_GetAtlasInfo("VignetteKill");
				local texCoord = format("%d:%d:%d:%d", atlas.leftTexCoord * 1024,atlas.rightTexCoord * 1024,atlas.topTexCoord * 512,atlas.bottomTexCoord * 512);
				GameTooltip:AddLine("\124TInterface/Minimap/ObjectIconsAtlas:16:16:0:0:1024:512:" .. texCoord .. "\124t 已限时10层");
			end
			if _completed15 or _Level >= 15 then
				local atlas = C_Texture_GetAtlasInfo("VignetteKillElite");
				local texCoord = format("%d:%d:%d:%d", atlas.leftTexCoord * 1024,atlas.rightTexCoord * 1024,atlas.topTexCoord * 512,atlas.bottomTexCoord * 512);
				GameTooltip:AddLine("\124TInterface/Minimap/ObjectIconsAtlas:16:16:0:0:1024:512:" .. texCoord .. "\124t 已限时15层");
			end
			GameTooltip:Show();
		end
	end
	local function _ChallengesFrame_Update(self)
		_crits_completed = {  };
		local _, _, _, _completed10, _, _, _, _, _, _, _, _, _wasEarnedByMe = GetAchievementInfo(_AID10);
		local _, _, _, _completed15, _, _, _, _, _, _, _, _, _wasEarnedByMe = GetAchievementInfo(_AID15);
		for _index = 1, #_AMapID do
			local _mapID = _AMapID[_index];
			local _, _, _, complete = GetAchievementCriteriaInfo(_AID15, _index);
			if complete == 1 then
				_crits_completed[_mapID] = 15;
			else
				_, _, _, complete = GetAchievementCriteriaInfo(_AID10, _index);
				if complete == 1 then
					_crits_completed[_mapID] = 10;
				else
					_crits_completed[_mapID] = 0;
				end
			end
		end

		for i, icon in next, ChallengesFrame.DungeonIcons do
			local _mapID = icon.mapID;
			if icon._Tex == nil then
				local _Tex = icon:CreateTexture(nil, "ARTWORK");
				_Tex:SetSize(24,24);
				_Tex:SetPoint("BOTTOM", 0, -3);
				icon._Tex = _Tex;
				icon:HookScript("OnEnter", _ChallengesFrame_IconOnEnter);
			end
			local inTimeInfo, overtimeInfo = C_MythicPlus_GetSeasonBestForMap(_mapID);
			if inTimeInfo then
				_crits_completed[_mapID] = max(_crits_completed[_mapID] or 0, inTimeInfo.level or 0);
			end
			local _Level = _crits_completed[_mapID] or 0;
			if _completed15 or _Level >= 15 then
				icon._Tex:SetAtlas("VignetteKillElite");
				icon._Tex:Show();
			elseif _completed10 or _Level >= 10 then
				icon._Tex:SetAtlas("VignetteKill");
				icon._Tex:Show();
			else
				icon._Tex:Hide();
			end
		end
	end
	--]==]
	--[==[
	local _crits_completed = {  };
	local function _ChallengesFrame_IconOnEnter(self)
		local _mapID = self.mapID;
		local _Level = _crits_completed[_mapID] or 0;
		if _Level >= 10 then
			GameTooltip:AddLine("  ");
			GameTooltip:AddLine("有爱提供：");
			--https://wow.tools/dbc/?dbc=uitextureatlasmember&build=8.3.0.33237#search=VignetteKillElite&page=1
			--https://wow.tools/dbc/?dbc=manifestinterfacedata&build=8.3.0.33237#search=1121272&page=1
			if _Level >= 10 then
				local atlas = C_Texture_GetAtlasInfo("VignetteKill");
				local texCoord = format("%d:%d:%d:%d", atlas.leftTexCoord * 1024,atlas.rightTexCoord * 1024,atlas.topTexCoord * 512,atlas.bottomTexCoord * 512);
				GameTooltip:AddLine("\124TInterface/Minimap/ObjectIconsAtlas:16:16:0:0:1024:512:" .. texCoord .. "\124t 已限时10层");
			end
			if _Level >= 15 then
				local atlas = C_Texture_GetAtlasInfo("VignetteKillElite");
				local texCoord = format("%d:%d:%d:%d", atlas.leftTexCoord * 1024,atlas.rightTexCoord * 1024,atlas.topTexCoord * 512,atlas.bottomTexCoord * 512);
				GameTooltip:AddLine("\124TInterface/Minimap/ObjectIconsAtlas:16:16:0:0:1024:512:" .. texCoord .. "\124t 已限时15层");
			end
			GameTooltip:Show();
		end
	end
	local function _ChallengesFrame_Update(self)
		_crits_completed = {  };
		for i, icon in next, ChallengesFrame.DungeonIcons do
			local _mapID = icon.mapID;
			if icon._Tex == nil then
				local _Tex = icon:CreateTexture(nil, "ARTWORK");
				_Tex:SetSize(24,24);
				_Tex:SetPoint("BOTTOM", 0, -3);
				icon._Tex = _Tex;
				icon:HookScript("OnEnter", _ChallengesFrame_IconOnEnter);
			end
			local inTimeInfo, overtimeInfo = C_MythicPlus_GetSeasonBestForMap(_mapID);
			if inTimeInfo then
				_crits_completed[_mapID] = inTimeInfo.level or 0;
			end
			local _Level = _crits_completed[_mapID] or 0;
			if _Level >= 15 then
				icon._Tex:SetAtlas("VignetteKillElite");
				icon._Tex:Show();
			elseif _Level >= 10 then
				icon._Tex:SetAtlas("VignetteKill");
				icon._Tex:Show();
			else
				icon._Tex:Hide();
			end
		end
	end
	--]==]
	local function _ChallengesFrame_Update(self)
		local _s = C_PlayerInfo.GetPlayerMythicPlusRatingSummary('player');
		local id2s = {  };
		if _s ~= nil and _s.runs ~= nil then
			for _, run in next, _s.runs do
				id2s[run.challengeModeID] = run.mapScore;
			end
		end
		for i, icon in next, ChallengesFrame.DungeonIcons do
			local score = id2s[icon.mapID];
			if icon._Text == nil then
				icon._Text = icon:CreateFontString(nil, "OVERLAY");
				icon._Text:SetPoint("BOTTOM", 0, 4);
				icon._Text:SetFont(GameFontNormal:GetFont(), 20, "OUTLINE");
			end
			if score ~= nil and score > 0 then
				local r, g, b = icon.HighestLevel:GetTextColor();
				icon._Text:SetTextColor(r or 1.0, g or 1.0, b or 1.0, 1.0);
				icon._Text:SetText(score);
			end
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		__meta._F_metaDependCall(
			"Blizzard_ChallengesUI",
			function()
				_ChallengesFrameGuildBest = CreateFrame('FRAME', nil, ChallengesFrame);
					_ChallengesFrameGuildBest:SetSize(160, 110);
					_ChallengesFrameGuildBest:SetPoint("TOPRIGHT", -5, -20)
					local _BG = _ChallengesFrameGuildBest:CreateTexture(nil, "BACKGROUND");
						_BG:SetAllPoints();
						_BG:SetTexture([[Interface\Challenges\ChallengeModeHud]]);
						_BG:SetTexCoord(0.387695, 0.631836, 0.00195312, 0.216797);
					_ChallengesFrameGuildBest._BG = _BG;
					local _Title = _ChallengesFrameGuildBest:CreateFontString(nil, "ARTWORK", "GameFontNormalMed2");
						_Title:SetPoint("TOPLEFT", 15, -7);
						_Title:SetText(CHALLENGE_MODE_GUILD_BEST);
					_ChallengesFrameGuildBest._Title = _Title;
					local _Line = _ChallengesFrameGuildBest:CreateTexture(nil, "ARTWORK");
						_Line:SetSize(146, 9);
						_Line:SetPoint("TOP", 0, -20);
						_Line:SetTexture([[Interface\Challenges\ChallengeModeHud]]);
						_Line:SetTexCoord(0.387695, 0.576172, 0.554688, 0.572266);
					_ChallengesFrameGuildBest._Line = _Line;
				ChallengesFrame:HookScript("OnShow", main);
				__meta._F_metaOnEvent("CHALLENGE_MODE_LEADERS_UPDATE", main);
				-- hooksecurefunc("ChallengesFrame_Update", main);
				ChallengesFrame.WeeklyInfo.Child.WeeklyChest:HookScript("OnEnter", _ChallengesWeeklyChestOnEnter);
				hooksecurefunc("ChallengesFrame_Update", _ChallengesFrame_Update);
			end
		);
		__meta._F_metaDependCall(
			"Blizzard_PVPUI",
			function()
				PVPQueueFrame.HonorInset.RatedPanel.WeeklyChest:HookScript("OnEnter", _PVPWeeklyChestOnEnter);
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:HookScript("OnEnter", _PVPWeeklyChestOnEnter);
			end
		);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and ChallengesFrame ~= nil and ChallengesFrame:IsShown() then
			main();
		end
	end
	local function _Disable(loading)
		_enabled = false;
	end

	__plugins['PVEFrame'] = { _Enable, _Disable, };
end


do		--	侧边栏统计列表
	local _enabled = true;
	local _panels = {  };

	local _ChallengesWeeklyData = _WeeklyChestRewardsInfo[_current].Challenges.W;
	--	Credit to 'https://wago.io/weeklymythicplus' @灵魂复苏SoulAwaken
	local function sortfunc(v1, v2)
		if v1.level == v2.level then
			return v1.mapChallengeModeID < v2.mapChallengeModeID;
		else
			return v1.level > v2.level;
		end
	end
	local function colorByCompleted(level, completed)
		return (completed and "|cff00ff00" or "|cffff0000") .. "+" .. level .. "|r";
	end
	local function Update(panel)
		local RunHistory = C_MythicPlus.GetRunHistory(false, true);
		sort(RunHistory, sortfunc)
		local num = #RunHistory;

		local text = "大秘最佳TOP10:\n";
		local ByName = {  };
		if num > 0 then
			for index = 1, num do
				local run = RunHistory[index];
				local name = C_ChallengeMode.GetMapUIInfo(run.mapChallengeModeID);

				if index <= 10 then
					if index == 1 or index == 4 or index == 10 then
						local reward = _ChallengesWeeklyData[min(run.level, 15)];
						text = text .. colorByCompleted(run.level, run.completed) .. " " .. name .. " |cffa335ee(" .. reward .. " 装等选项)|r\n"
					else
						text = text .. colorByCompleted(run.level, run.completed) .. " " .. name .. "\n";
					end
				end

				local mem = ByName[name];
				if mem == nil then
					ByName[name] = { run };
				else
					mem[#mem + 1] = run;
				end
			end
		else
			text = text .. " 本周无\n";
		end

		text = text .. "\n本周大秘纪录 (总计 " .. num .. " ):\n";
		for name, list in next, ByName do
			text = text  .. name .. ": [";
			local num = #list;
			if num > 1 then
				for index = 1, num - 1 do
					local run = list[index];
					text = text .. colorByCompleted(run.level, run.completed) .. ", ";
				end
				local run = list[num];
				text = text .. colorByCompleted(run.level, run.completed);
			else
				local run = list[1];
				text = text .. colorByCompleted(run.level, run.completed);
			end
			text = text .. "]\n";
		end

		panel.Text:SetText(text);
	end
	local function Create(P)
		local panel = CreateFrame('FRAME', nil, P);
		panel:SetSize(1, 1);
		panel:SetPoint("TOPLEFT", P, "TOPRIGHT", 4, 0);
		panel:EnableMouse(false);
		local Text = panel:CreateFontString(nil, "OVERLAY");
		Text:SetPoint("TOPLEFT");
		Text:SetFont(GameFontNormal:GetFont(), 18, "OUTLINE");
		Text:SetJustifyH("LEFT");
		panel.Text = Text;

		_panels[P] = panel;
		return panel;
	end
	_G.UpdateRunHistory = Update;
	local function hook(P)
		if P ~= nil then
			local panel = Create(P);
			P.RunHistoryPanel = panel;
			panel:SetShown(_enabled);
			P:HookScript("OnShow", function()
				if _enabled then
					Update(panel);
				end
			end);
		end
	end
	hook(PVEFrame);
	CoreDependCall("Blizzard_WeeklyRewards", function()
		hook(WeeklyRewardsFrame);
	end);

	__plugins['RunHistory'] = {
		[1] = function(loading)
			_enabled = true;
			for _, panel in next, _panels do
				panel:Show();
				Update(panel);
			end
		end,
		[2] = function(loading)
			_enabled = false;
			for _, panel in next, _panels do
				panel:Hide();
				Update(panel);
			end
		end,
	};
end

