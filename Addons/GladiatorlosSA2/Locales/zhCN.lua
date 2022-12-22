﻿-- Mini Dragon(projecteurs@gmail.com)
-- Last update: Jan 25, 2022

local L = LibStub("AceLocale-3.0"):NewLocale("GladiatorlosSA", "zhCN")
if not L then return end

L["Spell_CastSuccess"] = "施法成功"
L["Spell_CastStart"] = "施法开始"
L["Spell_AuraApplied"] = "获得增益/减益"
L["Spell_AuraRemoved"] = "增益/减益消失"
L["Spell_Interrupt"] = "打断法术"
L["Spell_Summon"] = "召唤法术"
L["Any"] = "任意"
L["Player"] = "玩家"
L["Target"] = "目标"
L["Focus"] = "焦点"
L["Mouseover"] = "鼠标指向"
L["Party"] = "队伍"
L["Raid"] = "团队"
L["Arena"] = "竞技场敌方"
L["Boss"] = "副本首领"
L["Custom"] = "自定义"
L["Friendly"] = "友好"
L["Hostile player"] = "敌对玩家"
L["Hostile unit"] = "敌对单位"
L["Neutral"] = "中立"
L["Myself"] = "玩家自己"
L["Mine"] = "自己或自己的单位"
L["My pet"] = "自己的宠物"
L["Custom Spell"] = "自定义法术"
L["New Sound Alert"] = "新的警报声音"
L["name"] = "名字"
L["same name already exists"] = "已存在的同名警报"
L["spellid"] = "技能ID"
L["Remove"] = "移除"
L["Are you sure?"] = "确认移除？"
L["Test"] = "测试"
L["Use existing sound"] = "使用现存声音"
L["choose a sound"] = "选择一个声音"
L["file path"] = "文件路径"
L["event type"] = "事件类型"
L["Source unit"] = "来源单位"
L["Source type"] = "来源类型"
L["Custom unit name"] = "自定义单位名称"
L["Dest unit"] = "目标单位"
L["Dest type"] = "目标类型"

L["GladiatorlosSACredits"] = "可定制的PVP语音预警插件，用于敌人施放的许多重要技能预警.|n|n|cffFFF569Created by|r |cff9482C9Abatorlos|r |cffFFF569of Spinebreaker|r|n|cffFFF569Legion/BfA/Shadowlands support by|r |cFF00FF96Treasuretail|r |cffFFF569of Wyrmrest Accord (With permission from zuhligan)|r|n|n|cffFFF569特别感谢|r|n|cffA330C9superk521|r (Past Project Manager)|n|cffA330C9DuskAshes|r (Chinese Support)|n|cffA330C9N30Ex|r (Mists of Pandaria Support; Shadowlands voice recordings)|n|cffA330C9zuhligan|r (Warlords of Draenor & French Support)|n|cffA330C9jungwan2|r (Korean Support)|n|cffA330C9Mini_Dragon|r (Chinese support for WoD & Legion)|n|cffA330C9LordKuper|r (Russian support for Legion)|n|cffA330C9Tzanee - Wyrmrest Accord|r (Placeholder Voice Lines)|n|cffA330C9Gnulkion - Illidan|r (Alert only from opponent in duels feature)|n|n所有反馈、问题、建议和错误报告欢迎访问 Curse的插件网站:|nhttps://wow.curseforge.com/projects/gladiatorlossa2|n或 GitHub 网站:|nhttps://github.com/Rhykes/GladiatorlosSA2"
L["PVP Voice Alert"] = "PVP技能语音提示"
L["Load Configuration"] = "<-- 加载 GSA2 配置"
L["Load Configuration Options"] = "加载配置选项"
L["General"] = "一般"
L["General options"] = "一般选项"
L["Enable area"] = "当何时启用"
L["Anywhere"] = "总是启用"
L["Alert works anywhere"] = "在任何地方都处于启用状态"
L["Arena"] = "竞技场"
L["Alert only works in arena"] = "在竞技场中启用"
L["Battleground"] = "战场"
L["Alert only works in BG"] = "在战场中启用"
L["World"] = "野外"
L["Alert works anywhere else then anena, BG, dungeon instance"] = "除了战场、竞技场和副本的任务地方都启用"
L["Voice config"] = "声音设置"
L["Voice language"] = "语言类型"
L["Select language of the alert"] = "选择通报所用语言"
L["Chinese(Yike Xia)"] = "夏一可"
L["Chinese(female)"] = "中文（女）"
L["English(female)"] = "英语（女）"
L["adjusting the voice volume(the same as adjusting the system master sound volume)"] = "调节声音大小（等同于调节系统主音量大小）"
L["Advance options"] = "高级设置"
L["Smart disable"] = "智能禁用模式"
L["Disable addon for a moment while too many alerts comes"] = "处于大型战场等警报过于频繁的区域自动禁用"
L["Throttle"] = "节流阀"
L["The minimum interval of each alert"] = "控制声音警报的最小间隔"
L["Abilities"] = "技能"
L["Abilities options"] = "技能选项"
L["Disable options"] = "技能模块"
L["Disable abilities by type"] = "技能各个模块禁用选项"
L["Disable Buff Applied"] = "禁用敌方增益技能"
L["Check this will disable alert for buff applied to hostile targets"] = "勾选此选项以关闭敌方增益技能通报"
L["Disable Buff Down"] = "禁用敌方增益结束"
L["Check this will disable alert for buff removed from hostile targets"] = "勾选此选项以关闭敌方增益结束通报"
L["Disable Spell Casting"] = "禁用敌方读条技能"
L["Chech this will disable alert for spell being casted to friendly targets"] = "勾选此选项以关闭敌方读条技能通报"
L["Disable special abilities"] = "禁用敌方特殊技能"
L["Check this will disable alert for instant-cast important abilities"] = "勾选此选项以关闭敌方特殊技能通报"
L["Disable friendly interrupt"] = "禁用友方打断技能"
L["Check this will disable alert for successfully-landed friendly interrupting abilities"] = "勾选此选项以关闭敌方打断技能成功的通报"
L["Buff Applied"] = "敌方增益技能"
L["Target and Focus Only"] = "仅目标或焦点"
L["Alert works only when your current target or focus gains the buff effect or use the ability"] = "仅当该技能是你的目标或焦点使用或增益出现在你的目标或焦点身上才语音通报"
L["Alert Drinking"] = "通报正在进食"
L["In arena, alert when enemy is drinking"] = "在竞技场中通报敌方玩家正在进食"
L["PvP Trinketed Class"] = "徽章职业提示"
L["Also announce class name with trinket alert when hostile targets use PvP trinket in arena"] = "在竞技场中,通报徽章的同时提示使用徽章的职业"
L["General Abilities"] = "通用技能"
L["Druid"] = "|cffFF7D0A德鲁伊|r"
L["Paladin"] = "|cffF58CBA圣骑士|r"
L["Rogue"] = "|cffFFF569潜行者|r"
L["Warrior"] = "|cffC79C6E战士|r"
L["Priest"] = "|cffFFFFFF牧师|r"
L["Shaman"] = "|cff0070DE萨满|r"
L["ShamanTotems"] = "|cff0070DE萨满图腾|r"
L["Mage"] = "|cff69CCF0法师|r"
L["DeathKnight"] = "|cffC41F3B死亡骑士|r"
L["Hunter"] = "|cffABD473猎人|r"
L["Monk"] = "|cFF558A84武僧|r"
L["Evoker"] = true
L["DemonHunter"] = "|cffA330C9恶魔猎手|r"
L["Warlock"] = "|cff9482C9术士|r"

L["Buff Down"] = "敌方增益结束"
L["Spell Casting"] = "敌方读条技能"
L["BigHeal"] = "大型治疗法术"
L["BigHeal_Desc"] = "强效治疗术 神圣之光 强效治疗波 治疗之触"
L["Resurrection"] = "复活技能"
L["Resurrection_Desc"] = "复活术 救赎 先祖之魂 复活"
L["Special Abilities"] = "敌方特殊技能"
L["Friendly Interrupt"] = "友方打断技能"
L["Profiles"] = "配置文件"

--L["PvPWorldQuests"] = "PVP世界任务"
--L["DisablePvPWorldQuests"] = "禁用PVP世界任务"
--L["DisablePvPWorldQuestsDesc"] = "禁用PVP世界任务中的所有警报"
--L["OperationMurlocFreedom"] = true

L["EnemyInterrupts"] = "打断技能(还有日光术，因为他能打断和沉默!)"
L["EnemyInterruptsDesc"] = "启用或禁用所有敌人打断和沉默技能的警报。"

L["Default / Female voice"] = "默认 / 女声"
L["Select the default voice pack of the alert"] = "选择默认语音包"
L["Optional / Male voice"] = "可选 / 男声"
L["Select the male voice"] = "选择男性语音包"
L["Optional / Neutral voice"] = "可选 / 中立"
L["Select the neutral voice"] = "选择中性语音包"
L["Gender detection"] = "性别判断"
L["Activate the gender detection"] = "开启性别判断"
L["Voice menu config"] = "语音菜单选项"
L["Choose a test voice pack"] = "选择测试语音包"
L["Select the menu voice pack alert"] = "选择菜单语音包警告"

L["English(male)"] = "英语（男）"
L["No sound selected for the Custom alert : |cffC41F4B"] = "没有为自定义警报选择声音 : |cffC41F4B"
L["Master Volume"] = "主音量" 
L["Change Output"] = "改变声音输出通道"
L["Unlock the output options"] = "解锁声音输出选项"
L["Output"] = "输出"
L["Select the default output"] = "选择默认输出"
L["Master"] = "主"
L["SFX"] = "特效"
L["Ambience"] = "环境"
L["Music"] = "音乐"
L["Dialog"] = "对话"

L["DPSDispel"] = "非魔法类驱散"
L["DPSDispel_Desc"] = "不是移除魔法效果的混合职业驱散警报。|n|n清除腐蚀 (|cffFF7D0A德鲁伊|r)|n解除诅咒 (|cff69CCF0法师|r)|n清创生血 (|cFF558A84武僧|r)|n清毒术 (|cffF58CBA圣骑士|r)|n净化疾病 (|cffFFFFFF牧师|r)|n净化灵魂 (|cff0070DE萨满图腾|r)"
L["HealerDispel"] = "魔法驱散"
L["HealerDispel_Desc"] = "治疗职业(和|cff9482C9术士|r)的通用驱散技能警报，驱散魔法效果。|n|n自然之愈 (|cffFF7D0A德鲁伊|r)|n还魂术 (|cFF558A84武僧|r)|n清洁术 (|cffF58CBA圣骑士|r)|n纯净术 (|cffFFFFFF牧师|r)|n净化灵魂 (|cff0070DE萨满|r)|n烧灼驱魔 (|cff9482C9术士|r)"
L["CastingSuccess"] = "控制技能"
L["CastingSuccess_Desc"] = "当敌对玩家施放群体控制技能于你或队友/盟友时，启用通用“成功”警报|n|n|cffC41F3B警告: 如果启用，以下所有技能都将警报，即使你有其中一些技能 |r|n|n旋风 (|cffFF7D0A德鲁伊|r)|n纠缠根须 (|cffFF7D0A德鲁伊|r)|n沉眠 (|cffFF7D0A德鲁伊|r)|n恐吓野兽 (|cffABD473猎人|r)|n变形术 (|cff69CCF0法师|r)|n冰霜之环 (|cff69CCF0法师|r)|n忏悔 (|cffF58CBA圣骑士|r)|n精神控制 (|cffFFFFFF牧师|r)|n妖术 (|cff0070DE萨满|r)|n恐惧 (|cff9482C9术士|r)"

L["DispelKickback"] = "驱散后惩罚"

L["Purge"] = "清除技能"
L["PurgeDesc"] = "清除团队魔法效果的一般警报，不包括奥术洪流|n|n吞噬魔法 (|cffA330C9恶魔猎手|r)|n宁神射击 (|cffABD473猎人|r)|n群体驱散 (|cffFFFFFF牧师|r)|n净化 (|cff0070DE萨满|r)|n吞噬魔法 (|cff9482C9术士|r)"

L["FriendlyInterrupted"] = "禁用友方被打断技能"
L["FriendlyInterruptedDesc"] = "当敌人成功打断你或队友/盟友技能，禁用警报。|n|n(播放暴雪“任务失败”音效)"

L["epicbattleground"] = "史诗战场"
L["epicbattlegroundDesc"] = "在史诗战场警报。|n|n别客气。"

--L["OnlyIfPvPFlagged"] = "仅在PVP中"
--L["OnlyIfPvPFlaggedDesc"] = "If enabled, alerts will no longer play unless you are PvP flagged; such as in War Mode or in a PvP instance. Those areas still need to be enabled for GSA to function there, even if this option is enabled.|n|n|cffC41F3BWARNING: This also disables alerts while in a Duel, so remember to toggle it off!|r"

--L["TankTauntsOFF"] = "Intimidation"
--L["TankTauntsOFF_Desc"] = "Alerts the fading of Intimidation: a damage amplification effect originating from tank specializations."
--L["TankTauntsON"] = "Intimidation"
--L["TankTauntsON_Desc"] = "Alerts the application of Intimidation: a damage amplifcation effect originating from tank specializations."

L["Connected"] = "标志技能"
L["Connected_Desc"] = "当某些非常强大的技能成功完成施法时，会发出简单的“已连接”警报。|n|n恶魔追击（恶魔猎手）|n强效炎爆术（法师）|n控心术（牧师）|n混乱之箭（术士） "

L["CovenantAbilities"] = "盟约技能"

L["FrostDK"] = "冰霜"
L["BloodDK"] = "鲜血"
L["UnholyDK"] = "邪恶"

L["HavocDH"] = "浩劫"
L["VengeanceDH"] = "复仇"

L["FeralDR"] = "野德"
L["BalanceDR"] = "平衡"
L["RestorationDR"] = "恢复"
L["GuardianDR"] = "守护"

L["MarksmanshipHN"] = "射击"
L["SurvivalHN"] = "生存"
L["BeastMasteryHN"] = "兽王"

L["FrostMG"] = "寒冰"
L["FireMG"] = "火焰"
L["ArcaneMG"] = "奥术"

L["MistweaverMN"] = "织雾"
L["WindwalkerMN"] = "踏风"
L["BrewmasterMN"] = "酒仙"

L["HolyPD"] = "神圣"
L["RetributionPD"] = "惩戒"
L["ProtectionPD"] = "防护"

L["HolyPR"] = "神圣"
L["DisciplinePR"] = "戒律"
L["ShadowPR"] = "暗影"

L["OutlawRG"] = "狂徒"
L["AssassinationRG"] = "奇袭"
L["SubtletyRG"] = "敏锐"

L["RestorationSH"] = "恢复"
L["EnhancementSH"] = "增强"
L["ElementalSH"] = "元素"

L["DestructionWL"] = "毁灭"
L["DemonologyWL"] = "恶魔"
L["AfflictionWL"] = "痛苦"

L["ArmsWR"] = "武器"
L["FuryWR"] = "狂暴"
L["ProtectionWR"] = "防御"

L["EXPAC_UnknownExpac"] = "未知/不支持的游戏版本."
L["EXPAC_Classic"] = "经典"
L["EXPAC_TBC"] = "燃烧的远征"
L["EXPAC_WotLK"] = "巫妖王之怒"
L["EXPAC_Cata"] = "大地的裂变"
L["EXPAC_MoP"] = "熊猫人之谜"
L["EXPAC_WoD"] = "德拉诺之王"
L["EXPAC_Legion"] = "军团再临"
L["EXPAC_BfA"] = "争霸艾泽拉斯"
L["EXPAC_SL"] = "暗影国度"


L["GladiatorlosSA2"] = true

L["GSA_EXPERIMENTAL_BUILD"] = "这是 GladiatorlosSA2 的测试版本，尚未在 TBC 上进行测试。 尽管我相信一切正常，但如果您遇到问题，请联系我们，并在必要时降级到 GSA2_TBC1.1版本.该消息将不再显示。" 
