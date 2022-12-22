local _, ns = ...

local locale = GetLocale()
local L = setmetatable({}, { __index = function(self, k) return "[" .. locale .. "] " .. k end })
ns.L = L

if GetLocale() == 'zhCN' or GetLocale() == 'zhTW' then
L.UNDRESS = "脱光"
L.UNDRESS_SHORT = "脱光"
L.INSPECT = "观察"
L.INSPECT_SHORT = "观察"
L.TARGET = "目标"
L.TARGET_SHORT = "目标"
L.PLAYER = "自己"
L.PLAYER_SHORT = "自己"
L.CUSTOM = "设置"
L.CUSTOM_SHORT = "设置"
else
-- enGB/enUS
L.UNDRESS = "Undress"
L.UNDRESS_SHORT = "Und"
L.INSPECT = "Inspect"
L.INSPECT_SHORT = "Ins"
L.TARGET = "Target"
L.TARGET_SHORT = "Tar"
L.PLAYER = "Player"
L.PLAYER_SHORT = "Plr"
L.CUSTOM = "Custom"
L.CUSTOM_SHORT = "Cus"
end