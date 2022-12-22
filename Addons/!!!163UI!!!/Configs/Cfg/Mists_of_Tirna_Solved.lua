U1RegisterAddon("Mists_of_Tirna_Solved", {
    title = "塞兹仙林迷宫助手",
    defaultEnable = 1,

    toggle = function(name, info, enable, justload)
    end,

    runBeforeLoad = function(info, name)
    end,

    tags = { "TAG_COMBATINFO", },
    nopic = true,

    {
        text = "打开界面",
        callback = function(cfg, v, loading)
            SlashCmdList["mots"]("");
        end
    },
});
