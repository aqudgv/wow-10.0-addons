--[[--
	PLUGIN: FriendsFrame
--]]--

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;

local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

local BNET_CLIENT_DESTINY2 = BNET_CLIENT_DESTINY2 or "DST2";
local BNET_CLIENT_WTCG = BNET_CLIENT_WTCG or "WTCG";
local BNET_CLIENT_WOW = BNET_CLIENT_WOW or "WoW";
local BNET_CLIENT_COD_MW = BNET_CLIENT_COD_MW or "ODIN";
local BNET_CLIENT_SC = BNET_CLIENT_SC or "S1";
local BNET_CLIENT_D3 = BNET_CLIENT_D3 or "D3";
local BNET_CLIENT_HEROES = BNET_CLIENT_HEROES or "Hero";
local BNET_CLIENT_SC2 = BNET_CLIENT_SC2 or "S2";
local BNET_CLIENT_COD = BNET_CLIENT_COD or "VIPR";
local BNET_CLIENT_WC3 = BNET_CLIENT_WC3 or "W3";
local BNET_CLIENT_OVERWATCH = BNET_CLIENT_OVERWATCH or "Pro";
local BNET_CLIENT_APP = BNET_CLIENT_APP or "App";
local BNET_CLIENT_CLNT = BNET_CLIENT_CLNT or "CLNT";

----------------------------------------------------------------

-->	upvalue
local tonumber = tonumber;
local strlen, strlower, strmatch, strsub, strsplit, format, gsub = strlen, strlower, strmatch, strsub, strsplit, format, gsub;
local ceil = ceil;
local time = time;

local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local FRIENDS_WOW_NAME_COLOR_CODE = FRIENDS_WOW_NAME_COLOR_CODE;
local FRIENDS_BROADCAST_TIME_COLOR_CODE = FRIENDS_BROADCAST_TIME_COLOR_CODE;
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE;
local FRIENDS_BUTTON_TYPE_WOW = FRIENDS_BUTTON_TYPE_WOW;
local FRIENDS_BUTTON_TYPE_BNET = FRIENDS_BUTTON_TYPE_BNET;
local BNET_FRIEND_TOOLTIP_WOW_CLASSIC = BNET_FRIEND_TOOLTIP_WOW_CLASSIC;
local BNET_CLIENT_WOW = BNET_CLIENT_WOW;
local BNET_LAST_ONLINE_TIME = BNET_LAST_ONLINE_TIME;

local GetRealmID = GetRealmID;
local GetRealZoneText = GetRealZoneText;
local GetFriendInfo = GetFriendInfo or C_FriendList.GetFriendInfo or function() end
local GetFriendInfoByIndex = GetFriendInfoByIndex or C_FriendList.GetFriendInfoByIndex or function() end
local BNGetNumFriendGameAccounts = BNGetNumFriendGameAccounts;
local BNGetFriendInfo = BNGetFriendInfo;
local BNGetFriendGameAccountInfo = BNGetFriendGameAccountInfo;
local BNGetFriendInfoByID = BNGetFriendInfoByID;
local BNGetGameAccountInfo = BNGetGameAccountInfo;
local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
local GetQuestDifficultyColor = GetQuestDifficultyColor;

local GetMouseFocus = GetMouseFocus;
local BNet_GetClientTexture = BNet_GetClientTexture;
local GameTooltip = GameTooltip;

if __ns.__client._TocVersion >= 90000 then
	BNGetNumFriendGameAccounts = C_BattleNet.GetFriendNumGameAccounts;
	local C_BattleNet_GetFriendAccountInfo = C_BattleNet.GetFriendAccountInfo;
	-- presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(id);
    BNGetFriendInfo = function(arg1, arg2)
		local info = C_BattleNet_GetFriendAccountInfo(arg1, arg2);
		if info ~= nil then
			local game = info.gameAccountInfo;
			if game ~= nil then
				return info.bnetAccountID, info.accountName, info.battleTag,
					info.isBattleTagPresence, 
					game.characterName, game.gameAccountID, game.clientProgram,
					game.isOnline,-- not info.appearOffline,
					info.lastOnlineTime,
					info.isAFK, info.isDND,
					info.customMessage, info.note,
					isRIDFriend, info.customMessageTime, canSoR;
			else
				return info.bnetAccountID, info.accountName, info.battleTag, info.isBattleTagPresence, nil, nil, info.clientProgram, not info.appearOffline, info.lastOnlineTime, info.isAFK, info.isDND, info.customMessage, info.note, isRIDFriend, info.customMessageTime, canSoR;
			end
		end
	end
	local C_BattleNet_GetFriendGameAccountInfo = C_BattleNet.GetFriendGameAccountInfo;
	BNGetFriendGameAccountInfo = function(arg1, arg2)
		local info = C_BattleNet_GetFriendGameAccountInfo(arg1, arg2);
		if info ~= nil then
			return info.isOnline, info.characterName, info.clientProgram, info.realmName, info.realmID, info.factionName, info.raceName, info.className, nil, info.areaName, info.characterLevel, zone2, nil, nil, nil, nil, nil, nil, nil, info.playerGuid, info.wowProjectID, r2;
		end
	end
	-- BNGetGameAccountInfo = function(arg1, arg2) end;
	local BNGetFriendIndex = BNGetFriendIndex;
	BNGetFriendInfoByID = function(id)
		local index = BNGetFriendIndex(id);
		if index ~= nil then
			return BNGetFriendInfo(index);
		end
	end
	BNet_GetClientTexture = BNet_GetClientTexture or function(client)
		if ( client == BNET_CLIENT_WOW ) then
			return "Interface\\FriendsFrame\\Battlenet-WoWicon";
		elseif ( client == BNET_CLIENT_SC2 ) then
			return "Interface\\FriendsFrame\\Battlenet-Sc2icon";
		elseif ( client == BNET_CLIENT_D3 ) then
			return "Interface\\FriendsFrame\\Battlenet-D3icon";
		elseif ( client == BNET_CLIENT_WTCG ) then
			return "Interface\\FriendsFrame\\Battlenet-WTCGicon";
		elseif ( client == BNET_CLIENT_HEROES ) then
			return "Interface\\FriendsFrame\\Battlenet-HotSicon";
		elseif ( client == BNET_CLIENT_OVERWATCH ) then
			return "Interface\\FriendsFrame\\Battlenet-Overwatchicon";
		elseif ( client == BNET_CLIENT_SC ) then
			return "Interface\\FriendsFrame\\Battlenet-SCicon";
		elseif ( client == BNET_CLIENT_DESTINY2 ) then
			return "Interface\\FriendsFrame\\Battlenet-Destiny2icon";
		elseif ( client == BNET_CLIENT_COD ) then
			return "Interface\\FriendsFrame\\Battlenet-CallOfDutyBlackOps4icon";
		elseif ( client == BNET_CLIENT_COD_MW ) then
			return "Interface\\FriendsFrame\\Battlenet-CallOfDutyMWicon";
		elseif ( client == BNET_CLIENT_COD_MW2 ) then
			return "Interface\\FriendsFrame\\Battlenet-CallOfDutyMW2icon";
		elseif ( client == BNET_CLIENT_COD_BOCW ) then
			return "Interface\\FriendsFrame\\Battlenet-CallOfDutyBlackOpsColdWaricon";
		elseif ( client == BNET_CLIENT_WC3 ) then
			return "Interface\\FriendsFrame\\Battlenet-Warcraft3Reforged";
		elseif ( client == BNET_CLIENT_ARCADE ) then
			return "Interface\\FriendsFrame\\Battlenet-BlizzardArcadeCollectionicon";
		elseif ( client == BNET_CLIENT_CRASH4 ) then
			return "Interface\\FriendsFrame\\Battlenet-CrashBandicoot4icon";
		elseif ( client == BNET_CLIENT_D2 ) then
			return "Interface\\FriendsFrame\\Battlenet-DiabloIIResurrectedicon";
		elseif ( client == BNET_CLIENT_COD_VANGUARD ) then
			return "Interface\\FriendsFrame\\Battlenet-CallOfDutyVanguardicon";
		elseif ( client == BNET_CLIENT_DI) then
			return "Interface\\FriendsFrame\\Battlenet-DiabloImmortalicon";
		elseif ( client == BNET_CLIENT_ARCLIGHT) then
			return "Interface\\FriendsFrame\\Battlenet-WarcraftArclightRumbleicon";
		else
			return "Interface\\FriendsFrame\\Battlenet-Battleneticon";
		end
	end
	
end

local LOCALIZED_CLASS_NAMES_HASH = {  };
-->
	for k, v in next, LOCALIZED_CLASS_NAMES_FEMALE do
		LOCALIZED_CLASS_NAMES_HASH[v] = k;
	end
	for k, v in next, LOCALIZED_CLASS_NAMES_MALE do
		LOCALIZED_CLASS_NAMES_HASH[v] = k;
	end
-->
local FriendsFrameTooltip_Show = FriendsFrameTooltip_Show or FriendsListButtonMixin and FriendsListButtonMixin.OnEnter or nil;

--/run for k,v in next, _G do if strfind(k,"^WOW_PROJECT") then print(k,v) end end
local L = {  };
do
	if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' then
		L.DIFF_CLIENT = {
			[WOW_PROJECT_MAINLINE or 1] = "[|cffff7f7f??????|r]",
			[WOW_PROJECT_CLASSIC or 2] = "[|cffff7f7f60|r]",
			[WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5] = "[|cffff7f7f70|r]",
			[WOW_PROJECT_WRATH_CLASSIC or 11] = "[|cffff7f7f80|r]",
			["*"] = "[|cffff7f7f??|r]",
		};
		L["UNKOWN"] = "|cffdf8f8f??????|r"
		L["UNKOWN_CLASS"] = "|cffdf8f8f??????|r"
		L["  LEVEL"] = "    |cffbfbfbf??????|r ";
		L["  ZONE: "] = "    |cffbfbfbf??????:|r |cff7f7f7f";
		L["  REALM: "] = "    |cffbfbfbf?????????:|r |cff7f7f7f";
		L[BNET_CLIENT_DESTINY2] = "??????2";
		L[BNET_CLIENT_WTCG] = "????????????";
		L[BNET_CLIENT_WOW] = "????????????";
		L[BNET_CLIENT_COD_MW] = "???????????????????????????";
		L[BNET_CLIENT_SC] = "????????????????????????";
		L[BNET_CLIENT_D3] = "???????????????3";
		L[BNET_CLIENT_HEROES] = "????????????";
		L[BNET_CLIENT_SC2] = "????????????2";
		L[BNET_CLIENT_COD] = "????????????";
		L[BNET_CLIENT_WC3] = "????????????3????????????";
		L[BNET_CLIENT_OVERWATCH] = "????????????";
		L[BNET_CLIENT_APP] = "???????????????";
		L[BNET_CLIENT_CLNT] = "CLNT";
		L["BSAp"] = "?????????????????????";
		L["YEAR"] = "???";
		L["MONTH"] = "???";
		L["DAY"] = "???";
		L["HOUR"] = "???";
		L["MINUTE"] = "???";
		L["RECENTLY_OFFLINE"] = "????????????";
	else
		L.DIFF_CLIENT = {
			[WOW_PROJECT_MAINLINE or 1] = "[|cffff7f7fRetail|r]",
			[WOW_PROJECT_CLASSIC or 2] = "[|cffff7f7f60|r]",
			[WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5] = "[|cffff7f7f70|r]",
			[WOW_PROJECT_WRATH_CLASSIC or 11]  = "[|cffff7f7f80|r]",
			["*"] = "[|cffff7f7f??|r]",
		};
		L["UNKOWN"] = "|cffdf8f8fUnkown|r"
		L["UNKOWN_CLASS"] = "|cffdf8f8fUnkown|r"
		L["  LEVEL"] = "    |cffbfbfbfLevel|r ";
		L["  ZONE: "] = "    |cffbfbfbfZone:|r |cff7f7f7f";
		L["  REALM: "] = "    |cffbfbfbfRealm:|r |cff7f7f7f";
		L[BNET_CLIENT_DESTINY2] = "Destiny 2";
		L[BNET_CLIENT_WTCG] = "Hearthstone";
		L[BNET_CLIENT_WOW] = "World of Warcraft";
		L[BNET_CLIENT_COD_MW] = "Call of Duty: Modern Warfare";
		L[BNET_CLIENT_SC] = "StarCraft: Remastered";
		L[BNET_CLIENT_D3] = "Diablo 3";
		L[BNET_CLIENT_HEROES] = "Heroes of the Storm";
		L[BNET_CLIENT_SC2] = "StarCraft 2";
		L[BNET_CLIENT_COD] = "Call of Duty: Black Ops 4";
		L[BNET_CLIENT_WC3] = "Warcraft3: Remastered";
		L[BNET_CLIENT_OVERWATCH] = "Overwatch";
		L[BNET_CLIENT_APP] = "Battle.net Client";
		L[BNET_CLIENT_CLNT] = "CLNT";
		L["BSAp"] = "Battle.Net Mobile App";
		L["YEAR"] = "Y";
		L["MONTH"] = "M";
		L["DAY"] = "D";
		L["HOUR"] = "H";
		L["MINUTE"] = "M";
		L["RECENTLY_OFFLINE"] = "just now";
	end
end

local SECONDS_1m = 60;
local SECONDS_1h = SECONDS_1m * 60;
local SECONDS_1D = SECONDS_1h * 24;
local SECONDS_1M = SECONDS_1D * 30;
local SECONDS_1Y = SECONDS_1M * 12;
local function format_time(diff)
	if diff >= SECONDS_1Y then
		local Y = diff / SECONDS_1Y; Y = Y - Y % 1.0; diff = diff - Y * SECONDS_1Y;
		local M = diff / SECONDS_1M; M = M - M % 1.0; diff = diff - M * SECONDS_1M;
		local D = diff / SECONDS_1D; D = D - D % 1.0; diff = diff - D * SECONDS_1D;
		local h = diff / SECONDS_1h; h = h - h % 1.0; diff = diff - h * SECONDS_1h;
		local m = diff / SECONDS_1m; m = m - m % 1.0; diff = diff - m * SECONDS_1m;
		return Y .. L["YEAR"] .. M .. L["MONTH"] .. D .. L["DAY"] .. h .. L["HOUR"];
	elseif diff >= SECONDS_1M then
		local M = diff / SECONDS_1M; M = M - M % 1.0; diff = diff - M * SECONDS_1M;
		local D = diff / SECONDS_1D; D = D - D % 1.0; diff = diff - D * SECONDS_1D;
		local h = diff / SECONDS_1h; h = h - h % 1.0; diff = diff - h * SECONDS_1h;
		local m = diff / SECONDS_1m; m = m - m % 1.0; diff = diff - m * SECONDS_1m;
		return M .. L["MONTH"] .. D .. L["DAY"] .. h .. L["HOUR"];
	elseif diff >= SECONDS_1D then
		local D = diff / SECONDS_1D; D = D - D % 1.0; diff = diff - D * SECONDS_1D;
		local h = diff / SECONDS_1h; h = h - h % 1.0; diff = diff - h * SECONDS_1h;
		local m = diff / SECONDS_1m; m = m - m % 1.0; diff = diff - m * SECONDS_1m;
		return D .. L["DAY"] .. h .. L["HOUR"];
	elseif diff >= SECONDS_1h then
		local h = diff / SECONDS_1h; h = h - h % 1.0; diff = diff - h * SECONDS_1h;
		local m = diff / SECONDS_1m; m = m - m % 1.0; diff = diff - m * SECONDS_1m;
		return h .. L["HOUR"] .. m .. L["MINUTE"];
	elseif diff >= SECONDS_1m then
		local m = diff / SECONDS_1m; m = m - m % 1.0; diff = diff - m * SECONDS_1m;
		return m .. L["MINUTE"];
	else
		return L["RECENTLY_OFFLINE"];
	end
end

local playerRealm = GetRealmID();


-->
do
	local _enabled = true;

	local function main(button)
		if _enabled then
			local playerArea = GetRealZoneText();

			local nameText, infoText;
			if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local info = GetFriendInfoByIndex(button.id);
				if info.connected then
					local localizedClass, class, localizedRace, race, _, name = GetPlayerInfoByGUID(info.guid);
					local color = RAID_CLASS_COLORS[class];
					local dColor = GetQuestDifficultyColor(info.level);
					nameText =
							(color and format("|c%s%s|r", color.colorStr, info.name) or info.name)
							.. " "
							.. (dColor and format("|cff%.2x%.2x%.2x%s|r", dColor.r * 255, dColor.g * 255, dColor.b * 255, info.level) or info.level);
					if info.area == playerArea then
						infoText =
								localizedRace
								.. " "
								.. (color and format("|c%s%s|r", color.colorStr, info.className) or info.className)
								.. " "
								.. "|cff00ff00" .. info.area .. "|r";
					else
						infoText =
								localizedRace
								.. " "
								.. (color and format("|c%s%s|r", color.colorStr, info.className) or info.className)
								.. " "
								.. info.area;
					end
				end
			elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local id = button.id;
				local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(id);
				if presenceID ~= nil then
					if isOnline and presenceName and client == BNET_CLIENT_WOW then
						-- local hasFocus, toonName, client, realm, realmID, faction, race, class, guild, zone1, level, zone2, broadcastText, broadcastTime = BNGetGameAccountInfo(toonID);
						local num = BNGetNumFriendGameAccounts(button.id);
						for j = 1, num * 2 do
							local index = j > num and (j - num) or j;
							local isOnline, toonName, client, realm, realmID, faction, race, class, _, zone1, level, zone2, _, _, _, _, _, _, _, charGUID, wowProjectID, r2 = BNGetFriendGameAccountInfo(id, index);
							if client == BNET_CLIENT_WOW then
								if wowProjectID == WOW_PROJECT_ID or (wowProjectID ~= WOW_PROJECT_ID and j > num) then
									if wowProjectID ~= WOW_PROJECT_ID then
										local line2 = L.DIFF_CLIENT[wowProjectID] or L.DIFF_CLIENT["*"];
										if faction and faction ~= "" then
											infoText = line2 .. [[|Tinterface\timer\]] .. strlower(faction) .. "-logo:20|t";
										else
											infoText = line2;
										end
									elseif faction and faction ~= "" then
										infoText = [[|Tinterface\timer\]] .. strlower(faction) .. "-logo:20|t";
									else
										infoText = "";
									end
									if race and race ~= "" then
										infoText = infoText .. race .. " ";
									end
									toonName = strmatch(toonName, "|cff%x%x%x%x%x%x(.+)|r") or toonName;
									level = tonumber(level or "") or 0;
									if class then
										if LOCALIZED_CLASS_NAMES_HASH[class] then
											local color = RAID_CLASS_COLORS[LOCALIZED_CLASS_NAMES_HASH[class]];
											if color then
												toonName = format("|c%s%s|r", color.colorStr, toonName);
												class = format("|c%s%s|r ", color.colorStr, class);
											end
										end
										infoText = infoText .. class;
									end
									nameText = presenceName .. " " .. FRIENDS_WOW_NAME_COLOR_CODE .. "(|r" .. toonName;
									if level then
										if wowProjectID == WOW_PROJECT_ID then
											local dColor = GetQuestDifficultyColor(level);
											nameText = nameText .. format(" |cff%.2x%.2x%.2x%d|r", dColor.r * 255, dColor.g * 255, dColor.b * 255, level) .. FRIENDS_WOW_NAME_COLOR_CODE .. ")|r";
										else
											nameText = nameText .. " |cffdf8f8f" ..  level .. "|r" .. FRIENDS_WOW_NAME_COLOR_CODE .. ")|r";
										end
									else
										nameText = nameText.. FRIENDS_WOW_NAME_COLOR_CODE .. ")|r"
									end
									if realm and realm ~= "" then
										if zone1 and zone1 ~= "" then
											if zone1 == playerArea then
												infoText = infoText .. "|cff00ff00" .. zone1 .. "|r - ";
											else
												infoText = infoText .. zone1 .. " - ";
											end
										end
										if realmID == playerRealm then
											infoText = infoText .. "|cff00ff00" .. realm .. "|r";
										else
											infoText = infoText .. realm;
										end
									else
										if zone1 and zone1 ~= "" then
												infoText = infoText .. zone1;
										end
									end
									break;
								end
							end
						end
					elseif not isOnline then
						local diff = time() - lastOnline;
						local ratio = diff / SECONDS_1Y;
						local r, g = nil, nil;
						if ratio >= 1.0 then
							g = 0.0;
							r = 1.0;
						elseif ratio > 1.0 / 12.0 then
							g = 1.0 - (ratio * 12.0 - 1.0) / 11.0;
							r = 1.0;
						else
							g = 1.0;
							r = ratio * 6.0 + 0.25;
						end
						r = r * 0.5;
						g = g * 0.5;
						infoText = format(BNET_LAST_ONLINE_TIME, format("|cff%.2x%.2x00%s|r", r * 255, g * 255, format_time(diff)));
					end
				end
			end

			if nameText then
				button.name:SetText(nameText);
				if button.Favorite and button.Favorite:IsShown() then
					button.Favorite:ClearAllPoints()
					button.Favorite:SetPoint("TOPLEFT", button.name, "TOPLEFT", button.name:GetStringWidth(), 0);
				end
			end
			if infoText then
				button.info:SetText(infoText);
			end
		end
	end

	local _isInitialized = false;
	local function _Init(loading)
		_isInitialized = true;
		hooksecurefunc("FriendsFrame_UpdateFriendButton", main);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and FriendsListFrame.ScrollBox:IsVisible() then
			FriendsList_Update();
		end
	end
	local function _Disable(loading)
		_enabled = false;
		if _isInitialized and not loading and FriendsListFrame.ScrollBox:IsVisible() then
			FriendsList_Update();
		end
	end

	__plugins['FriendsListColor'] = { _Enable, _Disable, __ns._F_noop, };
end


do
	local _enabled = true;

	local function SetTooltip(button)
		local i = button.id;
		local playerArea = GetRealZoneText();
		if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
			FriendsTooltip:Hide();
			GameTooltip:Hide();
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
			local info = GetFriendInfoByIndex(i);
			if info.connected then
				local localizedClass, class, localizedRace, race, _, name = GetPlayerInfoByGUID(info.guid);
				local color = RAID_CLASS_COLORS[class];
				local dColor = GetQuestDifficultyColor(info.level);
				GameTooltip:SetText(format("|c%s%s|r", color.colorStr, info.name));
				GameTooltip:AddLine(
									L["  LEVEL"] .. format("|cff%.2x%.2x%.2x%d|r", dColor.r * 255, dColor.g * 255, dColor.b * 255, info.level)
									.. " "
									.. "|cffbfbfbf" .. localizedRace .. "|r"
									.. " "
									.. format("|c%s%s|r", color.colorStr, info.className));
				GameTooltip:AddLine(L["  ZONE: "] .. (info.area == playerRealm and ("|cff00ff00" .. info.area .. "|r") or info.area));
			else
				GameTooltip:SetText("|cffbfbfbf" .. info.name .. "|r");
			end
			local noteText = info.notes;
			if noteText and noteText ~= "" then
				-- GameTooltip:AddLine(" ");
				for i = 1, ceil(strlen(noteText) / 36) do
					if i == 1 then
						GameTooltip:AddLine([[|TInterface\FriendsFrame\UI-FriendsFrame-Note:0:0:0:0:8:8:0:8:0:8:255:210:0|t |cffffd200]] .. strsub(noteText, 1, 36) .. "|r");
					else
						GameTooltip:AddLine("     |cffffd200" .. strsub(noteText, (i - 1) * 36 + 1, i * 36) .. "|r");
					end
				end
			end
			GameTooltip:Show();
			return true;
		elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
			-- local gameOnline, charName, client, realm, realmID, faction, race, class = BNGetFriendGameAccountInfo(i, j);
			local id = button.id;
			local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(id);
			if presenceName then
				FriendsTooltip:Hide();
				GameTooltip:Hide();
				GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
				GameTooltip:SetText("|cff7fbfff" .. presenceName .. "|r");
				if isOnline then
					-- local hasFocus, toonName, client, realm, realmID, faction, race, class, guild, zone1, level, zone2, broadcastText, broadcastTime = BNGetGameAccountInfo(toonID);
					for j = 1, BNGetNumFriendGameAccounts(id) do
						local isOnline, toonName, client, realm, realmID, faction, race, class, _, zone1, level, zone2, _, _, _, _, _, _, _, charGUID, wowProjectID, r2 = BNGetFriendGameAccountInfo(id, j);
						if client == BNET_CLIENT_WOW then
							toonName = strmatch(toonName, "|cff%x%x%x%x%x%x(.+)|r") or toonName;
							level = tonumber(level or "") or 0;
							local line = nil;
							if realm and realm ~= "" then
								local dColor = GetQuestDifficultyColor(level);
								line = L["  LEVEL"] .. format("|cff%.2x%.2x%.2x%d|r", dColor.r * 255, dColor.g * 255, dColor.b * 255, level);
							else
								if level then
									line = L["  LEVEL"] .. "|cffdf8f8f" .. level .. "|r";
								else
									line = "    ";
								end
								realm = nil;
							end
							if race and race ~= "" then
								line = line .. " |cffbfbfbf" .. race .. "|r";
							end
							if class and LOCALIZED_CLASS_NAMES_HASH[class] then
								local color = RAID_CLASS_COLORS[LOCALIZED_CLASS_NAMES_HASH[class]];
								if color then
									toonName = format("|c%s%s|r", color.colorStr, toonName);
									line = line .. format(" |c%s%s|r", color.colorStr, class);
								else
									toonName = "|cffafafaf" .. toonName .. "|r";
									line = line .. " |cffafafaf" .. class .. "|r";
								end
							else
								toonName = "|cffafafaf" .. toonName .. "|r";
							end
							if wowProjectID ~= WOW_PROJECT_ID then
								local line2 = L.DIFF_CLIENT[wowProjectID];
								if line2 then
									toonName = toonName .. line2;
								end
							end
							if faction and faction ~= "" then
								GameTooltip:AddLine([[|Tinterface\timer\]] .. strlower(faction) .. "-logo:20|t" .. toonName);
							else
								GameTooltip:AddLine(toonName);
							end
							GameTooltip:AddLine(line);
							if zone1 and zone1 ~= "" then
								GameTooltip:AddLine(L["  ZONE: "] .. ((playerArea == zone1) and ("|cff00ff00" .. zone1 .. "|r") or zone1) .. "|r");
							end
							if realm then
								GameTooltip:AddLine(L["  REALM: "] .. ((playerRealm == realmID) and ("|cff00ff00" .. realm .. "|r") or realm) .. "|r");
							end
						else
							local texture = BNet_GetClientTexture(client);
							if texture then
								GameTooltip:AddLine("|T" .. BNet_GetClientTexture(client) .. ":20|t" .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. L[client] .. "|r");
							else
								GameTooltip:AddLine(FRIENDS_BROADCAST_TIME_COLOR_CODE .. L[client] .. "|r");
							end
							if zone2 and zone2 ~= "" then
								GameTooltip:AddLine("    |cffbfbfbf" .. zone2 .. "|r");
							end
						end
					end
				else
					local diff = time() - lastOnline;
					local ratio = diff / SECONDS_1Y;
					local r, g = nil, nil;
					if ratio >= 1.0 then
						g = 0.0;
						r = 1.0;
					elseif ratio > 1.0 / 12.0 then
						g = 1.0 - (ratio * 12.0 - 1.0) / 11.0;
						r = 1.0;
					else
						g = 1.0;
						r = ratio * 6.0 + 0.25;
					end
					-- r = r * 0.5;
					-- g = g * 0.5;
					GameTooltip:AddLine(format(BNET_LAST_ONLINE_TIME, format("|cff%.2x%.2x00%s|r", r * 255, g * 255, format_time(diff))));
				end
				if messageText and messageText ~= "" then
					-- GameTooltip:AddLine([[|TInterface\FriendsFrame\BroadcastIcon:20|t]] .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. messageText .. "\n" .. string.format(BNET_BROADCAST_SENT_TIME, FriendsFrame_GetLastOnline(messageTime)) .. FONT_COLOR_CODE_CLOSE);
					for i = 1, ceil(strlen(messageText) / 36) do
						if i == 1 then
							GameTooltip:AddLine([[|TInterface\FriendsFrame\BroadcastIcon:0:0:0:0:16:16:2:14:2:14|t ]] .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. strsub(messageText, 1, 36) .. FONT_COLOR_CODE_CLOSE);
						else
							GameTooltip:AddLine("     " .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. strsub(messageText, (i - 1) * 36 + 1, i * 36) .. FONT_COLOR_CODE_CLOSE);
						end
					end
					GameTooltip:AddLine(FRIENDS_BROADCAST_TIME_COLOR_CODE .. string.format(BNET_BROADCAST_SENT_TIME, FriendsFrame_GetLastOnline(messageTime)) .. FONT_COLOR_CODE_CLOSE);
				end
				if noteText and noteText ~= "" then
					local lines = ceil(strlen(noteText) / 36);
					if lines == 1 then
							GameTooltip:AddLine([[|TInterface\FriendsFrame\UI-FriendsFrame-Note:0:0:0:0:8:8:0:8:0:8:255:210:0|t |cffffd200]] .. noteText .. "|r");
					elseif lines > 1 then
						for i = 1, lines do
							if i == 1 then
								GameTooltip:AddLine([[|TInterface\FriendsFrame\UI-FriendsFrame-Note:0:0:0:0:8:8:0:8:0:8:255:210:0|t |cffffd200]] .. strsub(noteText, 1, 36) .. "|r");
							else
								GameTooltip:AddLine("     |cffffd200" .. strsub(noteText, (i - 1) * 36 + 1, i * 36) .. "|r");
							end
						end
					end
				end
				GameTooltip:Show();
				return true;
			end
		end
	end
	local function main(FriendsTooltip)
		if _enabled then
			return SetTooltip(FriendsTooltip.button);
		end
	end
	local function OnLeave(button)
		if _enabled then
			GameTooltip:Hide();
		end
	end

	local _isInitialized = false;
	local function _Init(loading)
		_isInitialized = true;
		FriendsTooltip:HookScript("OnShow", main);
		hooksecurefunc(FriendsListButtonMixin, "OnLeave", OnLeave);
		local frames = FriendsListFrame.ScrollBox.view.frames;
		for index = 1, #frames do
			frames[index]:HookScript("OnLeave", OnLeave);
		end
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and FriendsTooltip:IsShown() and FriendsTooltip.button == GetMouseFocus() then
			return FriendsFrameTooltip_Show(FriendsTooltip.button);
		end
	end
	local function _Disable(loading)
		_enabled = false;
		if _isInitialized and not loading and FriendsTooltip:IsShown() and FriendsTooltip.button == GetMouseFocus() then
			return FriendsTooltip.button:OnEnter();
		end
	end

	__plugins['FriendsListTipColor'] = {
		_Enable,
		_Disable,
		_Extra = function(button)
			if button ~= nil then
				if _enabled then
					if SetTooltip(button) then
						return GameTooltip;
					end
				elseif FriendsFrameTooltip_Show ~= nil then
					FriendsFrameTooltip_Show(button);
					return FriendsTooltip;
				end
			end
		end
	};
end
