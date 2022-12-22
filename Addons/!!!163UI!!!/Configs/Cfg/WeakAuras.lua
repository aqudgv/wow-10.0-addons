U1RegisterAddon("WeakAuras", {
    title = "WeakAuras2 (WA)",
    defaultEnable = 0,
    load = "NORMAL",

    tags = { "TAG_SPELL", },
    icon = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\icon.blp",
    desc = "简单又强大的状态监控模块WA，和TellMeWhen任选一个喜欢的就好，https://wago.io/weakauras 有一些字符串可以导入",

    -- reload = true,

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList.WEAKAURAS("") end,
    },
});

U1RegisterAddon("WeakAurasModelPaths", { parent = "WeakAuras", title = "WeakAuras：材质路径库", protected = nil, hide = nil });
U1RegisterAddon("WeakAurasOptions", { parent = "WeakAuras", title = "WeakAuras：配置界面", protected = nil, hide = nil });
U1RegisterAddon("WeakAurasTemplates", { parent = "WeakAuras", title = "WeakAuras：预设模板", protected = nil, hide = nil });
U1RegisterAddon("WeakAurasArchive", { parent = "WeakAuras", title = "WeakAuras：档案库", protected = nil, hide = nil });
