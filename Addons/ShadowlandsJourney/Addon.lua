-- Addon.lua
-- @Author : Dencer
-- @Link   : https://dengsir.github.io
-- @Date   : 3/25/2021, 10:45:44 AM
--
---@type ns
local ns = select(2, ...)

---@type Addon
local Addon = LibStub('AceAddon-3.0'):NewAddon('ShadowlandsJourney', 'LibClass-2.0', 'AceEvent-3.0')

ns.Addon = Addon

---@type UI
ns.UI = {}
---@type NeteaseStats
ns.Stats = LibStub('LibNeteaseStats-1.0'):New(...)

ns.Stats:Send('LOGIN')

function Addon:OnInitialize()
    self.MainPanel = ns.UI.MainPanel:Bind(_G.ShadowlandsJourney)
    self.MainPanel:SetPoint('CENTER')
    tinsert(UISpecialFrames, "ShadowlandsJourney");

    self.db = LibStub('AceDB-3.0'):New('SHADOWLANDSJOURNEY_DB', { --
        profile = { --
            window = { --
                minimap = {minimapPos = 56},
            },
        },
    })

    local LDB = LibStub('LibDataBroker-1.1')
    local BrokerObject = LDB:NewDataObject('ShadowlandsJourney', {
        type = 'data source',
        icon = ns.ICON,
        OnClick = function()
            self.Flash:Hide()
            return self:Toggle(true)
        end,
        OnEnter = function(owner)
            GameTooltip:SetOwner(owner, 'ANCHOR_BOTTOM')
            GameTooltip:SetText('暗影界旅程')
            GameTooltip:Show()
        end,
        OnLeave = GameTooltip_Hide,
    })

    local LibDBIcon = LibStub('LibDBIcon-1.0')
    LibDBIcon:Register('ShadowlandsJourney', BrokerObject, self.db.profile.window.minimap)

    self.Flash = CreateFrame('Frame', nil, LibDBIcon:GetMinimapButton('ShadowlandsJourney'),
                             'ShadowlandsJourneyMinimapFlashTemplate')

    ns.CleanChapters()
end

function Addon:OnModuleCreated(module)
    ns[module:GetName()] = module
end

function Addon:OnClassCreated(class, name)
    local uiName = name:match('^UI%.(.+)$')
    if uiName then
        ns.UI[uiName] = class
        -- ns.Events:Embed(class)
    else
        ns[name] = class
    end
end

function Addon:OnEnable()
    self:RegisterEvent('PLAYER_LEVEL_CHANGED', 'CheckFlash')
    self:RegisterEvent('QUEST_TURNED_IN')
    self:CheckFlash()
end

function Addon:Toggle(userInput)
    if self.MainPanel:IsShown() then
        -- HideUIPanel(self.MainPanel)
        self.MainPanel:Hide();
    else
        -- ShowUIPanel(self.MainPanel)
        self.MainPanel:Show();
        ns.Stats:Send('UI_OPENED', userInput)
    end
end

function Addon:CheckFlash()
    if GetAverageItemLevel() < 200 and UnitLevel('player') >= 48 then
        self.Flash:Show()
    end

    -- if UnitLevel('player') == 60 and not self.MainPanel:IsShown() then
    --     self:Toggle(true)
    -- end
end

function Addon:QUEST_TURNED_IN(_, questID, xpReward, moneyReward)
    if ns.IsShowTips(questID) and not self.MainPanel:IsShown() then
        if not StaticPopupDialogs['SHADOWLANDS_JOURNEY_SHOW_TIPS'] then
            StaticPopupDialogs['SHADOWLANDS_JOURNEY_SHOW_TIPS'] =
                {
                    text = '暗影界旅程将帮助玩家体验魔兽世界完整剧情任务线，如有需要请在右上角小地图中打开',
                    button1 = YES,
                    hideOnEscape = 1,
                    timeout = 0,
                    exclusive = 1,
                    whileDead = 1,
                }
        end
        StaticPopup_Show('SHADOWLANDS_JOURNEY_SHOW_TIPS')
        ShowUIPanel(self.MainPanel)
    end
end
