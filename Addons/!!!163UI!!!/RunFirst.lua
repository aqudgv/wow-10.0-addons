local _, U1 = ...

--DEBUG_MODE = 1
U1PlayerName = UnitName("player")
U1PlayerClass = UnitClassBase("player")

local __TAG = select(2, BNGetInfo());
if select(2, GetAddOnInfo("!!!!!DebugMe")) ~= nil then
    SetCVar("scriptErrors", 1)
else
    SetCVar("scriptErrors", DEBUG_MODE and 1 or 0)
    local _noop = function() end
    --  kill totally
    seterrorhandler(_noop);
    if ScriptErrorsFrame ~= nil then
        ScriptErrorsFrame:SetAlpha(0.0);
        ScriptErrorsFrame:EnableMouse(false);
        ScriptErrorsFrame.Show = _noop;
        ScriptErrorsFrame.DisplayMessage = _noop;
        ScriptErrorsFrame.DisplayMessageInternal = _noop;
    end
    if _G.HandleLuaError then
        _G.HandleLuaError = _noop;
    end
    if _G.HandleLuaWarning then
        _G.HandleLuaWarning = _noop;
    end
end
U1.PLAYER_BN_TAG = __TAG;

--- 全关插件然后再单独启用控制台时, 恢复之前的状态, 方便全关测试是否插件问题然后恢复
local sum = 0
for i = 1, GetNumAddOns() do
    sum = sum + GetAddOnEnableState(U1PlayerName,i)
end
U1.returnFromDisableAll = sum == 2

---创建一个locale表, 对于["text"]=true的值会返回"text", 同时L["zhCN"]会有值
local localeMetaTable = {
    __newindex = function(t, k, v)
        rawset(t, k, v == true and k or v)
    end
};
function NewLocale()
    local loc = GetLocale();
    return setmetatable({ [loc] = true }, localeMetaTable);
end

U1.L = NewLocale()
local L = U1.L
U1.CN = GetLocale():sub(1, 2) == "zh"

local f = CreateFrame("Frame") --最先注册
f:RegisterEvent("ADDON_LOADED") --ADDON_LOADED已经可以获取db了
f:RegisterEvent("VARIABLES_LOADED")
f:RegisterEvent("PLAYER_LOGIN")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_LOGOUT")
-- f:RegisterEvent("CVAR_UPDATE")
U1.eventframe = f
--f:SetScript("OnEvent", function(...) print(...) end) -- will be placed in 163UI.lua


--这里是所有要第一时间运行的函数
function normalize(num, min, max)
    return (num < min and min) or (num > max and max) or num;
end

function U1Message(text, r, g, b, chatFrame)
    (chatFrame or DEFAULT_CHAT_FRAME):AddMessage(L["|cffcd1a1c【网易有爱】|r- "]..text, r, g, b);
end

local cfNames = {} for i=1, NUM_CHAT_WINDOWS do cfNames[i] = "ChatFrame"..i end
function WithAllChatFrame(func, ...)
    for i=1, NUM_CHAT_WINDOWS do
        local chatFrame = _G[cfNames[i]]
        if chatFrame then func(chatFrame, ...); end
    end
end

--UI163_USER_MODE = 1 --- alwaysRegister=1 and not checkVendor
--UI163_USE_X_CATEGORIES = 1 --- use X-Categories tag


UnitIsTapped = function() end
CLASS_BUTTONS = CLASS_ICON_TCOORDS
CooldownFrame_SetTimer = CooldownFrame_Set

--WithAllChatFrame(function(frame) frame:SetMaxLines(5000) end)


local function _checkPos(frame)
    local l, r, t, b = frame:GetLeft(), frame:GetRight(), frame:GetTop(), frame:GetBottom();
    local ux, uy = UIParent:GetSize();
    if l ~= nil and r ~= nil and b ~= nil and t ~= nil then
        if l > ux - 16 or r < 16 or b > uy - 16 or t < 16 then
            return true;
        end
    end
    return false;
end
function _163_PreventOutOfScreen(frame, def)
    if frame ~= nil then
        local function _check()
            if _checkPos(frame) then
                frame:ClearAllPoints();
                frame:SetPoint(unpack(def, 1, 5));
            end
        end
        frame:HookScript("OnShow", _check);
        frame:HookScript("OnDragStop", _check);
        frame:HookScript("OnMouseUp", _check);
    end
end

local gmatch, debugstack, strfind = gmatch, debugstack, strfind;
function __163__BREAKPOINT__()
    local str = "\124cff00ff00>\124r ";
    local first = true;
    for file, line in gmatch(debugstack(0), "\\([^\\^:]+\\[^\\^:]+\.lua)\"\]:([0-9]+):") do
        if first and file == "!!!163UI!!!\\RunFirst.lua" then
        else
            str = str .. " #" .. file .. ":" .. line;
        end
        if strfind(file, "^Blizzard_") or strfind(file, "^FrameXML") or strfind(file, "^SharedXML") then
            break;
        end
        first = false;
    end
    DEFAULT_CHAT_FRAME:AddMessage(str);
end


--[=[]=]
SetAddonVersionCheck(false);

local version, build, complied_time, toc = GetBuildInfo();
if toc >= 90000 then
    print(GetAddOnEnableState(UnitName('player'), "CompactRaid"))
    if GetAddOnEnableState(UnitName('player'), "CompactRaid") > 1 then
    -->     Widget API
        local frameTypes = {
            'FRAME',
                'BROWSER',
                'BUTTON',
                    'CHECKBUTTON',
                    'ITEMBUTTON',
                'CHECKOUT',
                'COLORSELECT',
                'COOLDOWN',
                'EDITBOX',
                'FOGOFWARFRAME',		--	no method Hide
                'GAMETOOLTIP',
                'MESSAGEFRAME',
                -- 'MINIMAP',
                'MODEL',
                    'PLAYERMODEL',
                        'CINEMATICMODEL',
                        'DRESSUPMODEL',
                        'TABARDMODEL',
                'MODELSCENE',
                -- 'MODELSCENEACTOR',
                'MOVIEFRAME',
                'OFFSCREENFRAME',
                -- 'POIFARME',
                    'ARCHAEOLOGYDIGSITEFRAME',
                    'QUESTPOIFRAME',
                    'SCENARIOPOIFRAME',
                'SCROLLFRAME',
                'SCROLLINGMESSAGEFRAME',
                'SIMPLEHTML',
                'SLIDER',
                'STATUSBAR',
                'UNITPOSITIONFRAME',
                -- 'WORLDFRAME'
        };
        for _, v in ipairs(frameTypes) do
            local frame = CreateFrame(v);
            frame:Hide();
            local metatable = getmetatable(frame).__index;
            Mixin(metatable, BackdropTemplateMixin);
        end
    -->
    end
    -- 一些常用的变量会被莫名其妙重置的, 必须在VARIABLES_LOADED里设置
    local f01 = CreateFrame("Frame")
    f01:RegisterEvent("VARIABLES_LOADED")
    f01:SetScript("OnEvent", function(self)
        if U1DBA and U1DBA.configs then
            local c = U1DBA.configs["163ui_moreoptions/cvar_nameplateMaxDistance"]
            if c == "0" or c == "nil" then
                U1DBA.configs["163ui_moreoptions/cvar_nameplateMaxDistance"] = "60"
            end
        end
        local dist = GetCVar("nameplateMaxDistance")
        if not dist or dist == "0" or dist == "nil" or dist == 0 then
            SetCVar("nameplateMaxDistance", 60)
        end
        SetCVar("showQuestTrackingTooltips", 1)
        self:UnregisterAllEvents()
    end)

    if C_FriendList ~= nil then
        _G.GetNumFriends = C_FriendList.GetNumFriends;
        for name, func in next, C_FriendList do
            if _G[name] == nil then
                _G[name] = func;
            end
        end
        local __GetNumOnlineFriends = C_FriendList.GetNumOnlineFriends;
        local __GetNumFriends = C_FriendList.GetNumFriends;
        _G.GetNumFriends = function()
            return __GetNumOnlineFriends(), __GetNumFriends();
        end
    end
    if C_GossipInfo ~= nil then
        _G.GetNumGossipAvailableQuests = C_GossipInfo.GetNumAvailableQuests;
        _G.GetNumGossipActiveQuests = C_GossipInfo.GetNumActiveQuests;
        _G.GetNumGossipOptions = C_GossipInfo.GetNumOptions;
        _G.GetGossipActiveQuests = C_GossipInfo.GetActiveQuests;
        _G.GetGossipAvailableQuests = C_GossipInfo.GetAvailableQuests;
        _G.SelectGossipAvailableQuest = C_GossipInfo.SelectAvailableQuest;
        _G.SelectGossipActiveQuest = C_GossipInfo.SelectActiveQuest;
        _G.SelectGossipOption = C_GossipInfo.SelectOption;
        -- for name, func in next, C_GossipInfo do
        --     if _G[name] == nil then
        --         _G[name] = func;
        --     end
        -- end
    end
    if C_QuestLog ~= nil then
        -- _G.AbandonQuest = C_QuestLog.AbandonQuest;
        for name, func in next, C_QuestLog do
            if _G[name] == nil then
                _G[name] = func;
            end
        end
        _G.IsQuestComplete = C_QuestLog.IsComplete;
        local __C_QuestLog_GetInfo = C_QuestLog.GetInfo;
        _G.GetQuestLogTitle = function(index)
            local info = __C_QuestLog_GetInfo(index);
            if info == nil then
                return nil;
            end
            return info.title, info.level, info.suggestedGroup, info.isHeader, info.isCollapsed, C_QuestLog.IsComplete(info.questID), 
                info.frequency, info.questID, info.startEvent, info.questID, info.isOnMap, info.hasLocalPOI, 
                info.isTask, info.isBounty, info.isStory, info.isHidden, info.isScaling;
        end
        -- _G.GetQuestLogIndexByID =
        local __GetSelectedQuest = C_QuestLog.GetSelectedQuest;
        local __GetNumQuestLogChoices = GetNumQuestLogChoices;
        _G.GetNumQuestLogChoices = function(questId, c)
            if questId == nil then
                questId = __GetSelectedQuest();
            end
            return __GetNumQuestLogChoices(questId, c);
        end
        _G.GetQuestGreenRange = function()
            return 10;
        end
        _G.GetQuestLogIndexByID = C_QuestLog.GetLogIndexForQuestID;
        C_QuestLog.GetQuestInfo = C_QuestLog.GetInfo;
        -- _G.GetQuestLogPushable = function(index)
        --     local questID = nil;
        --     if index == nil then
        --         questID = __GetSelectedQuest();
        --     else
        --         local info = __C_QuestLog_GetInfo(index);
        --         if info ~= nil then
        --             questID = info.questID;
        --         end
        --     end
        --     if questID ~= nil then
        --         return C_QuestLog.IsPushableQuest(questID);
        --     end
        -- end
        _G.GetQuestBountyInfoForMapID = GetQuestBountyInfoForMapID or C_QuestLog.GetBountiesForMapID;
    end
    _G.IsQuestWatched = IsQuestWatched or QuestUtils_IsQuestWatched;
    if C_SuperTrack ~= nil then
        for name, func in next, C_SuperTrack do
            if _G[name] == nil then
                _G[name] = func;
            end
        end
    end
    if C_TaskQuest ~= nil then
        -- local __GetSelectedQuest = C_QuestLog.GetSelectedQuest;
        -- C_TaskQuest.__GetQuestTimeLeftMinutes = C_TaskQuest.GetQuestTimeLeftMinutes;
        -- C_TaskQuest.GetQuestTimeLeftMinutes = function(questId, ...)
        --     if questId == nil then
        --         questId = __GetSelectedQuest();
        --     end
        --     if questId == nil then
        --         return nil;
        --     end
        --     return C_TaskQuest.__GetQuestTimeLeftMinutes(questId, ...)
        -- end
        -- C_TaskQuest.__GetQuestTimeLeftSeconds = C_TaskQuest.GetQuestTimeLeftSeconds;
        -- C_TaskQuest.GetQuestTimeLeftSeconds = function(questId, ...)
        --     if questId == nil then
        --         questId = __GetSelectedQuest();
        --     end
        --     if questId == nil then
        --         return nil;
        --     end
        --     return C_TaskQuest.__GetQuestTimeLeftSeconds(questId, ...)
        -- end
    end
    if C_EncounterJournal ~= nil then
        -- for name, func in next, C_EncounterJournal do
        --     local name2 = "EJ_" .. name;
        --     if _G[name2] == nil then
        --         _G[name2] = func;
        --     end
        -- end
    end
    if C_GuildInfo ~= nil then
        for name, func in next, C_GuildInfo do
            if _G[name] == nil then
                _G[name] = func;
            end
        end
    end
    -- _G.GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT = TOOLTIP_BACKDROP_STYLE_DEFAULT;
    -- _G.GameTooltip_SetBackdropStyle = SharedTooltip_SetBackdropStyle;
    -- _G.MAX_PLAYER_LEVEL_TABLE = { 25, 27, 30, 32, 35, 40, 45, 50, 60 };
    -- _G.UnitIsWarModePhased = function() return false; end
    -- _G.MAX_CONTAINER_ITEMS = 36;
    -- if C_CurrencyInfo ~= nil then
    --     for name, func in next, C_CurrencyInfo do
    --         if _G[name] == nil then
    --             _G[name] = func;
    --         end
    --     end
    -- end
    -- for q = 0, 10 do
    --     if WORLD_QUEST_QUALITY_COLORS[q] == nil then
    --         WORLD_QUEST_QUALITY_COLORS[q] = { r = 1.0, g = 1.0, b = 1.0, };
    --     end
    -- end
    -- _G.AUTO_QUEST_POPUP_TRACKER_MODULE = QUEST_TRACKER_MODULE;
    -- _G.DIFFICULTY_DUNGEON_NORMAL =      DifficultyUtil.ID.DungeonNormal;
    -- _G.DIFFICULTY_DUNGEON_HEROIC =      DifficultyUtil.ID.DungeonHeroic;
    -- _G.DIFFICULTY_RAID10_NORMAL =       DifficultyUtil.ID.Raid10Normal;
    -- _G.DIFFICULTY_RAID25_NORMAL =       DifficultyUtil.ID.Raid25Normal;
    -- _G.DIFFICULTY_RAID10_HEROIC =       DifficultyUtil.ID.Raid10Heroic;
    -- _G.DIFFICULTY_RAID25_HEROIC =       DifficultyUtil.ID.Raid25Heroic
    -- _G.DIFFICULTY_RAID_LFR =            DifficultyUtil.ID.RaidLFR;
    -- _G.DIFFICULTY_DUNGEON_CHALLENGE =   DifficultyUtil.ID.DungeonChallenge;
    -- _G.DIFFICULTY_RAID40 =              DifficultyUtil.ID.Raid40;
    -- _G.DIFFICULTY_PRIMARYRAID_NORMAL =  DifficultyUtil.ID.PrimaryRaidNormal;
    -- _G.DIFFICULTY_PRIMARYRAID_HEROIC =  DifficultyUtil.ID.PrimaryRaidHeroic;
    -- _G.DIFFICULTY_PRIMARYRAID_MYTHIC =  DifficultyUtil.ID.PrimaryRaidMythic;
    -- _G.DIFFICULTY_PRIMARYRAID_LFR =     DifficultyUtil.ID.PrimaryRaidLFR;
    -- _G.DIFFICULTY_RAID_TIMEWALKER =     DifficultyUtil.ID.RaidTimewalker;
    -- _G.DIFFICULTY_DUNGEON_TIMEWALKER =  DifficultyUtil.ID.DungeonTimewalker;
    -- _G.DIFFICULTY_DUNGEON_MYTHIC =      DifficultyUtil.ID.DungeonMythic;
    -- _G.GetQuestsCompleted = _G.GetQuestsCompleted or function(tbl)
    --     local list = C_QuestLog.GetAllCompletedQuestIDs();
    --     if tbl ~= nil then
    --         wipe(tbl);
    --     else
    --         tbl = {  };
    --     end
    --     for index = 1, #list do
    --         tbl[list[index]] = 1;
    --     end
    --     return tbl;
    -- end
    if C_Texture ~= nil then
        -- _G.GetAtlasInfo = C_Texture.GetAtlasInfo;
    end
    --
    --
    -- LE_ITEM_QUALITY_COMMON = LE_ITEM_QUALITY_COMMON or Enum.ItemQuality.Common
    local __GetSelectedQuest = C_QuestLog.GetSelectedQuest;
    C_CampaignInfo.GetCurrentCampaignID = C_CampaignInfo.GetCurrentCampaignID or function()
        local quest = __GetSelectedQuest()
        if quest then
            return C_CampaignInfo.GetCampaignID(quest);
        end
    end
    --[====[
        local DIFFICULTY_DUNGEON_NORMAL = DIFFICULTY_DUNGEON_NORMAL or DifficultyUtil.ID.DungeonNormal;
        local DIFFICULTY_DUNGEON_HEROIC = DIFFICULTY_DUNGEON_HEROIC or DifficultyUtil.ID.DungeonHeroic;
        local DIFFICULTY_RAID10_NORMAL = DIFFICULTY_RAID10_NORMAL or DifficultyUtil.ID.Raid10Normal;
        local DIFFICULTY_RAID25_NORMAL = DIFFICULTY_RAID25_NORMAL or DifficultyUtil.ID.Raid25Normal;
        local DIFFICULTY_RAID10_HEROIC = DIFFICULTY_RAID10_HEROIC or DifficultyUtil.ID.Raid10Heroic;
        local DIFFICULTY_RAID25_HEROIC = DIFFICULTY_RAID25_HEROIC or DifficultyUtil.ID.Raid25Heroic
        local DIFFICULTY_RAID_LFR = DIFFICULTY_RAID_LFR or DifficultyUtil.ID.RaidLFR;
        local DIFFICULTY_DUNGEON_CHALLENGE = DIFFICULTY_DUNGEON_CHALLENGE or DifficultyUtil.ID.DungeonChallenge;
        local DIFFICULTY_RAID40 = DIFFICULTY_RAID40 or DifficultyUtil.ID.Raid40;
        local DIFFICULTY_PRIMARYRAID_NORMAL = DIFFICULTY_PRIMARYRAID_NORMAL or DifficultyUtil.ID.PrimaryRaidNormal;
        local DIFFICULTY_PRIMARYRAID_HEROIC = DIFFICULTY_PRIMARYRAID_HEROIC or DifficultyUtil.ID.PrimaryRaidHeroic;
        local DIFFICULTY_PRIMARYRAID_MYTHIC = DIFFICULTY_PRIMARYRAID_MYTHIC or DifficultyUtil.ID.PrimaryRaidMythic;
        local DIFFICULTY_PRIMARYRAID_LFR = DIFFICULTY_PRIMARYRAID_LFR or DifficultyUtil.ID.PrimaryRaidLFR;
        local DIFFICULTY_RAID_TIMEWALKER = DIFFICULTY_RAID_TIMEWALKER or DifficultyUtil.ID.RaidTimewalker;
        local DIFFICULTY_DUNGEON_TIMEWALKER = DIFFICULTY_DUNGEON_TIMEWALKER or DifficultyUtil.ID.DungeonTimewalker;
        local DIFFICULTY_DUNGEON_MYTHIC = DIFFICULTY_DUNGEON_MYTHIC or DifficultyUtil.ID.DungeonMythic;

            GetAlternatePowerInfoByID = function(barID)
                local barInfo = GetUnitPowerBarInfoByID(barID);
                if barInfo then
                    local name, tooltip, cost = GetUnitPowerBarStringsByID(barID);
                    return barInfo.barType,barInfo.minPower, barInfo.startInset, barInfo.endInset, barInfo.smooth, barInfo.hideFromOthers, barInfo.showOnRaid, barInfo.opaqueSpark, barInfo.opaqueFlash,
                            barInfo.anchorTop, name, tooltip, cost, barInfo.ID, barInfo.forcePercentage, barInfo.sparkUnderFrame;
                end
            end

            UnitAlternatePowerInfo = function(unit)
                local barID = UnitPowerBarID(unit);
                return GetAlternatePowerInfoByID(barID);
            end

            UnitAlternatePowerTextureInfo = function(unit, textureIndex, timerIndex)
                return GetUnitPowerBarTextureInfo(unit, textureIndex + 1, timerIndex);
            end

            UnitAlternatePowerCounterInfo = function(unit)
                local barInfo = GetUnitPowerBarInfo(unit);
                if barInfo then
                    return barInfo.fractionalCounter, barInfo.animateNumbers;
                end
            end


        local GetCurrencyInfo = GetCurrencyInfo;
        if GetCurrencyInfo == nil and C_CurrencyInfo.GetCurrencyInfo ~= nil then
            local __GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo;
            GetCurrencyInfo = function(index)
                if index ~= nil then
                    local info = __GetCurrencyInfo(index);
                    return info.name, info.quantity, info.iconFileID, info.quantityEarnedThisWeek, info.maxWeeklyQuantity, info.maxQuantity, info.discovered, info.quality;
                end
            end
        end

        local GetAtlasInfo = GetAtlasInfo or function(atlas)
            local info = C_Texture.GetAtlasInfo(atlas);
            if info then
                local file = info.filename or info.file;
                return file, info.width, info.height, info.leftTexCoord, info.rightTexCoord, info.topTexCoord, info.bottomTexCoord, info.tilesHorizontally, info.tilesVertically;
            end
        end

        local GetQuestsCompleted = GetQuestsCompleted or function(tbl)
        local list = C_QuestLog.GetAllCompletedQuestIDs();
        if tbl ~= nil then
            wipe(tbl);
        else
            tbl = {  };
        end
        for index = 1, #list do
            tbl[list[index]] = 1;
            end
            return tbl;
        end
        
    ]====]
elseif toc < 20000 then
    local CLASSIC_CLASS_INFO = {
        { "战士", "WARRIOR", 1 },
        { "圣骑士", "PALADIN", 2 },
        { "猎人", "HUNTER", 3 },
        { "潜行者", "ROGUE", 4 },
        { "牧师", "PRIEST", 5 },
        --{ "死亡骑士", "DEATHKNIGHT", },
        { "萨满", "SHAMAN", 6 },
        { "法师", "MAGE", 7 },
        { "术士", "WARLOCK", 8 },
        --{ "武僧", "MONK", },
        { "德鲁伊", "DRUID", 9 },
    }
    _G.GetNumClasses = _G.GetNumClasses or
    function()
        return #CLASSIC_CLASS_INFO;
    end

    _G.GetClassInfo = _G.GetClassInfo or
    function(i)
        if CLASSIC_CLASS_INFO[i] then
            return CLASSIC_CLASS_INFO[i][1], CLASSIC_CLASS_INFO[i][2], CLASSIC_CLASS_INFO[i][3];
        end
        return nil;
    end

    --\163UI>

    _G.SaveBindings = _G.AttemptToSaveBindings

    -- _G.UnitCastingInfo = function(unitId)
    --     if unitId == 'player' then
    --         return CastingInfo();
    --     end
    -- end

    -- _G.UnitChannelInfo = function(unitId)
    --     if unitId == 'player' then
    --         return ChannelInfo();
    --     end
    -- end

    --UnitIsTapped = function() end
    --CLASS_BUTTONS = CLASS_ICON_TCOORDS
    --CooldownFrame_SetTimer = CooldownFrame_Set

    function GetPlayerFactionGroup()
        return UnitFactionGroup("player");
    end

else
end

if StackSplitFrame ~= nil and OpenStackSplitFrame ~= nil then
    StackSplitFrame.OpenStackSplitFrame = StackSplitFrame.OpenStackSplitFrame or function(_, ...)
        return OpenStackSplitFrame(...);
    end;
end

--  Backdrop
TOOLTIP_BACKDROP_STYLE_DEFAULT = TOOLTIP_BACKDROP_STYLE_DEFAULT or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_DEFAULT_BACKGROUND_COLOR,
};
GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT = GAME_TOOLTIP_BACKDROP_STYLE_DEFAULT or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_DEFAULT_BACKGROUND_COLOR,
};

GAME_TOOLTIP_BACKDROP_STYLE_EMBEDDED = GAME_TOOLTIP_BACKDROP_STYLE_EMBEDDED or {
	-- Nothing
};

TOOLTIP_AZERITE_BACKGROUND_COLOR = TOOLTIP_AZERITE_BACKGROUND_COLOR or CreateColor(1, 1, 1);
GAME_TOOLTIP_BACKDROP_STYLE_AZERITE_ITEM = GAME_TOOLTIP_BACKDROP_STYLE_AZERITE_ITEM or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background-Azerite",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border-Azerite",
	tile = true,
	tileEdge = false,
	tileSize = 16,
	edgeSize = 19,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_AZERITE_BACKGROUND_COLOR,

	overlayAtlasTop = "AzeriteTooltip-Topper";
	overlayAtlasTopScale = .75,
	overlayAtlasBottom = "AzeriteTooltip-Bottom";
};

BACKDROP_TOOLTIP_16_16_5555 = BACKDROP_TOOLTIP_16_16_5555 or {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },

	backdropBorderColor = TOOLTIP_DEFAULT_COLOR,
	backdropColor = TOOLTIP_DEFAULT_BACKGROUND_COLOR,
};
