--[[--
	ALA@163UI
	复用代码请在显著位置标注来源【ALA@网易有爱】
--]]--

local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local GetWhoInfo = C_FriendList and C_FriendList.GetWhoInfo or GetWhoInfo or function() end
local GetQuestDifficultyColor = GetQuestDifficultyColor;
local nameParse = nil;
if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
    nameParse = "WhoListScrollFrameButton";
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    nameParse = "WhoFrameButton";
else
    return;
end
local names = {  };
local levels = {  };
local classes = {  };
local vars = {  };

local i = 1;
while true do
    local b = _G[nameParse .. i];
    if b then
        names[i] = b.Name;
        levels[i] = b.Level;
        classes[i] = b.Class;
        vars[i] = b.Variable;
    else
        break;
    end
    i = i + 1;
end

local function update()
    local whoOffset = FauxScrollFrame_GetOffset(WhoListScrollFrame);

    local playerZone = GetRealZoneText();
    local playerGuild = GetGuildInfo('player');
    local playerRace = UnitRace('player');
    local var = UIDropDownMenu_GetSelectedID(WhoFrameDropDown);

    for i = 1, WHOS_TO_DISPLAY, 1 do
        local index = whoOffset + i;

        local info = GetWhoInfo(index);
        if not info then return end
        local name, guild, level, race, class, zone, classFileName = info.fullName, info.fullGuildName, info.level, info.raceStr, info.classStr, info.area, info.filename;
        if name then
            local color = RAID_CLASS_COLORS[classFileName];
            names[i]:SetTextColor(color.r, color.g, color.b);
            classes[i]:SetTextColor(color.r, color.g, color.b);
            local color = GetQuestDifficultyColor(level);
            levels[i]:SetTextColor(color.r, color.g, color.b);
            if var == 1 then
                if zone == playerZone then
                    zone = '\124cff00ff00' .. zone .. '\124r';
                end
                vars[i]:SetText(zone);
            elseif var == 2 then
                if guild == playerGuild then
                    guild = '\124cff00ff00' .. guild .. '\124r';
                end
                vars[i]:SetText(guild);
            elseif var == 3 then
                if race == playerRace then
                    race = '\124cff00ff00' .. race .. '\124r';
                end
                vars[i]:SetText(race);
            end
        end
    end
end

hooksecurefunc('WhoList_Update', update)
hooksecurefunc(WhoListScrollFrame, "update", update);