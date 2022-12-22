U1RegisterAddon("ZerethMortisPuzzleHelper", {
    title = "源锁解密助手",
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
            SlashCmdList["zmph"]("");
        end
    },
});
