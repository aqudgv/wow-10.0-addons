-- QuestItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/2/2021, 2:46:50 PM
--
---@type ns
local ns = select(2, ...)

---@type QuestItem
local QuestItem = ns.Addon:NewClass('UI.QuestItem', 'Button')

function QuestItem:Constructor()
    self:SetScript('OnClick', self.OnClick)
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self.UpdateTooltip = self.OnEnter
end

function QuestItem:SetData(depth, item)
    self.depth = depth
    self.item = item
    self.Depth1:SetShown(depth == 1)
    self.Depth2:SetShown(depth == 2)

    if depth == 1 then
        self.Depth1.Text:SetText(item.name)

        if item.finished then
            self.Depth1.Icon:SetAtlas('jailerstower-wayfinder-rewardcheckmark')
            self.Depth1.Icon:SetSize(20, 20)
            self.Depth1.Text:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
            self.Depth1.Unfinished:Hide()
            self.Depth1.Unfinished:SetText('')
        elseif item.processing then
            self.Depth1.Icon:SetAtlas('adventureguide-icon-whatsnew')
            self.Depth1.Icon:SetSize(20, 20)
            self.Depth1.Text:SetTextColor(NORMAL_FONT_COLOR:GetRGB())
            self.Depth1.Unfinished:Show()
            self.Depth1.Unfinished:SetText('(未完成)')
        else
            self.Depth1.Icon:SetAtlas('LFG-lock')
            self.Depth1.Icon:SetSize(16, 20)
            self.Depth1.Text:SetTextColor(GRAY_FONT_COLOR:GetRGB())
            self.Depth1.Unfinished:Show()
            self.Depth1.Unfinished:SetText('(未完成)')
        end
    elseif depth == 2 then
        local finished = item.finished
        local color = finished and GRAY_FONT_COLOR or NORMAL_FONT_COLOR

        self.Depth2.Text:SetText(item.name)

        if item.finished then
            self.Depth2.Text:SetTextColor(HIGHLIGHT_FONT_COLOR:GetRGB())
        elseif item.processing then
            self.Depth2.Text:SetTextColor(NORMAL_FONT_COLOR:GetRGB())
        else
            self.Depth2.Text:SetTextColor(GRAY_FONT_COLOR:GetRGB())
        end

        if finished then
            self.Depth2.Icon:Show()
        else
            self.Depth2.Icon:Hide()
        end
    else
        error('')
    end

    if GetMouseFocus() == self then
        self:OnEnter()
    end
end

function QuestItem:OnClick()
    self:GetParent():GetParent():ToggleItem(self.item)
end

function QuestItem:OnEnter()
    if not self.item then
        return self:OnLeave()
    end

    if self.item.id then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetHyperlink('quest:' .. self.item.id)

        if GameTooltip:NumLines() == 0 then
            GameTooltip:SetText(self.item.name)
        end

        local zone = ns.FormatZone(self.item.zone)
        local renown = self.item.renown
        if zone or renown then
            GameTooltip:AddLine(' ')
            if zone then
                GameTooltip:AddLine(format('任务起始：%s', zone), 0, 1, 1)
            end
            if renown then
                GameTooltip:AddLine(format('需要名望：%d', renown), 0, 1, 1)
                GameTooltip:AddLine(
                    '圣所内完成周常、使命任务，参与英雄以上难度地下城可以有效提高名望',
                    0.8, 0.8, 0.8, true)
            end
        end
        GameTooltip:Show()
    elseif self.item.renown then
        GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
        GameTooltip:SetText(format('需要名望：%d', self.item.renown), 0, 1, 1)
        GameTooltip:AddLine(
            '圣所内完成周常、使命任务，参与英雄以上难度地下城可以有效提高名望', 0.8,
            0.8, 0.8, true)
        GameTooltip:Show()
    else
        self:OnLeave()
    end
end

function QuestItem:OnLeave()
    GameTooltip_Hide()
end
