local _, U1 = ...

--[=[
local fm = CreateFrame("Frame")
for k, _ in pairs(U1.captureEvents) do fm:RegisterEvent(k) end
fm:SetScript("OnEvent", function(self, event, ...) print(event, ...) end)
--]=]

--[[
--/run C_LFGList.Search(3, {{matches={"王座"}}}, 1, 4, {})

_G.HLFG = function(catId, terms, filter, prefer, language) 
    print("Search =========== catId", catId)
    print("terms:", (Stringfy(terms, "", -1, true, true):gsub("\n", "")))
    print("filter:", (Stringfy(filter, "", -1, true, true):gsub("\n", "")), "prefered:", (Stringfy(prefer, "", -1, true, true):gsub("\n", "")))
    if language then print("language:", (Stringfy(language, "", -1, true, true):gsub("\n", ""))) end
end

hooksecurefunc(C_LFGList, "Search", _G.HLFG);
--]]

local enabled = false;
function ToggleItemLevel_EncounterJournalLootButton(v)
    enabled = v;
end
CoreDependCall("blizzard_encounterjournal", function()
    if EncounterJournal_SetLootButton ~= nil then
        local GetDetailedItemLevelInfo = GetDetailedItemLevelInfo;
        local _ilstrpool = {  };
        local function hook(item)
            local ilstr = item.__ItemLevelStr;
            if ilstr == nil then
                ilstr = item.lootFrame:CreateFontString(nil, "OVERLAY");
                ilstr:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
                ilstr:SetTextColor(1.0, 0.85, 0.75);
                local pt = item.lootFrame.icon;
                ilstr:SetPoint("TOPLEFT", pt, "TOPLEFT", 2, -2);
                item.__ItemLevelStr = ilstr;
                _ilstrpool[item] = ilstr;
            end
            if enabled then
                local link = item.link;
                if link ~= nil then
                    local lvl, pre, base = GetDetailedItemLevelInfo(link);
                    if lvl ~= nil then
                        ilstr:SetText(lvl);
                    else
                        ilstr:SetText(nil);
                    end
                else
                    ilstr:SetText(nil);
                end
            end
        end
        hooksecurefunc("EncounterJournal_SetLootButton", hook);
        ToggleItemLevel_EncounterJournalLootButton = function(v)
            enabled = v;
            for item, ilstr in next, _ilstrpool do
                ilstr:SetShown(v);
                hook(item);
            end
        end
    end
end)


local _RemovedAddOn = {
    -- "!!!163UI.3dcodecmd!!!",
    "HandyNotes_Arathi",
    "TomCats-DarkshoreRares", "TomCats-Mechagon", "TomCats-Nazjatar",
    "DBM-Argus", "DBM-Azeroth-BfA", "DBM-GarrisonInvasions",
    "ChocolateBar_Options",
    "tdpack", "tdCore", "tdpack2",
    "ChatFilter",
    "CorruptionTooltips",
    "_NPCScan",
    "EquippedItemLevelTooltip",
    "ItemLevelDisplay",
    "Dominos_CastClassic",
    "AzeritePowerWeights", "AzeriteTooltip",
    "GridStatusRaidDebuff", "GridStatusRD_BfA", "GridStatusRD_Legion", "GridStatusRD_MoP", "GridStatusRD_WoD",
    "KayrCovenantMissions",
    -- "CompactRaid",
    "DBM-DefaultSkin",
};
function U1RemovedAddOn(...)
    local removed = {}
    for i=1, select('#', ...) do
        local addon = select(i, ...)
        local reason = select(5, GetAddOnInfo(addon))
        if reason ~= "MISSING" then
            local vendor = GetAddOnMetadata(addon, "X-Vendor")
            if vendor and vendor:upper() == "NETEASE" then
                DisableAddOn(addon)
                table.insert(removed, addon)
            end
        end
    end
    -- if #removed > 0 then
    --     U1Message("插件"..table.concat(removed, ",").."已废弃，请使用客户端更新或手工删除")
    -- end
end
U1RemovedAddOn(unpack(_RemovedAddOn))
local _RemovedAddOnHash = {  };
for _, addon in next, _RemovedAddOn do
    _RemovedAddOnHash[addon] = true;
    _RemovedAddOnHash[addon:upper()] = true;
    _RemovedAddOnHash[addon:lower()] = true;
end
U1._RemovedAddOnHash = _RemovedAddOnHash;


local F = CreateFrame('FRAME');
F:RegisterEvent("ADDON_LOADED");
F:SetScript("OnEvent", function(F, event, addon)
    if addon == _ then
        F:UnregisterEvent("ADDON_LOADED");
        if U1DBG and U1DBG.__upgrade10 == nil then
            U1DBG.__upgrade10 = true;
            for name, info in U1IterateAllAddons() do
                if info.defaultEnable == false or info.defaultEnable == 0 then
                    DisableAddOn(name);
                end
            end
            SaveAddOns();
        end
    end
end);
