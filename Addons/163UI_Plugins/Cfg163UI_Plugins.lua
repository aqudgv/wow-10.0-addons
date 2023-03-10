U1PLUG = {}
local function load(cfg, v, loading, no_reload, plugin)
    plugin = plugin or cfg.var
    if v and U1PLUG[plugin] then
        U1PLUG[plugin]()
        U1PLUG[plugin] = nil
        if not loading then U1Message("已启用小功能 - "..cfg.text, 0.2, 1.0, 0.2) end
    elseif not v and not no_reload then
        if not loading then U1Message("停用小功能可能需要重载界面", 1.0, 0.2, 0.2) end
    end
end

U1_NEW_ICON = U1_NEW_ICON or '|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t'
U1RegisterAddon("163UI_Plugins", {
    title = "贴心小功能集合",
    defaultEnable = 1,
    load = "NORMAL",
    tags = { "TAG_MANAGEMENT", "TAG_QUEST", },
    icon = "Interface\\ICONS\\INV_Misc_Blizzcon09_GraphicsCard",
    desc = "各种贴心小功能，组合在一起，原来和网易有爱核心在一起，现在独立出来了。",
    nopic = 1,

	{	--	有爱设置
		text = "有爱设置",
		callback = function(cfg, v, loading)
			U1SelectAddon("!!!163UI!!!")
		end
	},
	{	--	额外设置
		text = "额外设置",
		callback = function(cfg, v, loading)
			U1SelectAddon("163UI_Config")
		end
	},

    {
        var = "UnlimitedMapPinDistance", text = U1_NEW_ICON.."导航地图标记无限距离", default = true, callback = load, tip = "说明`9.0新增的游戏内导航，暴雪限制地图标记在1000码-100码之内才显示，可以取消这个限制"
    },

    {           --  典狱长威胁
        var = "MawThreat",
        text = U1_NEW_ICON.."噬渊典狱长之眼详细数值",
        default = true,
        tip = "说明`在噬渊典狱长之眼框体中显示详细进度值",
        callback = function(cfg, v, loading, ...)
            if v then
                _163UIPlugin.Eye_of_the_Jailer[1](loading);
            else
                _163UIPlugin.Eye_of_the_Jailer[2](loading);
            end
        end
    },

    -- {           --  任务助手
    --     var = "AutoGossip",
    --     text = U1_NEW_ICON.."为部分任务提供辅助",
    --     default = false,
    --     callback = function(cfg, v, loading, ...)
    --         if v then
    --             _163UIPlugin.QuestHelper[1](loading);
    --         else
    --             _163UIPlugin.QuestHelper[2](loading);
    --         end
    --     end
    -- },

    {           --  自动对话
        var = "AutoGossip",
        text = U1_NEW_ICON.."与部分NPC互动时，自动选择选项",
        default = true,
        tip = "例如`副本冠军的试炼中的主持人",
        callback = function(cfg, v, loading, ...)
            if v then
                _163UIPlugin.AutoGossip[1](loading);
            else
                _163UIPlugin.AutoGossip[2](loading);
            end
        end
    },

    {           --  姓名板buff
        var = "nameplateBuffDebuff",
        text = U1_NEW_ICON.."隐藏默认姓名板上的所有buff和debuff",
        default = false,
        tip = "切换时最好重载",
        callback = function(cfg, v, loading, ...)
            if v then
                NamePlateDriverFrame:UnregisterEvent("UNIT_AURA");
                NamePlateDriverFrame:UnregisterEvent("PLAYER_TARGET_CHANGED");
            else
                NamePlateDriverFrame:RegisterEvent("UNIT_AURA");
                NamePlateDriverFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
            end
        end
    },

    {           --  易爆球
        var = "explosiveNamePlate",
        default = true,
        text = "使易爆球姓名版更明显",
        callback = function(cfg, v, loading)
            _163UIPlugin.MythicDungeonPlusNamePlate.toggle('explosive', v, loading);
        end,
        {
            var = "scale_width",
            text = "宽度比例",
            default = 1.5,
            type = "spin",
            range = { 0.5, 5.0, 0.1 },
            callback = function(cfg, v, loading)
                _163UIPlugin.MythicDungeonPlusNamePlate.width('explosive', v, loading)
            end,
        },
        {
            var = "scale_height",
            text = "高度比例",
            default = 2.0,
            type = "spin",
            range = { 0.5, 5.0, 0.1 },
            callback = function(cfg, v, loading)
                _163UIPlugin.MythicDungeonPlusNamePlate.height('explosive', v, loading)
            end,
        },
    },
    {           --  怨毒影魔
        var = "spitefulNamePlate",
        default = true,
        text = "使怨毒影魔姓名版更明显",
        callback = function(cfg, v, loading)
            _163UIPlugin.MythicDungeonPlusNamePlate.toggle('spiteful', v, loading);
        end,
        {
            var = "spitefulNamePlateObvious",
            default = true,
            text = "在攻击自己的怨毒影魔姓名板上添加标记",
            callback = function(cfg, v, loading)
                _163UIPlugin.MythicDungeonPlusNamePlate.obvious('spiteful', v, loading);
            end,
        },
        {
            var = "scale_width",
            text = "宽度比例",
            default = 1.5,
            type = "spin",
            range = { 0.5, 5.0, 0.1 },
            callback = function(cfg, v, loading)
                _163UIPlugin.MythicDungeonPlusNamePlate.width('spiteful', v, loading)
            end,
        },
        {
            var = "scale_height",
            text = "高度比例",
            default = 2.0,
            type = "spin",
            range = { 0.5, 5.0, 0.1 },
            callback = function(cfg, v, loading)
                _163UIPlugin.MythicDungeonPlusNamePlate.height('spiteful', v, loading)
            end,
        },
    },
    -- {           --  傲慢具象
    --     var = "MythicDungeonPlusNotifaction_Manifestation_of_Pride",
    --     text = U1_NEW_ICON.."大秘境傲慢具象提醒",
    --     default = true,
    --     tip = "说明`在10层以上的大秘境中，20%，40%，60%，80%进度时候会刷新傲慢具象",
    --     callback = function(cfg, v, loading, ...)
    --         _163UIPlugin.MythicDungeonPlusNotifaction.Manifestation_of_Pride(v, loading);
    --     end
    -- },
    -- {           --  傲慢具象：狂妄吹嘘
    --     var = "MythicDungeonPlusNotifaction_Belligerent_Boast",
    --     text = U1_NEW_ICON.."吹嘘狂妄提醒",
    --     default = true,
    --     tip = "傲慢具象点名技能，4秒后向玩家前后左右四个方向喷射造成巨量伤害",
    --     callback = function(cfg, v, loading, ...)
    --         _163UIPlugin.MythicDungeonPlusNotifaction.Belligerent_Boast(v, loading);
    --     end
    -- },

    {           --  自动拒绝组队
        var = "DeclineInvitation-Group",
        default = false,
        text = "自动拒绝陌生人和屏蔽列表的组队邀请",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.DeclineInvitation.group[1]();
            else
                _163UIPlugin.DeclineInvitation.group[2]();
            end
        end
    },
    {           --  自动拒绝公会
        var = "DeclineInvitation-Group",
        default = false,
        text = "自动拒绝陌生人和屏蔽列表的公会邀请",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.DeclineInvitation.guild[1]();
            else
                _163UIPlugin.DeclineInvitation.guild[2]();
            end
        end
    },
    {           --  好友列表染色
        var = "colorFriend",
        default = true,
        text = "好友列表染色",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.FriendsListColor[1]();
                _163UIPlugin.WhoFrameListColor[1]();
            else
                _163UIPlugin.FriendsListColor[2]();
                _163UIPlugin.WhoFrameListColor[2]();
           end
        end
    },
    {           --  好友列表鼠标提示染色
        var = "enhanceFriendTip",
        default = true,
        text = "增强好友列表鼠标提示",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.FriendsListTipColor[1]();
            else
                _163UIPlugin.FriendsListTipColor[2]();
            end
        end
    },
    {           --  世界任务剩余时间
        var = "wqRemainingTime",
        default = true,
        text = "显示世界任务剩余时间",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.WorldMapQuestTime[1]();
            else
                _163UIPlugin.WorldMapQuestTime[2]();
            end
        end
    },
    {           --  PVEFrame
        var = "PVEFrame",
        default = true,
        text = "增强史诗钥石和PvP界面",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.PVEFrame[1]();
            else
                _163UIPlugin.PVEFrame[2]();
            end
        end
    },
    {           --  RunHistory
        var = "RunHistory",
        default = true,
        text = "在史诗钥石、PvP界面和宝库界面增加本周大秘统计",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.RunHistory[1]();
            else
                _163UIPlugin.RunHistory[2]();
            end
        end
    },
    {           --  施法条
        var = "charmingCastBar",
        default = 0,
        text = "为施法条加点料！",
        tip = "为施法条增加一些额外的小彩蛋\n因魔兽客户端内置材质可能缺失的问题，部分客户端上某些选项无法显示",
        type = "radio",
        options = {
            "无", 0, "有爱", 1, "墨黑", 2, "火焰", 3, "雷光", 4,
        },
        cols = 5,
        callback = function(cfg, v, loading)
            if v ~= 0 then
                _163UIPlugin.CastingFrame.Enable(nil, v);
            else
                _163UIPlugin.CastingFrame.Disable();
            end
        end
    },

    {
        var = "AlwaysShowAltBarText", text = U1_NEW_ICON .. "始终显示特殊能量条的文字", default = true,
        tip = "说明`在大小幻象里，始终显示能量条上面的文字，便于查看。",
    },

    {
        var = "CastSound",
        text = U1_NEW_ICON.."战斗节奏音",
        default = "none",
        tip = "说明`实验功能，在成功释放技能后播放一个音效，说不定有用呢。",
        type = "radio",
        options = {
            "无", "none", "D3", "Ding3.ogg", "D5", "Ding5.ogg", "D7", "Ding7.ogg",
            "D9", "Ding9.ogg", "P3", "Pling4.ogg", "P4", "Pling5.ogg", "P5", "Pling6.ogg",
        },
        cols = 4,
        callback = function(cfg, v, loading)
            if not _G.U1CastSoundFrame then
                _G.U1CastSoundFrame = CreateFrame("Frame")
                ---[[
                local lastSpell
                _G.U1CastSoundFrame:SetScript("OnEvent", function(self, event, ...)
                    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                        local timeStamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId = CombatLogGetCurrentEventInfo()
                        if sourceGUID == UnitGUID("player") and (subevent=="SPELL_CAST_START" or subevent=="SPELL_CAST_SUCCESS") then
                            --print(subevent, spellId, lastSpell, GetSpellLink(spellId), destName)
                        end
                        if sourceGUID == UnitGUID("player") and (subevent=="SPELL_CAST_START" or subevent=="SPELL_CAST_SUCCESS") and lastSpell and (InCombatLockdown() or UnitExists("boss1")) then
                            if lastSpell == spellId then
                                lastSpell = nil
                                PlaySoundFile("Interface\\AddOns\\TellMeWhen\\Sounds\\"..self.sound, "MASTER")
                            end
                        end
                    elseif event == "UNIT_SPELLCAST_SENT" then
                        local unit, target, castid, spell = ...
                        if unit == "player" then
                            lastSpell = spell
                            --print(event, unit, spell)
                            --PlaySoundFile("Interface\\AddOns\\TellMeWhen\\Sounds\\"..self.sound, "MASTER")
                        end
                    end
                end)
            end
            if v ~= "none" then
                _G.U1CastSoundFrame.sound = v
                _G.U1CastSoundFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
                _G.U1CastSoundFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
                if not loading then PlaySoundFile("Interface\\AddOns\\TellMeWhen\\Sounds\\"..v, "MASTER") end
            else
                _G.U1CastSoundFrame:UnregisterEvent("UNIT_SPELLCAST_SENT")
                _G.U1CastSoundFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
    },

    {
        var = "ExaltedPlus", text = U1_NEW_ICON.."声望增强", default = true, callback = load,
        tip = "说明`7.2版本新增功能`声望面板直接显示崇拜后的进度。`获得声望时会显示当前进度。`可以设置自动追踪刚获得的声望。",
        {
            var = "autotrace",
            default = true,
            text = "满级后自动追踪刚提升的声望"
        }
    },

    {
        var = "skipTalkingHead",
        default = false,
        text = U1_NEW_ICON.."完全屏蔽剧情台词窗口",
        confirm = "建议通过双击空格关闭台词窗口，\n完全屏蔽可能会导致剧情不连贯。\n您确定吗?",
        tip = "说明`7.0新增的窗口，如果启用此选项，则完全屏蔽，毫无痕迹。建议不要启用，网易有爱提供了双击空格直接关闭当前台词的功能。",
        callback = function(cfg, v, loading) if U1Toggle_SkipTalkingHead then U1Toggle_SkipTalkingHead(v) end end,
    },

    {
        var = "HideQuickJoin",
        text = "屏蔽快速加入提示",
        default = false,
        tip = "说明`7.1新增的快速加入提示消息，网易有爱贴心提供屏蔽功能。",
        callback = function(cfg, v, loading) U1Toggle_QuickJoinToasts(not v, loading) end,
    },

    {
        text = "显示布局网格",
        tip = "说明`快捷命令/align 20 或 /wangge 30, 默认格子大小是30",
        callback = function(cfg, v, loading) SlashCmdList["EALIGN_UPDATED"]("") end,
    },

    {
        var = "replaceTalent",
        default = true,
        text = "自动替换天赋技能",
        tip = "说明`当同一层天赋是不能并存的主动技能时，更换天赋会用新技能替换动作条上的旧技能，而不是同时存在新旧两个技能",
    },

    {
        var = "garrisonMMB",
        default = true,
        text = "职业大厅小地图按钮",
        tip = "说明`把职业大厅小地图按钮缩小为普通小地图按钮大小，并支持拖动。关闭此功能需要重载界面",
        callback = function(cfg, v, loading)
            if not loading and v then U1_ProcessGarrisonLandingPageMMB() end
            if not loading and not v then U1Message("停用小功能需要重载界面", 1.0, 0.2, 0.2) end
        end
    },

    {           --  宏伟宝库
        var = "WeeklyRewardsMMB",
        default = true,
        text = "宏伟宝库小地图按钮",
        tip = "说明`宏伟宝库是9.0版本的每周宝箱奖励",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.WeeklyRewardsMinimapButton[1]();
            else
                _163UIPlugin.WeeklyRewardsMinimapButton[2]();
            end
        end
    },

    {
        var = "QuestWatchSort", text = U1_NEW_ICON.."任务追踪按距离排序", default = false, callback = load,
        tip = "说明`按任务远近进行排序``暴雪的任务排序功能失效很久了,网易有爱为您临时提供解决方案",
    },

    {
        var = "163UI_Quest", text = "任务奖励信息与半自动交接", default = true, callback = load,
        tip = "说明`●选择奖励时显示卖店价格`●选择奖励时显示物品类型`●显示'自动选择最贵'按钮`●显示直接接受和完成按钮",
    },

    {
        var = "AlreadyKnown", text = "已学配方染色", default = true, callback = load,
        tip = "说明`在商人和拍卖行界面中将已学配方染色显示。",
    },

    {
        var = "CopyFriendList", text = "好友复制功能", default = true, callback = load,
        tip = "说明`点击好友列表（O键面板）左上角可以弹出好友复制功能菜单，可以复制同账号下其他角色的游戏内好友列表。",
    },

    {
        var = "FriendsGuildTab", text = "好友/公会切换按钮", default = true, callback = load,
        tip = "说明`在好友面板和公会面板右下角添加切换到另一个面板的标签页。",
    },

    {
        var = "GuildRosterButtons", text = "公会名单切换按钮", default = true, callback = load,
        tip = "说明`在公会名单面板上显示一组按钮，用来切换'玩家状态','专业'等，比默认的下拉菜单方式要方便一些。",
    },

    {
        var = "FixBlizGuild", text = U1_NEW_ICON.."延迟加载公会新闻", default = true, callback = load,
        tip = "说明`打开公会面板时不加载公会新闻，可能会减少初次打开公会卡死的问题。",
    },

    {
        var = "MerchantFilterButtons", text = "商人面板过滤按钮", default = true, callback = load,
        tip = "说明`在NPC商人购买面板上方，显示'职业、专精、是否装备绑定'等过滤按钮，替代系统的下拉菜单方式。",
    },

    {
        var = "OpenBags", text = "开启银行时打开全部背包", default = true, callback = load,
    },

    {
        var = 'PingPing', text = '显示小地图点击者名字', default = true,
        callback = function(_, v, loading)
            if(not loading) then
                local addon = LibStub('AceAddon-3.0'):GetAddon('163PingPing')
                if(addon) then
                    if(v) then
                        addon:Enable()
                    else
                        addon:Disable()
                    end
                end
            end
        end,
    },

    {
        var = "ProfessionTabs", text = "专业技能面板标签", default = true, callback = load,
        tip = "说明`在专业制造面板右侧显示各个专业的切换按钮。",
    },

    {
        var = 'bfautorelease',
        default = false,
        text = '战场中自动释放灵魂',
    },

    {
        var = 'map_raid_color',
        default = true,
        text = '地图队友图标颜色',
        tip = "说明`大地图和小地图上的队友圆点显示为起职业颜色",
        reload = 1,
        callback = function(cfg, v, loading)
            local mod = U1PLUGIN_ColorRostersOnMap
            if(mod and mod.Init) then
                return mod:Init()
            end
        end,
    },

    {
        var = "AutoSwapRacial", text = "自动替换种族天赋", default = false,
        tip = "说明`（测试功能）在达萨罗之战剧情更换种族时，自动替换动作栏上的主动种族天赋。",
    },

    {
        var = "SlashCommands", text = "快捷命令", default = true, callback = load,
        tip = "说明`增加若干命令行指令`● /tele 传入传出随机副本`● /in 秒数 其他命令`　　延迟N秒后执行其他命令`　　例如/in 1 /yell 开怪啦",
    },

    {
        var = "ExtraActionButton", text = "自定义的额外动作按钮", default = false, callback = function(cfg, v, loading)
            CoreLeaveCombatCall(cfg._path, "战斗中无法显示或隐藏。", function()
                if U1PLUG["ExtraActionButton"] then load(cfg, v, loading, true) end
                if U1ExtraAction1 ~= nil then
                    U1ExtraAction1:SetShown(v)
                end
            end)
        end,
        tip = "说明`某些场景下会出现一个单独的动作按钮，有时此按钮会因为某些原因导致看不到，为不影响玩家游戏，尤其是BOSS战斗，可以打开此选项，使用一个自定义的替代按钮。",
    },

    {
        var = "FiveCombo", text = U1_NEW_ICON.."满星时动作条技能高亮", default = true, callback = load,
        visible = (U1PlayerClass == "ROGUE" or U1PlayerClass == "DRUID"),
        tip = "说明`潜行者和德鲁伊有效，满星的时候动作条技能闪烁，此功能来自多玩盒子哥",
    },

--[=[
    {
        var = 'print_huangli_onload',
        default = 1,
        text = '每天第一次登陆时显示老黄历',
    },
]=]

})

--U1RegisterAddon("GrievousHelper", { title = "重伤助手(自动摘武器)", defaultEnable = 1, parent = "163UI_Plugins", })

