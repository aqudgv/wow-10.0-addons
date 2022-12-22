-- MainPanel.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/6/2021, 11:26:38 AM
--
---@type ns
local ns = select(2, ...)

---@type MainPanel
local MainPanel = ns.Addon:NewClass('UI.MainPanel', 'Frame')
LibStub('AceEvent-3.0'):Embed(MainPanel)

function MainPanel:Constructor()
    self.treeStatus = setmetatable({}, {
        __index = function(t, k)
            t[k] = ns.TreeStatus:New(k, 2)
            return t[k]
        end,
    })

    self.Suggestion1 = self.SuggestFrame.Suggestion1
    self.Chapter1 = self.SuggestFrame.Chapter1
    self.Chapter2 = self.SuggestFrame.Chapter2

    self.Armors = ns.UI.ItemFrame:Bind(self.SuggestFrame.Chapter2.Armors)
    self.Weapons = ns.UI.ItemFrame:Bind(self.SuggestFrame.Chapter2.Weapons)

    self:SetPortraitToAsset(ns.ICON)
    self:SetTitle('暗影界旅程')

    self:SetAttribute('UIPanelLayout-enabled', true)
    self:SetAttribute('UIPanelLayout-defined', true)
    self:SetAttribute('UIPanelLayout-whileDead', true)
    self:SetAttribute('UIPanelLayout-area', 'left')
    self:SetAttribute('UIPanelLayout-pushable', 1)

    ---@type TabView
    self.Tab = ns.UI.TabView:Bind(self.Suggestion1.Tab, 'ShadowlandsJourneyTabTemplate', 24)
    self.NavBar = ns.UI.TabView:Bind(self.NavBar, 'ShadowlandsJourneyChapterButtonTemplate', nil, 50)

    self.Quests = ns.UI.TreeView:Bind(self.Suggestion1.Quests, function(parent)
        return ns.UI.QuestItem:Bind(CreateFrame('Button', nil, parent, 'ShadowlandsJourneyQuestTemplate'))
    end)

    self.Quests:SetCallback('OnItemFormatting', function(_, button, depth, item)
        button:SetData(depth, item)
    end)

    self.Tab:SetCallback('OnSelectChanged', function(_, id)
        self.Quests:SetTreeStatus(self.treeStatus[self.Tab:GetTabValue(id)])
        self.Quests:SetVerticalScroll(0)
        self.Quests:Refresh()
    end)

    self.NavBar:SetCallback('OnSelectChanged', function(_, id)
        self:SetChapter(self.NavBar:GetTabValue(id))
    end)

    self.NavBar:SetTabs(ns.CHAPTERS, 'name')
    self.NavBar:SetTab(1)

    self:SetScript('OnShow', self.OnShow)
    self:SetScript('OnHide', self.OnHide)

    local ads = {
        '*圣所内完成周常、使命任务，参与英雄以上难度地下城可以有效提高名望',
        '*如果任务做的吃力，拍卖行购买装备可以有效提高装等及伤害',
        '*盟约护甲旁边的NPC可以升级盟约套装',
        '*勇气点数可以用来升级史诗及以上难度五人副本掉落的装备，最高可以升级到220',
        '*心能可以在4个盟约地图中通过完成世界任务获得',
        '*盟约使命任务在每日早晨7点更新', '*进入罪魂之塔前请先完成刻符者系列任务',
        '*拍卖行护甲类型下的符文铭刻所出售的物品是打造橙装的原材料',
        '*新手玩家在刚选择盟约后参与随机副本有很大概率获得名望徽章',
    }

    self.Chapter2.Ad1:SetText('*NPC可以将盟约套装最高升至197等级')
    self.Chapter2.Ad2:SetText(ads[fastrandom(1, #ads)])
end

function MainPanel:OnShow()
    ns.RefreshQuestComplated()

    if C_Covenants.GetActiveCovenantID() == 0 then
        self.NavBar:DisableTab(2)
        self.NavBar:SetTab(1)
    else
        self.NavBar:EnableTab(2)
        self.NavBar:SetTab(2)
    end

    self:RegisterEvent('QUEST_LOG_UPDATE', 'Update')
end

function MainPanel:OnHide()
    self:UnregisterAllEvents()
end

function MainPanel:Update()
    ns.RefreshQuestComplated()
    self.Quests:Refresh()
    self:UpdateSuggest()
end

---@param chapter Chapter
function MainPanel:SetChapter(chapter)
    self.chapter = chapter
    self:UpdateTabs()
    self:UpdateLayers()
    self:UpdateSuggest()
end

function MainPanel:UpdateLayers()
    local id = self.NavBar:GetCurrentTab()
    if id == 1 then
        self.Suggestion1.Title:SetText(self.chapter.name)

        SetPortraitToTexture(self.Suggestion1.Icon, 1033988)
        self.Suggestion1.Icon:SetSize(48, 48)
        self.Suggestion1.IconRing:SetAtlas('adventureguide-ring')
        self.Suggestion1.IconRing:SetSize(71, 71)
        self.Chapter1:Show()
        self.Chapter2:Hide()
    else

        local info = C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID())

        self.Suggestion1.Title:SetText(info.name)

        ns.ApplyAtlas(self.Suggestion1.IconRing, format('covenantchoice-celebration-%ssigil', info.textureKit),
                      0.6666667)
        ns.ApplyAtlas(self.Suggestion1.Icon, format('covenantchoice-celebration-%s-detailline', info.textureKit),
                      0.6666667)

        self.Chapter1:Hide()
        self.Chapter2:Show()
        self:UpdateItems()
    end
end

---@return Quest
function MainPanel:GetCurrentQuest()
    if not self.tabs then
        return
    end
    for _, tab in ipairs(self.tabs) do
        for _, line in ipairs(tab.children) do
            if line.processing then
                for _, quest in ipairs(line.children) do
                    if quest.processing then
                        return quest
                    end
                end
            end
        end
    end
end

function MainPanel:UpdateSuggest()
    local quest = self:GetCurrentQuest()
    if quest then
        local sb = {'|cffffffff当前最适合做的主线：|r\n', quest.name}

        if quest.zone then
            tinsert(sb, '，' .. quest.zone.zone)

            if quest.zone.x then
                tinsert(sb, format('(%d,%d)', quest.zone.x, quest.zone.y))
            end
        end

        self.SuggestFrame.Suggest:SetText(table.concat(sb))
    else
        self.SuggestFrame.Suggest:SetText('')
    end
end

function MainPanel:UpdateTabs()
    local tabs = {}
    for _, v in ipairs(self.chapter.children) do
        if not v.covenant or C_Covenants.GetActiveCovenantID() == v.covenant then
            tinsert(tabs, v)
        end
    end

    self.tabs = tabs
    self.Tab:SetTabs(tabs, 'name')
    self.Tab:SetTab(1)
    self.Tab:SetShown(#tabs > 1)
    self.Suggestion1.Inset:SetPoint('TOPLEFT', 20, self.Tab:IsShown() and -110 or -80)
end

function MainPanel:UpdateItems()
    local covenant = C_Covenants.GetActiveCovenantID()
    if covenant == 0 then
        return
    end

    local class = UnitClassBase('player')
    local armors = ns.ARMORS[covenant][ns.CLASS_ARMORS[class]]
    local weapons = ns.WEAPONS[class]

    self.Armors:SetItems(armors)
    self.Weapons:SetItems(weapons)
end
