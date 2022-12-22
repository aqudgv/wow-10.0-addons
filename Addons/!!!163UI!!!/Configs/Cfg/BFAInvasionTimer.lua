U1RegisterAddon("BFAInvasionTimer", {
    title = "阵营突袭计时",
    defaultEnable = 0,

    tags = { "TAG_PVP", },
    icon = [[Interface/Icons/Achievement_PVP_A_H]],
    desc = "阵营突袭计时插件。",
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList["BFAInvasionTimer"]("") end
    },

});
