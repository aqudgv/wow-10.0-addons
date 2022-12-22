--[[--
	PLUGIN: WhoFrame
--]]--

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;

local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

----------------------------------------------------------------

-->	upvalue
local GetRealZoneText = GetRealZoneText;
local GetGuildInfo = GetGuildInfo;
local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local GetWhoInfo = C_FriendList and C_FriendList.GetWhoInfo or GetWhoInfo or function() end
local GetQuestDifficultyColor = GetQuestDifficultyColor;
local UIDropDownMenu_GetSelectedID = UIDropDownMenu_GetSelectedID;
local FauxScrollFrame_GetOffset = FauxScrollFrame_GetOffset;


do
	local _enabled = true;

	--[[local function main()
		if _enabled then
			local view = WhoFrame.ScrollBox.view;
			local frames = view.frames;
			local whoOffset = view.dataIndexBegin or 0;

			local playerZone = GetRealZoneText();
			local playerGuild = GetGuildInfo('player');
			local var = UIDropDownMenu_GetSelectedID(WhoFrameDropDown);

			for i = 1, WHOS_TO_DISPLAY, 1 do
				local index = whoOffset + i;

				local info = GetWhoInfo(index);
				if not info then return end
				local name, guild, level, race, class, zone, classFileName = info.fullName, info.fullGuildName, info.level, info.raceStr, info.classStr, info.area, info.filename;
				if name and name ~= "" then
					local color = RAID_CLASS_COLORS[classFileName];
					if color then
						frames[i].Name:SetTextColor(color.r, color.g, color.b);
						frames[i].Class:SetTextColor(color.r, color.g, color.b);
						local color = GetQuestDifficultyColor(level);
						frames[i].Level:SetTextColor(color.r, color.g, color.b);
					end
					if var == 1 then
						-- frames[i].Variable:SetText(zone == playerZone and ('|cff00ff00' .. zone .. '|r') or zone);
						if zone == playerZone then
							frames[i].Variable:SetTextColor(0.0, 1.0, 0.0);
						else
							frames[i].Variable:SetTextColor(1.0, 1.0, 1.0);
						end
					elseif var == 2 then
						-- frames[i].Variable:SetText(guild == playerGuild and ('|cff00ff00' .. guild .. '|r') or guild);
						if guild == playerGuild then
							frames[i].Variable:SetTextColor(0.0, 1.0, 0.0);
						else
							frames[i].Variable:SetTextColor(1.0, 1.0, 1.0);
						end
					elseif var == 3 then
						-- frames[i].Variable:SetText(race == _PLAYER_RACE and ('|cff00ff00' .. race .. '|r') or race);
						if race == _PLAYER_RACE then
							frames[i].Variable:SetTextColor(0.0, 1.0, 0.0);
						else
							frames[i].Variable:SetTextColor(1.0, 1.0, 1.0);
						end
					else
					end
				end
			end
		end
	end--]]
	local function main(button, elementData)
		if _enabled then
			local info = elementData.info;
			
			if info.filename then
				local color = RAID_CLASS_COLORS[info.filename];
				button.Name:SetTextColor(color.r, color.g, color.b);
				-- button.Class:SetTextColor(color.r, color.g, color.b);
			end
			local color = GetQuestDifficultyColor(info.level);
			button.Level:SetTextColor(color.r, color.g, color.b);

			local var = UIDropDownMenu_GetSelectedID(WhoFrameDropDown);
			if var == 1 then
				-- button.Variable:SetText(info.area == GetRealZoneText() and ('|cff00ff00' .. info.area .. '|r') or info.area);
				if info.area == GetRealZoneText() then
					button.Variable:SetTextColor(0.0, 1.0, 0.0);
				else
					button.Variable:SetTextColor(1.0, 1.0, 1.0);
				end
			elseif var == 2 then
				-- button.Variable:SetText(info.fullGuildName == GetGuildInfo('player') and ('|cff00ff00' .. info.fullGuildName .. '|r') or info.fullGuildName);
				if info.fullGuildName == GetGuildInfo('player') then
					button.Variable:SetTextColor(0.0, 1.0, 0.0);
				else
					button.Variable:SetTextColor(1.0, 1.0, 1.0);
				end
			elseif var == 3 then
				-- button.Variable:SetText(info.raceStr == UnitRace('player') and ('|cff00ff00' .. info.raceStr .. '|r') or info.raceStr);
				if info.raceStr == UnitRace('player') then
					button.Variable:SetTextColor(0.0, 1.0, 0.0);
				else
					button.Variable:SetTextColor(1.0, 1.0, 1.0);
				end
			else
					button.Variable:SetTextColor(1.0, 1.0, 1.0);
			end
		end
	end

	local _isInitialized = false;
	local function _Init(loading)
		_isInitialized = true;
		-- hooksecurefunc(WhoFrame.ScrollBox, "Update", main);
		-- hooksecurefunc('WhoList_Update', main);
		hooksecurefunc("WhoList_InitButton", main);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and WhoFrame.ScrollBox:IsVisible() then
			WhoList_Update();
		end
	end
	local function _Disable(loading)
		_enabled = false;
		if _isInitialized then
			local frames = WhoFrame.ScrollBox.view.frames;
			for i = 1, WHOS_TO_DISPLAY, 1 do
				local button = frames[i];
				if button then
					if button.Name then
						button.Name:SetTextColor(1.0, 0.8196, 0.0);
					end
					-- if button.Class then
					-- 	button.Class:SetTextColor(1.0, 1.0, 1.0);
					-- end
					if button.Level then
						button.Level:SetTextColor(1.0, 1.0, 1.0);
					end
					if button.Variable then
						button.Variable:SetTextColor(1.0, 1.0, 1.0);
					end
				else
					break;
				end
			end
		end
	end

	__plugins['WhoFrameListColor'] = { _Enable, _Disable, };
end
