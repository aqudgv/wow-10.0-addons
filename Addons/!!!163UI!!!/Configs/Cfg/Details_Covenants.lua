U1RegisterAddon("Details_Covenants", {
    title = "Details/Skada盟约图标",
    tags = { "TAG_COMBATINFO", },
    defaultEnable = 0,
    load = "NORMAL",
    -- hide = 1,
    protected = 1,

    desc = "为Details!和Skada的统计列表上增添盟约图标。",

    {
        text = '在聊天框显示获取到的盟约信息',
        var = "DCovenantLog",
        default = false,
		callback = function(cfg, v, loading)
            DCovenantLog = not not v;
		end,
    },
});

