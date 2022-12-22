-- ItemItem.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/6/2021, 1:40:23 PM
--
---@type ns
local ns = select(2, ...)

local ItemItem = ns.Addon:NewClass('UI.ItemItem', 'ItemButton')

function ItemItem:Constructor()
    self.hasItem = true
    self:SetScript('OnEnter', self.OnEnter)
    self:SetScript('OnLeave', self.OnLeave)
    self:SetScript('OnClick', self.OnClick)
end

function ItemItem:OnEnter()
    GameTooltip:SetOwner(self,'ANCHOR_RIGHT')
    if type(self.item) == 'number' then
        GameTooltip:SetItemByID(self.item)
    else
        GameTooltip:SetHyperlink(self.item)
    end
    CursorUpdate(self)
    self:SetScript('OnUpdate', CursorUpdate)
end

function ItemItem:OnLeave()
    GameTooltip_Hide()
    ResetCursor()
    self:SetScript('OnUpdate', nil)
end

function ItemItem:OnClick()
    HandleModifiedItemClick(self:GetItemLink())
end
