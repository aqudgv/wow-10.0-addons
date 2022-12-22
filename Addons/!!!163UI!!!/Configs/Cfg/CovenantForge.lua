U1RegisterAddon("CovenantForge", {
    title = "导灵器特质评分",
    defaultEnable = 0,
    load = "LATER",
    tags = { "TAG_EQUIPMENT", },
    icon = 1869493,
    {
        text = "选项配置",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("CovenantForge")
        end
    },
})