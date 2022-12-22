--	by oyg123 @ https://ngabbs.com/read.php?tid=27466594

local temp = {  }
local pre = C_TaskQuest.GetQuestsForPlayerByMapID
C_TaskQuest.GetQuestsForPlayerByMapID = function(mapID)
	if not temp[mapID] or temp[mapID].lasttime < GetTime() then
		temp[mapID] = temp[mapID] or {}
		temp[mapID].result = pre(mapID)
		temp[mapID].lasttime = GetTime() + 1
	end
	return temp[mapID].result
end
