U1RegisterAddon("Details", {
    title = "Details伤害统计",
    tags = { "TAG_COMBATINFO", },
    defaultEnable = 0,
    load = "NORMAL", --5.0 script ran too long

    minimap = 'LibDBIcon10_Details', 
    icon = [[Interface\AddOns\Details\images\minimap]],
    desc = "最详细的伤害统计插件，可以用来统计DPS、治疗量、打断、驱散、承受伤害等，方便分析输出循环、PvP。支持图形化显示、信息广播等功能。",

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList.DETAILS("选项") end,
    },
    {
        type = "button",
        text = "打开设置界面",
        callback = function() InterfaceOptionsFrame_OpenToCategory("Details") end,
    }
});

U1RegisterAddon("Details_Streamer", {
    title = "Details Streamer模块",
    defaultEnable = 0,
    ignoreLoadAll = 1,
    desc = "Details直播技能提示。",
});
