local function ripairsiter(table, index)
	index = index - 1;
	if index > 0 then
		return index, table[index];
	end
end

local function ripairs(table)
	return ripairsiter, table, #table + 1;
end



-- API.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/7/2021, 12:34:29 PM
--
---@type ns
local ns = select(2, ...)

ns.ICON = 3601566

ns.CLASS_ARMORS = {
    DEATHKNIGHT = LE_ITEM_ARMOR_PLATE,
    WARRIOR = LE_ITEM_ARMOR_PLATE,
    ROGUE = LE_ITEM_ARMOR_LEATHER,
    MAGE = LE_ITEM_ARMOR_CLOTH,
    PRIEST = LE_ITEM_ARMOR_CLOTH,
    HUNTER = LE_ITEM_ARMOR_MAIL,
    WARLOCK = LE_ITEM_ARMOR_CLOTH,
    DEMONHUNTER = LE_ITEM_ARMOR_LEATHER,
    SHAMAN = LE_ITEM_ARMOR_MAIL,
    DRUID = LE_ITEM_ARMOR_LEATHER,
    MONK = LE_ITEM_ARMOR_LEATHER,
    PALADIN = LE_ITEM_ARMOR_PLATE,
}

local QUESTS_FORCE_FINISHED = { --
    [57876] = true,
    [57877] = true,
    [57878] = true,
}

local QUESTS_SHOW_TIP = {[59751] = true, [57878] = true}

local ALL_COMPLETED

local function IsQuestFinished(questId)
    if not questId then
        return
    end
    if QUESTS_FORCE_FINISHED[questId] then
        return C_Covenants.GetActiveCovenantID() ~= 0
    end
    return ALL_COMPLETED[questId]
end

function ns.RefreshQuestComplated()
    ALL_COMPLETED = tInvert(C_QuestLog.GetAllCompletedQuestIDs())

    for _, chapter in ipairs(ns.CHAPTERS) do
        for _, tab in ipairs(chapter.children) do
            local firstUnfinished = true
            for _, line in ipairs(tab.children) do
                local allFinished = true
                local anyProcessing = false

                for _, quest in ipairs(line.children) do
                    quest.finished = IsQuestFinished(quest.id) or IsQuestFinished(quest.finishId)
                    quest.processing = nil

                    if not quest.finished then
                        allFinished = false

                        if firstUnfinished then
                            quest.processing = true
                            firstUnfinished = nil
                            anyProcessing = true
                        end

                        if not quest.processing and C_QuestLog.IsOnQuest(quest.id) then
                            quest.processing = true
                            anyProcessing = true
                        end
                    end
                end

                line.finished = allFinished
                line.processing = anyProcessing
            end
        end
    end
end

function ns.CleanChapters()
    local faction = UnitFactionGroup('player')

    for _, chapter in ipairs(ns.CHAPTERS) do
        for _, tab in ipairs(chapter.children) do
            for _, line in ripairs(tab.children) do
                for i, quest in ipairs(line.children) do
                    if quest.faction and quest.faction ~= faction then
                        tremove(line.children, i)
                    end
                end
            end
        end
    end
end

function ns.FormatZone(zone)
    if not zone then
        return
    end

    if zone.x then
        return format('%s(%d,%d)', zone.zone, zone.x, zone.y)
    else
        return zone.zone
    end
end

function ns.ApplyAtlas(texture, atlas, sizeRatio)
    local info = C_Texture.GetAtlasInfo(atlas)
    texture:SetAtlas(atlas)
    texture:SetSize(info.width * sizeRatio, info.height * sizeRatio)
end

function ns.IsShowTips(questID)
    return QUESTS_SHOW_TIP[questID]
end

--[[@debug@
local orig_C_Covenants_GetActiveCovenantID = C_Covenants.GetActiveCovenantID

_G.D = 1
function C_Covenants.GetActiveCovenantID()
    local id = orig_C_Covenants_GetActiveCovenantID()
    if id ~= 0 then
        return id
    end
    return _G.D
end
--@end-debug@]]
