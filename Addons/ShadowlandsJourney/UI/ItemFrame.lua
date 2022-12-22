-- ItemFrame.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/8/2021, 2:50:15 PM
--
---@type ns
local ns = select(2, ...)

---@type ItemFrame
local ItemFrame = ns.Addon:NewClass('UI.ItemFrame', 'Frame')

function ItemFrame:Constructor()
    self.buttons = {}
end

function ItemFrame:SetItems(items)
    self.items = items
    self:Refresh()
end

function ItemFrame:Refresh()
    self:SetScript('OnUpdate', self.OnUpdate)
end

function ItemFrame:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:Update()
end

function ItemFrame:Update()
    local size = 37
    local spacing = 5
    local cell = size + spacing
    local col = floor(self:GetWidth() / cell)

    if col <= 0 then
        return
    end

    for i, id in ipairs(self.items) do
        local y = floor((i - 1) / col)
        local x = (i - 1) % col

        local button = self.buttons[i]
        if not button then
            button = ns.UI.ItemItem:New(self)
            button:SetPoint('TOPLEFT', x * cell, -y * cell)
            button:SetSize(size, size)
            self.buttons[i] = button
        end

        button:SetItem(id)
        button:Show()
    end

    for i = #self.items + 1, #self.buttons do
        self.buttons[i]:Hide()
    end
end
