-- TreeView.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 4/2/2021, 10:13:10 AM
--
---@type ns
local ns = select(2, ...)

local HybridScrollFrame_GetOffset = _G.HybridScrollFrame_GetOffset
local HybridScrollFrame_Update = _G.HybridScrollFrame_Update

---@type TreeStatus
local TreeStatus = ns.Addon:NewClass('TreeStatus')

function TreeStatus:Constructor(tree, depth)
    self.tree = tree
    self.depth = depth
    self.extends = {}
end

function TreeStatus:Iterate(start)
    local index = 0

    local function Iterate(tree, depth)
        if depth > self.depth then
            return
        end
        if not tree.children then
            return
        end

        for _, child in ipairs(tree.children) do
            index = index + 1
            if not start or index >= start then
                coroutine.yield(depth, child)
            end
            if type(child) == 'table' and self.extends[child] then
                Iterate(child, depth + 1)
            end
        end
    end

    return coroutine.wrap(function()
        return Iterate(self.tree, 1)
    end)
end

function TreeStatus:GetCount()
    local function GetCount(tree, depth)
        if not tree then
            return 0
        end
        if self.depth == depth then
            return tree.children and #tree.children or 0
        end

        local count = 0
        if tree.children then
            for _, child in ipairs(tree.children) do
                count = count + 1
                if type(child) == 'table' and self.extends[child] then
                    count = count + GetCount(child, depth + 1)
                end
            end
        end
        return count
    end
    return GetCount(self.tree, 1)
end

---@type TreeView
local TreeView = ns.Addon:NewClass('UI.TreeView', 'ScrollFrame')

---@param itemCreator Object
function TreeView:Constructor(_, itemCreator)
    self.buttons = setmetatable({}, {
        __index = function(t, i)
            local button = itemCreator(self:GetScrollChild())
            t[i] = button
            if i == 1 then
                button:SetPoint('TOPLEFT')
                button:SetPoint('TOPRIGHT')
            else
                button:SetPoint('TOPLEFT', t[i - 1], 'BOTTOMLEFT')
                button:SetPoint('TOPRIGHT', t[i - 1], 'BOTTOMRIGHT')
            end
            return button
        end,
    })

    self.buttonHeight = self.buttons[1]:GetHeight()

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
    self.scrollBar:SetMinMaxValues(0, 1)
    self.scrollBar:SetValue(0)
end

function TreeView:OnSizeChanged()
    self.sizeChanged = true
    self:Refresh()
end

function TreeView:OnUpdate()
    if self.sizeChanged then
        self.sizeChanged = nil
        self:GetScrollChild():SetSize(self:GetSize())
    end
    if not self.buttonHeight then
        self.buttonHeight = self.buttons[1]:GetHeight()
    end
    self:Update()
    self:SetScript('OnUpdate', nil)
end
TreeView.update = TreeView.OnUpdate

function TreeView:Refresh()
    self:SetScript('OnUpdate', self.OnUpdate)
end

---@param treeStatus TreeStatus
function TreeView:SetTreeStatus(treeStatus)
    self.treeStatus = treeStatus
end

function TreeView:Update()
    local offset = HybridScrollFrame_GetOffset(self)
    local buttons = self.buttons
    local treeStatus = self.treeStatus
    if not treeStatus then
        return
    end
    local containerHeight = self:GetHeight()
    local buttonHeight = self.buttonHeight
    local itemCount = treeStatus:GetCount()
    local maxCount = ceil(containerHeight / buttonHeight)
    local buttonCount = min(maxCount, itemCount)

    local iter = treeStatus:Iterate(offset + 1)

    for i = 1, buttonCount do
        local index = i + offset
        local button = buttons[i]
        if index > itemCount then
            button:Hide()
        else
            local depth, item = iter()

            button.depth = depth
            button.item = item
            button.scrollFrame = self
            button:SetID(index)
            button:Show()
            self:Fire('OnItemFormatting', button, depth, item)
        end
    end

    for i = buttonCount + 1, #buttons do
        buttons[i]:Hide()
    end
    HybridScrollFrame_Update(self, itemCount * buttonHeight, containerHeight)
end

function TreeView:ToggleItem(item)
    self.treeStatus.extends[item] = not self.treeStatus.extends[item] or nil
    self:Refresh()
end
