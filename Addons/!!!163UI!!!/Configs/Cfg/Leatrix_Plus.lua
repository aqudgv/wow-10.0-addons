U1RegisterAddon("Leatrix_Plus", {
    title = "功能百宝箱",
    defaultEnable = 1,
    secure = 1,
    
    tags = { "TAG_MANAGEMENT", },
    icon = [[Interface\Icons\INV_Misc_Map03]],
    desc = "哆啦A梦的百宝袋。配置命令：/Leatrix_Plus、/ltp、/leaplus",

    -------- Options --------
    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList.Leatrix_Plus("") end,
    },

  --  {
  --      text = "重置所有控制台设定",
  --      callback = function(cfg, v, loading)
  --          MapsterDB = nil; ReloadUI();
  --          NPCMarkMappingDB = nil; ReloadUI();
  --          NPCMarkDB = nil; ReloadUI();
  --          MapMarkHide = nil; ReloadUI();
   --     end,
  --  },
});
