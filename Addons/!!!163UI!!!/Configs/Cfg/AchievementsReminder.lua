U1RegisterAddon("AchievementsReminder", {
    title = "副本成就提示",
    defaultEnable = 0,
    load = "NORMAL",

    toggle = function(name, info, enabled, justload)
        return true
    end,

    tags = { "TAG_COLLECT", },
    icon = [[Interface\Icons\Achievement_Quests_Completed_Daily_07]],
    nopic = true,
});