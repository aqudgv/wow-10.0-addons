-- TabView.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/6/2021, 11:36:52 AM
--
---@type ns
local ns = select(2, ...)

---@type TabView
local TabView = ns.Addon:NewClass('UI.TabView', 'Frame')

function TabView:Constructor(_, tabTemplate, spacing, margin)
    self.spacing = spacing
    self.margin = margin
    self.tabTemplate = tabTemplate
    self.tabs = self.tabs or {}
    self.disabled = {}

    for _, tab in ipairs(self.tabs) do
        self:ApplyTab(tab)
    end
end

function TabView:GetTabValue(id)
    return self.list[id]
end

function TabView:SetTabs(list, key)
    for i, v in ipairs(list) do
        local tab = self:GetTab(i)
        tab:SetText(key and v[key] or v)
        tab:SetWidth(tab:GetTextWidth() + (self.margin or 0))
    end

    self.list = list
    self.numTabs = #list
    self:UpdateTabs()
end

function TabView:GetTab(i)
    if not self.tabs[i] then
        local tab = CreateFrame('Button', nil, self, self.tabTemplate, i)
        self:ApplyTab(tab)
        self.tabs[i] = tab
    end
    return self.tabs[i]
end

local function TabOnClick(self)
    return self:GetParent():SetTab(self:GetID())
end

function TabView:ApplyTab(tab)
    tab:SetScript('OnClick', TabOnClick)

    local id = tab:GetID()
    if id > 1 then
        tab:SetPoint('BOTTOMLEFT', self.tabs[id - 1], 'BOTTOMRIGHT', self.spacing or 0, 0)
    end
end

function TabView:SetTab(id)
    self.selectedTab = id
    self:Refresh()
    self:Fire('OnSelectChanged', id)
end

function TabView:EnableTab(id)
    self.disabled[id] = nil
    self:Refresh()
end

function TabView:DisableTab(id)
    self.disabled[id] = true
    self:Refresh()
end

function TabView:UpdateTabs()
    for i = 1, self.numTabs do
        local tab = self:GetTab(i)
        tab.disabled = self.disabled[i]
        if i == self.selectedTab or tab.disabled then
            tab:Enable()
            tab:Disable()
        else
            tab:Disable()
            tab:Enable()
        end
        tab:Show()
    end

    for i = self.numTabs + 1, #self.tabs do
        self.tabs[i]:Hide()
    end
end

function TabView:Refresh()
    self:SetScript('OnUpdate', self.OnUpdate)
end

function TabView:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:UpdateTabs()
end

function TabView:GetCurrentTab()
    return self.selectedTab
end
