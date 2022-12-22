--[[--
	ALA@163UI
	复用代码请在显著位置标注来源【ALA@网易有爱】
--]]--
local addonName, private = ...

local select, ipairs, pairs = select, ipairs, pairs;
local tonumber = tonumber;
local strlen, strlower, strfind, strsub, strsplit, format, gsub = strlen, strlower, strfind, strsub, strsplit, format, gsub;
local ceil = ceil;
local floor = floor;
local time = time;

local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local FRIENDS_WOW_NAME_COLOR_CODE = FRIENDS_WOW_NAME_COLOR_CODE;
local FRIENDS_BROADCAST_TIME_COLOR_CODE = FRIENDS_BROADCAST_TIME_COLOR_CODE;
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE;
local FRIENDS_BUTTON_TYPE_WOW = FRIENDS_BUTTON_TYPE_WOW;
local FRIENDS_BUTTON_TYPE_BNET = FRIENDS_BUTTON_TYPE_BNET;
local BNET_FRIEND_TOOLTIP_WOW_CLASSIC = BNET_FRIEND_TOOLTIP_WOW_CLASSIC;
local BNET_CLIENT_WOW = BNET_CLIENT_WOW;
local FRIENDS_LEVEL_TEMPLATE = FRIENDS_LEVEL_TEMPLATE:gsub('%%d', '%%s')
FRIENDS_LEVEL_TEMPLATE = FRIENDS_LEVEL_TEMPLATE:gsub('%$d', '%$s') -- '%2$s %1$d-го уровня'
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

local version, build, complied_time, toc = GetBuildInfo();
if toc >= 90000 then
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
					not info.appearOffline, info.lastOnlineTime,
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
end
_G.alaBNGetFriendInfo = BNGetFriendInfo;
_G.alaBNGetFriendGameAccountInfo = BNGetFriendGameAccountInfo;

local GetMouseFocus = GetMouseFocus;
local BNet_GetClientTexture = BNet_GetClientTexture;
local GameTooltip = GameTooltip;
local HybridScrollFrame_GetOffset = HybridScrollFrame_GetOffset;
local scrollFrame = nil;
local scrollButtonNameParse = nil;
if FriendsListFrameScrollFrame then
	scrollFrame = FriendsListFrameScrollFrame;
	scrollButtonNameParse = "FriendsListFrameScrollFrameButton%d+";
elseif FriendsFrameFriendsScrollFrame then
	scrollFrame = FriendsFrameFriendsScrollFrame;
	scrollButtonNameParse = "FriendsFrameFriendsScrollFrameButton%d+";
else
	return;
end

local LC = {  };
for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
	LC[v] = k;
end
for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	LC[v] = k;
end

local L = {  };
do
	if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' then
		L.DIFF_CLIENT = {
			[WOW_PROJECT_MAINLINE] = "(\124cffff7f7f正式服\124r)",
			[WOW_PROJECT_CLASSIC] = "(\124cffff7f7f怀旧服\124r)",
			["*"] = "(\124cffff7f7f未知\124r)",
		};
		L["UNKOWN"] = "\124cffdf8f8f未知\124r"
		L["UNKOWN_CLASS"] = "\124cffdf8f8f未知\124r"
		L["  LEVEL"] = "    \124cffbfbfbf等级\124r ";
		L["  ZONE: "] = "    \124cffbfbfbf区域:\124r \124cff7f7f7f";
		L["  REALM: "] = "    \124cffbfbfbf服务器:\124r \124cff7f7f7f";
		L[BNET_CLIENT_DESTINY2] = "命运2";
		L[BNET_CLIENT_WTCG] = "炉石传说";
		L[BNET_CLIENT_WOW] = "魔兽世界";
		L[BNET_CLIENT_COD_MW] = "使命召唤：现代战争";
		L[BNET_CLIENT_SC] = "星际争霸：重制版";
		L[BNET_CLIENT_D3] = "暗黑破坏神3";
		L[BNET_CLIENT_HEROES] = "风暴英雄";
		L[BNET_CLIENT_SC2] = "星际争霸2";
		L[BNET_CLIENT_COD] = "使命召唤";
		L[BNET_CLIENT_WC3] = "魔兽争霸3：重制版";
		L[BNET_CLIENT_OVERWATCH] = "守望先锋";
		L[BNET_CLIENT_APP] = "战网客户端";
		L[BNET_CLIENT_CLNT] = "CLNT";
		L["BSAp"] = "战网移动客户端";
		L["YEAR"] = "年";
		L["MONTH"] = "月";
		L["DAY"] = "日";
		L["HOUR"] = "时";
		L["MINUTE"] = "分";
		L["RECENTLY_OFFLINE"] = "最近离线";
	else
		L.DIFF_CLIENT = {
			[WOW_PROJECT_MAINLINE] = "(\124cffff7f7fRetail\124r)",
			[WOW_PROJECT_CLASSIC] = "(\124cffff7f7fClassic\124r)",
			["*"] = "(\124cffff7f7fUnkown\124r)",
		};
		L["UNKOWN"] = "\124cffdf8f8fUnkown\124r"
		L["UNKOWN_CLASS"] = "\124cffdf8f8fUnkown\124r"
		L["  LEVEL"] = "    \124cffbfbfbfLevel\124r ";
		L["  ZONE: "] = "    \124cffbfbfbfZone:\124r \124cff7f7f7f";
		L["  REALM: "] = "    \124cffbfbfbfRealm:\124r \124cff7f7f7f";
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

local ONE_MINUTE = 60;
local ONE_HOUR = ONE_MINUTE * 60;
local ONE_DAY = ONE_HOUR * 24;
local ONE_MONTH = ONE_DAY * 30;
local ONE_YEAR = ONE_MONTH * 12;
local function format_time(diff)
	local Y = floor(diff / ONE_YEAR);
	diff = diff - Y * ONE_YEAR;
	local M = floor(diff / ONE_MONTH);
	diff = diff - M * ONE_MONTH;
	local D = floor(diff / ONE_DAY);
	diff = diff - D * ONE_DAY;
	local h = floor(diff / ONE_HOUR);
	diff = diff - h * ONE_HOUR;
	local m = floor(diff / ONE_MINUTE);
	if Y > 0 then
		return Y .. L["YEAR"] .. M .. L["MONTH"] .. D .. L["DAY"] .. h .. L["HOUR"];
	elseif M > 0 then
		return M .. L["MONTH"] .. D .. L["DAY"] .. h .. L["HOUR"];
	elseif D > 0 then
		return D .. L["DAY"] .. h .. L["HOUR"];
	elseif h > 0 then
		return h .. L["HOUR"] .. m .. L["MINUTE"];
	elseif m > 0 then
		return m .. L["MINUTE"];
	else
		return L["RECENTLY_OFFLINE"];
	end
end

local ON_HOOK_FriendsFrame_UpdateFriends = false;
local ON_HOOK_FriendsFrameTooltip_Show = false;

local function HOOK_FriendsFrame_UpdateFriends()
	if not ON_HOOK_FriendsFrame_UpdateFriends then
		return;
	end
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons;

	local playerArea = GetRealZoneText();
	local playerRealm = GetRealmID();

	for i = 1, #buttons do
		local nameText, infoText;
		local button = buttons[i];
		index = offset + i;
		if button:IsShown() then
			if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local info = GetFriendInfoByIndex(button.id);
				if info.connected then
					local lc, c, lr, r, _, n = GetPlayerInfoByGUID(info.guid);
					local color = RAID_CLASS_COLORS[c];
					local dColor = GetQuestDifficultyColor(info.level);
					nameText =
							(color and format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, info.name) or info.name)
							.. " "
							.. (dColor and format("\124cff%.2x%.2x%.2x%s\124r", dColor.r * 255, dColor.g * 255, dColor.b * 255, info.level) or info.level);
					if info.area == playerArea then
						infoText =
								lr
								.. " "
								.. (color and format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, info.className) or info.className)
								.. " "
								.. "\124cff00ff00" .. info.area .. "\124r";
					else
						infoText =
								lr
								.. " "
								.. (color and format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, info.className) or info.className)
								.. " "
								.. info.area;
					end
				end
			elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
				local id = button.id;
				local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(id);
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
										infoText = line2 .. "\124Tinterface\\timer\\" .. strlower(faction) .. "-logo:20\124t";
									else
										infoText = line2;
									end
								elseif faction and faction ~= "" then
									infoText = "\124Tinterface\\timer\\" .. strlower(faction) .. "-logo:20\124t";
								else
									infoText = "";
								end
								if race and race ~= "" then
									infoText = infoText .. race .. " ";
								end
								toonName = select(3, strfind(toonName, "\124cff%x%x%x%x%x%x(.+)\124r")) or toonName;
								level = tonumber(level or "") or 0;
								if class then
									if LC[class] then
										local color = RAID_CLASS_COLORS[LC[class]];
										if color then
											toonName = format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, toonName);
											class = format("\124cff%.2x%.2x%.2x%s\124r ", color.r * 255, color.g * 255, color.b * 255, class);
										end
									end
									infoText = infoText .. class;
								end
								nameText = presenceName .. " " .. FRIENDS_WOW_NAME_COLOR_CODE .. "(\124r" .. toonName;
								if level then
									if wowProjectID == WOW_PROJECT_ID then
										local dColor = GetQuestDifficultyColor(level);
										nameText = nameText .. format(" \124cff%.2x%.2x%.2x%d\124r", dColor.r * 255, dColor.g * 255, dColor.b * 255, level) .. FRIENDS_WOW_NAME_COLOR_CODE .. ")\124r";
									else
										nameText = nameText .. " \124cffdf8f8f" ..  level .. "\124r" .. FRIENDS_WOW_NAME_COLOR_CODE .. ")\124r";
									end
								else
									nameText = nameText.. FRIENDS_WOW_NAME_COLOR_CODE .. ")\124r"
								end
								if realm and realm ~= "" then
									if zone1 and zone1 ~= "" then
										if zone1 == playerArea then
											infoText = infoText .. "\124cff00ff00" .. zone1 .. "\124r - ";
										else
											infoText = infoText .. zone1 .. " - ";
										end
									end
									if realmID == playerRealm then
										infoText = infoText .. "\124cff00ff00" .. realm .. "\124r";
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
					local ratio = diff / ONE_YEAR;
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
					infoText = format(BNET_LAST_ONLINE_TIME, format("\124cff%.2x%.2x00%s\124r", r * 255, g * 255, format_time(diff)));
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
hooksecurefunc(scrollFrame, 'update', HOOK_FriendsFrame_UpdateFriends);
hooksecurefunc('FriendsFrame_UpdateFriends', HOOK_FriendsFrame_UpdateFriends);

local function HOOK_FriendsFrameTooltip_Show(button)
	-- do return end
	if not ON_HOOK_FriendsFrameTooltip_Show then
		return;
	end
	local button = GetMouseFocus();
	if not button or not button:GetName() or not strfind(button:GetName(), scrollButtonNameParse) then
		return;
	end
	local i = button.id;
	local playerArea = GetRealZoneText();
	local playerRealm = GetRealmID();
	if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
		FriendsTooltip:Hide();
		GameTooltip:Hide();
		GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
		local info = GetFriendInfoByIndex(i);
		if info.connected then
			local lc, c, lr, r, _, n = GetPlayerInfoByGUID(info.guid);
			local color = RAID_CLASS_COLORS[c];
			local dColor = GetQuestDifficultyColor(info.level);
			GameTooltip:SetText(format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, info.name));
			GameTooltip:AddLine(
								L["  LEVEL"] .. format("\124cff%.2x%.2x%.2x%d\124r", dColor.r * 255, dColor.g * 255, dColor.b * 255, info.level)
								.. " "
								.. "\124cffbfbfbf" .. lr .. "\124r"
								.. " "
								.. format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, info.className));
			GameTooltip:AddLine(L["  ZONE: "] .. (info.area == playerRealm and ("\124cff00ff00" .. info.area .. "\124r") or info.area));
		else
			GameTooltip:SetText("\124cffbfbfbf" .. info.name .. "\124r");
		end
		local noteText = info.notes;
		if noteText and noteText ~= "" then
			-- GameTooltip:AddLine(" ");
			for i = 1, ceil(strlen(noteText) / 36) do
				if i == 1 then
					GameTooltip:AddLine("\124TInterface\\FriendsFrame\\UI-FriendsFrame-Note:0:0:0:0:8:8:0:8:0:8:255:210:0\124t \124cffffd200" .. strsub(noteText, 1, 36) .. "\124r");
				else
					GameTooltip:AddLine("     \124cffffd200" .. strsub(noteText, (i - 1) * 36 + 1, i * 36) .. "\124r");
				end
			end
		end
		GameTooltip:Show();
	elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET then
		-- local gameOnline, charName, client, realm, realmID, faction, race, class = BNGetFriendGameAccountInfo(i, j);
		local id = button.id;
		local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(id);
		if presenceName then
			FriendsTooltip:Hide();
			GameTooltip:Hide();
			GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
			GameTooltip:SetText("\124cff7fbfff" .. presenceName .. "\124r");
			if isOnline then
				-- local hasFocus, toonName, client, realm, realmID, faction, race, class, guild, zone1, level, zone2, broadcastText, broadcastTime = BNGetGameAccountInfo(toonID);
				for j = 1, BNGetNumFriendGameAccounts(id) do
					local isOnline, toonName, client, realm, realmID, faction, race, class, _, zone1, level, zone2, _, _, _, _, _, _, _, charGUID, wowProjectID, r2 = BNGetFriendGameAccountInfo(id, j);
					if client == BNET_CLIENT_WOW then
						toonName = select(3, strfind(toonName, "\124cff%x%x%x%x%x%x(.+)\124r")) or toonName;
						level = tonumber(level or "") or 0;
						local line = nil;
						if realm and realm ~= "" then
							local dColor = GetQuestDifficultyColor(level);
							line = L["  LEVEL"] .. format("\124cff%.2x%.2x%.2x%d\124r", dColor.r * 255, dColor.g * 255, dColor.b * 255, level);
						else
							if level then
								line = L["  LEVEL"] .. "\124cffdf8f8f" .. level .. "\124r";
							else
								line = "    ";
							end
							realm = nil;
						end
						if race and race ~= "" then
							line = line .. " \124cffbfbfbf" .. race .. "\124r";
						end
						if class and LC[class] then
							local color = RAID_CLASS_COLORS[LC[class]];
							if color then
								toonName = format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, toonName);
								line = line .. format(" \124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, class);
							else
								toonName = "\124cffafafaf" .. toonName .. "\124r";
								line = line .. " \124cffafafaf" .. class .. "\124r";
							end
						else
							toonName = "\124cffafafaf" .. toonName .. "\124r";
						end
						if wowProjectID ~= WOW_PROJECT_ID then
							local line2 = L.DIFF_CLIENT[wowProjectID];
							if line2 then
								toonName = toonName .. line2;
							end
						end
						if faction and faction ~= "" then
							GameTooltip:AddLine("\124Tinterface\\timer\\" .. strlower(faction) .. "-logo:20\124t" .. toonName);
						else
							GameTooltip:AddLine(toonName);
						end
						GameTooltip:AddLine(line);
						if zone1 and zone1 ~= "" then
							GameTooltip:AddLine(L["  ZONE: "] .. ((playerArea == zone1) and ("\124cff00ff00" .. zone1 .. "\124r") or zone1) .. "\124r");
						end
						if realm then
							GameTooltip:AddLine(L["  REALM: "] .. ((playerRealm == realmID) and ("\124cff00ff00" .. realm .. "\124r") or realm) .. "\124r");
						end
					else
						local texture = BNet_GetClientTexture(client);
						if texture then
							GameTooltip:AddLine("\124T" .. BNet_GetClientTexture(client) .. ":20\124t" .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. L[client] .. "\124r");
						else
							GameTooltip:AddLine(FRIENDS_BROADCAST_TIME_COLOR_CODE .. L[client] .. "\124r");
						end
						if zone2 and zone2 ~= "" then
							GameTooltip:AddLine("    \124cffbfbfbf" .. zone2 .. "\124r");
						end
					end
				end
			else
				local diff = time() - lastOnline;
				local ratio = diff / ONE_YEAR;
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
				GameTooltip:AddLine(format(BNET_LAST_ONLINE_TIME, format("\124cff%.2x%.2x00%s\124r", r * 255, g * 255, format_time(diff))));
			end
			if messageText and messageText ~= "" then
				-- GameTooltip:AddLine("\124TInterface\\FriendsFrame\\BroadcastIcon:20\124t" .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. messageText .. "\n" .. string.format(BNET_BROADCAST_SENT_TIME, FriendsFrame_GetLastOnline(messageTime)) .. FONT_COLOR_CODE_CLOSE);
				for i = 1, ceil(strlen(messageText) / 36) do
					if i == 1 then
						GameTooltip:AddLine("\124TInterface\\FriendsFrame\\BroadcastIcon:0:0:0:0:16:16:2:14:2:14\124t " .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. strsub(messageText, 1, 36) .. FONT_COLOR_CODE_CLOSE);
					else
						GameTooltip:AddLine("     " .. FRIENDS_BROADCAST_TIME_COLOR_CODE .. strsub(messageText, (i - 1) * 36 + 1, i * 36) .. FONT_COLOR_CODE_CLOSE);
					end
				end
				GameTooltip:AddLine(FRIENDS_BROADCAST_TIME_COLOR_CODE .. string.format(BNET_BROADCAST_SENT_TIME, FriendsFrame_GetLastOnline(messageTime)) .. FONT_COLOR_CODE_CLOSE);
			end
			if noteText and noteText ~= "" then
						-- GameTooltip:AddLine(" ");
				for i = 1, ceil(strlen(noteText) / 36) do
					if i == 1 then
						GameTooltip:AddLine("\124TInterface\\FriendsFrame\\UI-FriendsFrame-Note:0:0:0:0:8:8:0:8:0:8:255:210:0\124t \124cffffd200" .. strsub(noteText, 1, 36) .. "\124r");
					else
						GameTooltip:AddLine("     \124cffffd200" .. strsub(noteText, (i - 1) * 36 + 1, i * 36) .. "\124r");
					end
				end
			end
			GameTooltip:Show();
		end
	end
end
local function HOOK_FriendsFrameTooltip_Hide(button)
	GameTooltip:Hide();
end
-- hooksecurefunc("FriendsFrameTooltip_Show", HOOK_FriendsFrameTooltip_Show);
FriendsTooltip:HookScript("OnShow", HOOK_FriendsFrameTooltip_Show);
for _, button in ipairs(scrollFrame.buttons) do
	if button then
		-- button:HookScript("OnEnter", HOOK_FriendsFrameTooltip_Show);
		button:HookScript("OnLeave", HOOK_FriendsFrameTooltip_Hide);
	else
		break;
	end
end

private.FriendFrame = 
{
	colorList = function(v, loading)
		ON_HOOK_FriendsFrame_UpdateFriends = v;
		if not loading and FriendsListFrameScrollFrame ~= nil and FriendsListFrameScrollFrame.numFriendListEntries ~= nil then
			FriendsFrame_UpdateFriends();
		end
	end,
	colorTip = function(v, loading)
		ON_HOOK_FriendsFrameTooltip_Show = v;
		if not loading then
			local button = GetMouseFocus();
			if button and button:GetName() and strfind(button:GetName(), scrollButtonNameParse) then
				FriendsFrameTooltip_Show();
			end
		end
	end,
};

