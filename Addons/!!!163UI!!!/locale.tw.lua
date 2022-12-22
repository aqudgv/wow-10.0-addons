local L = select(2, ...).L

if not L.zhTW then return end

L["TAG_RAID"] = "團隊副本"
L["TAG_DESC_RAID"] = "此分類包含與小隊及團隊副本相關的戰鬥及輔助插件，包括團隊框架、首領報警、團隊統計等、副本攻略等功能。"
-- L["TAG_BIG"] = "大型插件"
-- L["TAG_DESC_BIG"] = "此分類下是網易有愛整合包中記憶體佔用相對較高、模組數量較多的大型插件，而且關閉後一般不影響正常的遊戲習慣，如果希望節省記憶體可以全部停用。"
L["TAG_TRADING"] = "商業交易"
L["TAG_DESC_TRADING"] = "此分類包含拍賣、交易、郵件、專業技能相關的插件，總之是一切可以賺錢的東東。主要包括郵件增強、交易助手、拍賣助手、自動修理等功能。"
L["TAG_INTERFACE"] = "介面增強"
L["TAG_DESC_INTERFACE"] = "此分類下的插件都是對系統預設介面進行強化，但又不屬於戰鬥類型和商業類型。主要包括暴雪面板移動、滑鼠提示增強、頭像增強等功能。"
L["TAG_CHAT"] = "聊天交流"
L["TAG_DESC_CHAT"] = "此分類下包含與聊天文字和聊天框體相關的插件，主要包括聊天條、聊天框增強、聊天歷史等功能。"
L["TAG_PVP"] = "PVP相關"
L["TAG_DESC_PVP"] = "此分類下是與競技場或戰場相關的PVP類插件，主要包括競技場頭像和PVP技能語音提示。"
L["TAG_COMBATINFO"] = "戰鬥介面"
L["TAG_DESC_COMBATINFO"] = "此分類下包含與戰鬥有關的介面增強型插件，提供戰鬥時所需關注的資訊。"
-- L["TAG_MAPQUEST"] = "地圖任務"
-- L["TAG_DESC_MAPQUEST"] = "此分類下包含與任務、地圖資訊、聲望等有關的插件，偏重於和物品無關的任務資訊和地圖資訊，主要包括地圖增強、副本掉落、NPC標記等功能。"
L["TAG_QUEST"] = "任务必备"
L["TAG_DESC_QUEST"] = "此分类下包含与任务有关的插件。"
L["TAG_MAP"] = "地图相关"
L["TAG_DESC_MAP"] = "此分类下包含与地图信息有关的插件，主要包括地图增强、副本掉落、NPC标记等功能。"
L["TAG_SPELL"] = "技能监控"
L["TAG_DESC_SPELL"] = "与技能监控有关的插件"
L["TAG_UNITFRAME"] = "头像姓名版"
L["TAG_DESC_UNITFRAME"] = "与头像和姓名版有关的插件"
L["TAG_ACTIONBUTTONCASTBAR"] = "动作条施法条"
L["TAG_DESC_ACTIONBUTTONCASTBAR"] = "与动作条和施法条有关的插件"
L["TAG_EQUIPMENT"] = "装备属性"
L["TAG_DESC_EQUIPMENT"] = "与装备属性有关的插件"
L["TAG_COLLECT"] = "成就收藏"
L["TAG_DESC_COLLECT"] = "与成就收藏有关的插件"
-- L["TAG_GARRISON"] = "要塞管理"
-- L["TAG_DESC_GARRISON"] = "與要塞有關的插件"
L["TAG_MANAGEMENT"] = "介面管理"
L["TAG_DESC_MANAGEMENT"] = "此分類是用來'管理插件的插件'，主要是一些比較高階的錯誤資訊及資料統計等，網易有愛控制台就在此分類中，此外還有錯誤提示增強、錯誤消息屏蔽等功能。"
L["TAG_ITEM"] = "物品裝備"
L["TAG_DESC_ITEM"] = "此分類與物品和裝備相關的插件，裝備對於魔獸來說是非常重要的內容，此分類下插件數量也較多，包括整合背包、物品掉落、一鍵換裝、裝備屬性等功能。"
-- L["TAG_GOOD"] = "精新推薦"
-- L["TAG_DESC_GOOD"] = "此分類是用來顯示最新最酷的插件，一般是剛增加的新插件，或是有重要新功能的。每隔一段時間會更新其內容，常過來看看吧。"
L["TAG_CLASS"] = "職業專用"
L["TAG_DESC_CLASS"] = "此分類是與各個職業相關的特殊插件，玩家只能看到與本職業相關的插件，防止載入根本無用的內容浪費記憶體。"
L["TAG_SINGLE"] = "單體插件"
L["TAG_DESC_SINGLE"] = "單體插件是非有愛整合包中的插件，如果用戶自行下載了整合包收錄的插件的單體版，也會列在此分類中。"
-- L["TAG_UNIQUE"] = "有愛獨家"
-- L["TAG_NEW"] = "最新發佈"
-- L["TAG_DATA"] = "資料資料庫"
-- L["TAG_DEV"] = "DevTools"
-- L["TAG_BETA"] = "Beta測試"

U1HUNTER="獵人";
U1WARLOCK="術士";
U1PRIEST="牧師";
U1PALADIN="聖騎";
U1MAGE="法師";
U1ROGUE="盜賊";
U1DRUID="德魯伊";
U1SHAMAN="薩滿";
U1WARRIOR="戰士";
U1DEATHKNIGHT="死騎";
U1MONK="武僧";
U1DEMONHUNTER="獵手"

-- U1TALENT_HUNTER1="野獸控制";
-- U1TALENT_HUNTER2="射擊";
-- U1TALENT_HUNTER3="生存";
-- U1TALENT_WARLOCK1="痛苦";
-- U1TALENT_WARLOCK2="惡魔學識";
-- U1TALENT_WARLOCK3="毀滅";
-- U1TALENT_PRIEST1="戒律";
-- U1TALENT_PRIEST2="神聖";
-- U1TALENT_PRIEST3="暗影";
-- U1TALENT_PALADIN1="神聖";
-- U1TALENT_PALADIN2="防護";
-- U1TALENT_PALADIN3="懲戒";
-- U1TALENT_MAGE1="秘法";
-- U1TALENT_MAGE2="火焰";
-- U1TALENT_MAGE3="冰霜";
-- U1TALENT_ROGUE1="刺殺";
-- U1TALENT_ROGUE2="戰鬥";
-- U1TALENT_ROGUE3="敏銳";
-- U1TALENT_DRUID1="平衡";
-- U1TALENT_DRUID2="野性戰鬥";
-- U1TALENT_DRUID3="恢復";
-- U1TALENT_SHAMAN1="元素";
-- U1TALENT_SHAMAN2="增強";
-- U1TALENT_SHAMAN3="恢復";
-- U1TALENT_WARRIOR1="武器";
-- U1TALENT_WARRIOR2="狂怒";
-- U1TALENT_WARRIOR3="防護";
-- U1TALENT_DEATHKNIGHT1="血魄";
-- U1TALENT_DEATHKNIGHT2="冰霜";
-- U1TALENT_DEATHKNIGHT3="穢邪";
-- U1TALENT_MONK1="釀酒";
-- U1TALENT_MONK2="織霧";
-- U1TALENT_MONK3="御風";

U1REASON_INCOMPATIBLE = "不相容"
U1REASON_DISABLED = "未啟用"
U1REASON_INTERFACE_VERSION = "版本過期"
U1REASON_DEP_DISABLED = "依賴模組未啟用"
U1REASON_DEP_CORRUPT = "依賴模組無法載入"
U1REASON_SHORT_DEP_CORRUPT = "依賴失敗"
U1REASON_SHORT_DEP_DISABLED = "依賴未啟用"
U1REASON_DEP_INTERFACE_VERSION = "依賴模組版本過期"
U1REASON_SHORT_DEP_INTERFACE_VERSION = "依賴過期"
U1REASON_DEP_MISSING = "依賴模組未安裝"
U1REASON_SHORT_DEP_MISSING = "依賴未安裝"
U1REASON_DEP_NOT_DEMAND_LOADED = "依賴模組無法按需載入"
U1REASON_SHORT_DEP_NOT_DEMAND_LOADED = "依賴非按需"


--[[    ]] -- File: 163UI.lua

--[[ 142]] L["强制加载"] = "強制載入"
--[[ 142]] L["说明`本插件会在满足条件时自动加载，如果现在就要加载请点击此按钮` `|cffff0000注意：有可能会出错|r"] = "說明`本插件會在滿足條件時自動載入，如果現在就要載入請點擊此按鈕` `|cffff0000注意：有可能會出錯|r"
--[[ 164]] L["网易有爱插件集"] = "網易有愛插件集"
--[[ 165]] L["此项功能为一系列功能相关的小插件组合，可以分别开启或关闭，为您提供最清晰的分类和最强大的灵活性。"] = "此項功能為一系列功能相關的小插件組合，可以分別開啟或關閉，為您提供最清晰的分類和最強大的靈活性。"
--[[ 737]] L["插件-|cffffd100%s|r-"] = "插件-|cffffd100%s|r-"
--[[ 744]] L["%s加载成功"] = "%s載入成功"
--[[ 746]] L["%s加载失败, 原因："] = "%s載入失敗, 原因："
--[[ 746]] L["未知"] = "未知"
--[[1042]] L["%s加载失败，依赖插件["] = "%s載入失敗，依賴插件["
--[[1042]] L["]无法加载。"] = "]無法載入。"
--[[1056]] --L["%s加载失败，依赖插件["] = "%s載入失敗，依賴插件["
--[[1056]] --L["]无法加载。"] = "]無法載入。"
--[[1152]] L["停用%s需要重载界面"] = "停用%s需要重載介面"
--[[1155]] L["%s已暂停，彻底关闭需要重载界面。"] = "%s已暫停，徹底關閉需要重載介面。"
--[[1160]] L["%s不再停用"] = "%s不再停用"
--[[1172]] L["%s已启用, 需要时会自动加载"] = "%s已啟用, 需要時會自動載入"
--[[1271]] L["玩家登陆中"] = "玩家登陸中"
--[[1289]] L["玩家登陆完毕"] = "玩家登陸完畢"
--[[1345]] L["因上次载入过程未完成，已恢复之前的插件状态。"] = "正在恢復之前的設置..."
--[[1526]] L["延迟加载 - 还有 |cff00ff00%d|r 个插件将在战斗结束后加载。"] = "延遲加載 - 還有 |cff00ff00%d|r 個插件將在戰鬥結束後加載。"
--[[1536]] L["还有至少["] = "還有至少["
--[[1536]] L["]个插件尚未更新完，请等待更新器全部完成后运行/reload重载界面。"] = "]個插件尚未更新完，請等待更新器全部完成後運行/reload重載介面。"
--[[1538]] L["全部插件加载完毕。"] = "全部插件載入完畢。"
--[[1567]] L["战斗结束，继续加载插件，请安心等待……"] = "戰鬥結束，繼續載入插件，請安心等待……"
--[[1596]] L["进入世界"] = "進入世界"

--[[    ]] -- File: 163UIUI_V3.lua

--[[  79]] L["插件："] = "插件："
--[[  82]] L["快速启用/停用插件"] = "快速啟用/停用插件"
--[[ 240]] L["已加载,重启后停用"] = "已載入,重啟後停用"
--[[ 242]] L["|cff00D100已加载|r"] = "|cff00D100已載入|r"
--[[ 245]] L["|cffff0000未安装|r"] = "|cffff0000未安裝|r"
--[[ 247]] L["|cffA0A0A0未启用|r"] = "|cffA0A0A0未啟用|r"
--[[ 249]] L["已启用"] = "已啟用"
--[[ 249]] L["已启用,需重新加载"] = "已啟用,需重新載入"
--[[ 252]] L["|cffA0A0A0依赖插件未启用|r"] = "|cffA0A0A0依賴插件未啟用|r"
--[[ 254]] L["|cffff7f7f启用失败|r"] = "|cffff7f7f啟用失敗|r"
--[[ 268]] L["子插件"] = "子插件"
--[[ 283]] L["战斗中启用/停用插件可能会导致错误，重载界面后会正常。\n"] = "戰鬥中啟用/停用插件可能會導致錯誤，重載介面後會正常。\n"
--[[ 286]] --L["子插件"] = "子插件"
--[[ 292]] L["作者"] = "作者"
--[[ 292]] L["修改"] = "修改"
--[[ 294]] --L["作者"] = "作者"
--[[ 315]] L["目录"] = "目錄"
--[[ 315]] L["版本"] = "版本"
--[[ 318]] --L["网易有爱插件集"] = "網易有愛插件集"
--[[ 329]] L["全部"] = "全部"
--[[ 331]] L["内存"] = "記憶體"
--[[ 334]] L["状态"] = "狀態"
--[[ 334]] L["|cff00D100按需载入|r"] = "|cff00D100按需載入|r"
--[[ 338]] L["原因"] = "原因"
--[[ 345]] L["依赖"] = "依賴"
--[[ 354]] L["单体插件"] = "單體插件"
--[[ 356]] L["网易有爱整合版"] = "網易有愛整合版"
--[[ 409]] L['|cffFFA3A3没有启用插件|r'] = '|cffFFA3A3沒有啟用插件|r'
--[[ 429]] L["　有爱整合　"] = "　有愛整合　"
--[[ 430]] L["　其他插件　"] = "　其他插件　"
--[[ 430]] L["　单体插件　"] = "　單體插件　"
--[[ 494]] L["地图任务"] = "地圖任務"
--[[ 577]] L["正常模式"] = "正常模式"
--[[ 577]] L["将界面还原成普通模式，而不是半透明的精简模式"] = "將介面還原成普通模式，而不是半透明的精簡模式"
--[[ 581]] L["有爱设置"] = "有愛設置"
--[[ 597]] --L["有爱设置"] = "有愛設置"
--[[ 597]] L["直接显示网易有爱的介绍和配置项，再次点击则恢复当前的选择插件"] = "直接顯示網易有愛的介紹和配置項，再次點擊則恢復當前的選擇插件"
--[[ 598]] L["快捷设置"] = "快捷設置"
--[[ 598]] L["一些常用的选项，以下拉菜单方式列出，可迅速进行设置。"] = "一些常用的選項，以下拉式功能表方式列出，可迅速進行設置。"
--[[ 599]] --L["有爱设置"] = "有愛設置"
--[[ 599]] L["设置"] = "設置"
--[[ 621]] L["重载界面"] = "重載介面"
--[[ 627]] --L["重载界面"] = "重載介面"
--[[ 627]] L["重载"] = "重載"
--[[ 637]] L["请双击按钮（防止误操作）"] = "請按兩下按鈕（防止誤操作）"
--[[ 640]] L["回收内存"] = "回收記憶體"
--[[ 643]] L["释放内存"] = "釋放記憶體"
--[[ 643]] L["强制回收空闲的内存, 除了确定插件内存的稳定值外, 并没有太大用处."] = "強制回收空閒的記憶體, 除了確定插件記憶體的穩定值外, 並沒有太大用處."
--[[ 644]] --L["回收内存"] = "回收記憶體"
--[[ 644]] --L["内存"] = "記憶體"
--[[ 647]] L["方案管理"] = "方案管理"
--[[ 649]] --L["方案管理"] = "方案管理"
--[[ 649]] L["将已启用的插件列表等保存为方案，例如任务模式、副本模式等，亦可以在多个角色之间共用。"] = "將已啟用的插件列表等保存為方案，例如任務模式、副本模式等，亦可以在多個角色之間共用。"
--[[ 650]] --L["方案管理"] = "方案管理"
L["引导界面"] = true
L["引导"] = true
L["网易有爱引导界面"] = true
L["导入导出"] = "導入導出"
L["字符串"] = "字符串"
L["将当前游戏设置、插件设置、界面布局导出到字符串，可以分享给其它有爱玩家。"] = true
--[[ 650]] L["方案"] = "方案"
--[[ 666]] L["网易有爱快捷设置"] = "網易有愛快捷設置"
--[[ 682]] L["以下操作需要重载界面："] = "以下操作需要重載介面："
--[[ 691]] L["|cffff0000停用|r - "] = "|cffff0000停用|r - "
--[[ 691]] L["配置 - "] = "配置 - "
--[[ 742]] L["全部加载"] = "全部載入"
--[[ 742]] L["全开"] = "全開"
--[[ 743]] L["加载当前显示的所有插件"] = "載入當前顯示的所有插件"
--[[ 745]] L["注意：战斗中执行此操作可能会导致大量错误，建议执行完毕后重载界面。"] = "注意：戰鬥中執行此操作可能會導致大量錯誤，建議執行完畢後重載介面。"
--[[ 747]] L["注意：可能会加载近一分钟之久，期间游戏会停止响应，请安心等待。"] = "注意：可能會載入近一分鐘之久，期間遊戲會停止響應，請安心等待。"
--[[ 753]] L["全部停用"] = "全部停用"
--[[ 753]] L["全关"] = "全關"
--[[ 754]] L["停用当前显示的所有插件"] = "停用當前顯示的所有插件"
--[[ 756]] L["注意：战斗中执行此操作可能会导致大量错误。"] = "注意：戰鬥中執行此操作可能會導致大量錯誤。"
--[[ 758]] L["停用后请手动重载界面"] = "停用後請手動重載介面"
--[[ 764]] --L["已启用"] = "已啟用"
--[[ 766]] L["说明"] = "說明"
--[[ 766]] L["显示当前分类下已启用的插件"] = "顯示當前分類下已啟用的插件"
--[[ 767]] L["未启用"] = "未啟用"
--[[ 769]] --L["说明"] = "說明"
--[[ 769]] L["显示当前分类下未启用的插件"] = "顯示當前分類下未啟用的插件"
--[[1038]] L["已启用|cff00ff00 %d|r"] = "已啟用|cff00ff00 %d|r"
--[[1039]] L["未启用|cffAAAAAA %d|r"] = "未啟用|cffAAAAAA %d|r"
--[[1049]] L["全部插件加载完毕."] = "全部插件載入完畢."
--[[1140]] L["插件选项"] = "插件選項"
--[[1141]] L["插件介绍"] = "插件介紹"
--[[1275]] L["插件分类："] = "插件分類："
--[[1275]] L["<P>　%s<br/><br/></P>"] = "<P>　%s<br/><br/></P>"
--[[1275]] L["<P>　%s</P></BODY></HTML>"] = "<P>　%s</P></BODY></HTML>"
--[[1276]] L["插件数："] = "插件數："
--[[1288]] L["<BR/>　"] = "<BR/>　"
--[[1291]] L["<BR/><BR/>　插件集包含以下插件："] = "<BR/><BR/>　插件集包含以下插件："
--[[1294]] L["<BR/>　|cffe6e6b3 - %s|r"] = "<BR/>　|cffe6e6b3 - %s|r"
--[[1301]] --L["插件介绍"] = "插件介紹"
--[[1301]] L["<P>　%s<br/></P>%s</BODY></HTML>"] = "<P>　%s<br/></P>%s</BODY></HTML>"
--[[1304]] L["<P>|cffe6e6b3作者: %s|r</P>"] = "<P>|cffe6e6b3作者: %s|r</P>"
--[[1307]] L["<P>|cffe6e6b3修改: %s|r</P>"] = "<P>|cffe6e6b3修改: %s|r</P>"
--[[1319]] L["<H2 align='center'>|cff7f7fff◆ %s ◆|r</H2>"] = "<H2 align='center'>|cff7f7fff◆ %s ◆|r</H2>"
--[[1323]] L["<H2>◇|cffffd200%s|r</H2>"] = "<H2>◇|cffffd200%s|r</H2>"
--[[1337]] L["<H2>|cff7f7fff◇ %s%s ◇|r</H2>"] = "<H2>|cff7f7fff◇ %s%s ◇|r</H2>"
--[[1337]] L[".*年(.*) %d+:%d+"] = ".*年(.*) %d+:%d+"
--[[1347]] L["最近更新"] = "最近更新"
--[[1653]] L["搜索插件及选项"] = "搜索插件及選項"
--[[1654]] L["输入汉字、全拼或简拼进行检索，只有一个结果时可按回车选定。"] = "輸入漢字或英文進行檢索，只有一個結果時可按回車選定。"
--[[1656]] L["可以搜索插件名称或原名、以及选项中的任意文本，在当前标签下符合条件的插件会被显示出来，被搜索到的选项会被高亮显示。"] = "可以搜索插件名稱或原名、以及選項中的任意文本，在當前標籤下符合條件的插件會被顯示出來，被搜索到的選項會被高亮顯示。"
--[[1658]] L["只有网易有爱官方支持的插件才能用拼音搜索名称。"] = "繁體版不支持拼音檢索"
--[[1679]] L["这里可以输入汉字或者拼音，例如'|cffffd200对比|r'或者'|cffffd200Grid|r'。不但能查询插件名称，还能查询插件的选项呢！试试输入'|cffffd200对比|r'，然后选|cffffd200\"鼠标提示\"|r插件，选项里就会显示：\n|cffffd200\"是否自动|r|cff00d200对比|r|cffffd200装备\"|r。\n\n让一切功能手到擒来，现在就试试吧！"] = "這裡可以輸入漢字或者拼音，例如'|cffffd200對比|r'或者'|cffffd200Grid|r'。不但能查詢插件名稱，還能查詢插件的選項呢！試試輸入'|cffffd200對比|r'，然後選|cffffd200\"滑鼠提示\"|r插件，選項裡就會顯示：\n|cffffd200\"是否自動|r|cff00d200對比|r|cffffd200裝備\"|r。\n\n讓一切功能手到擒來，現在就試試吧！"
--[[1745]] L["网易有爱"] = "網易有愛"
--[[1745]] L["点击有爱标志开启插件控制中心\n \nCtrl点击小地图图标可以收集/还原"] = "點擊有愛標誌開啟插件控制中心\n \nCtrl點擊小地圖按鈕可以收集/還原"
--[[1754]] --L["网易有爱"] = "網易有愛"
--[[1771]] L["网易有爱插件中心"] = "網易有愛插件中心"
--[[1773]] L["    网易有爱（163UI）是网易大神隆重推出的新一代整合插件。其设计理念是兼顾整合插件的易用性和单体插件的灵活性，同时适合普通和高级用户群体。|n|n    功能上，网易有爱实现了任意插件的随需加载，并可先进入游戏再逐一加载插件，此为全球首创。此外还有标签分类、拼音检索、界面缩排等特色功能。"] = "    網易有愛（163UI）是網易遊戲頻道隆重推出的新一代整合插件。其設計理念是兼顧整合插件的易用性和單體插件的靈活性，同時適合普通和高級用戶群體。|n|n    功能上，網易有愛實現了任意插件的隨需載入，並可先進入遊戲再逐一載入插件，此為全球首創。此外還有標籤分類、拼音檢索、介面縮排等特色功能。"
--[[1775]] L["鼠标右键点击可打开快捷设置"] = "滑鼠右鍵點擊可打開快捷設置"
--[[1776]] L["Ctrl点击任意小地图按钮可收集"] = "Ctrl點擊任意小地圖按鈕可收集"
--[[1779]] L["图标闪光表示有新的小地图按钮被收集到控制台中， 请点击查看，下次就不再闪烁了"] = "圖示閃光表示有新的小地圖按鈕被收集到控制台中， 請點擊查看，下次就不再閃爍了"

--[[    ]] -- File: Minimap.lua

--[[  54]] L["按住CTRL点击可以收集"] = "按住CTRL點擊可以收集"
--[[  56]] L["按住CTRL点击可以还原"] = "按住CTRL點擊可以還原"

--- ===========================================================
-- Profiles.lua ProfilesUI.lua
--- ===========================================================
L["Before Load Profile"] = "載入之前"
L["Before Logout"] = "登出之前"
L["Before Restore"] = "重置之前"
L["After Login"] = "登入之后"

L["Current addon enable states will be lost, are you SURE?"] = "當前的插件控制台的設置將丟棄，您確定嗎？"
L["Are you sure to delete this profile?"] = "您確定要刪除此方案嗎？"
L["SAVE CURRENT PROFILE AS ACCOUNT GLOBAL PROFILE?"] = "是否将当前角色的设置文件覆盖到帐号通用设置？（\124cff00ff00`确定`后，帐号的设置将被该角色的设置覆盖\124）"
L["USE GLOBAL PROFILE OR CHARACTER'S OLD PROFILE?"] = "使用帐号通用设置还是恢复到角色本来的旧设置?（该角色将不再使用帐号通用设置，\124cff00ff00选`账号设置`后，并且复制一份帐号通用设置作为角色设置。选`角色设置`后，该角色将恢复到开启账号通用设置功能之前的配置\124）"
L["GLOBAL PROFILE"] = "账号设置"
L["CHARACTER PROFILE"] = "角色设置"
L["NetEaseUI Profiles"] = "網易有愛插件配置方案"
L["Saved"] = "方案列表"
L["Auto"] = "自動保存"
L["EAC will automatically save profiles before logout, after login, or loading another profile."] = "角色登出、載入方案之前，會自動保存當前設置"
L["Create Profile"] = "新建方案"
L["Restore Default"] = "恢復默認"
L["Global Setting"] = "帐号通用"
L["Simple Style"] = "简易界面"
L["Do you want to use Simple UI?"] = "是否开启简易界面？"
L["Global Setting Tip"] = "左键点击启用或关闭帐号通用设置\n右键点击开启或关闭此角色使用帐号通用设置"
L["Global Setting Character"] = "当前角色"
L["Reload to apply addon account global setting?"] = "是否重载以载入帐号通用配置"
L["Profile: "] = "方案: "
L["AddOns: "] = "插件數: "
L["Today"] = "今天"
L["AddOn States"] = "插件狀態"
L["AddOn Options"] = "插件配置"
L["In addition of saving addon enable/disable states, also save the options shown in the EAC panel."] = "選中此項則會保存/載入有愛插件控制台裡的所有設置項"
L["Rename"] = "改名"
L["Unnamed"] = "未命名"
L["Load"] = "載入"
L["Delete"] = "刪除"
L["Save"] = "保存"
L["New profile name: "] = "新建方案名稱："
L["Change profile name: "] = "修改方案名稱："

--[[    ]] -- File: RunFirst.lua

--[[  32]] L["|cffcd1a1c【网易有爱】|r- "] = "|cffcd1a1c【網易有愛】|r- "

--[[    ]] -- File: Tags.lua

--[[  31]] L["全部插件"] = "全部插件"
--[[  38]] L["精新推荐"] = "精新推薦"
--[[  43]] --L["网易有爱"] = "網易有愛"
--[[  51]] --L["单体插件"] = "單體插件"
--[[  58]] L["专用"] = "專用"
--[[  65]] --L["已启用"] = "已啟用"
--[[  72]] --L["未启用"] = "未啟用"

--[[    ]] -- File: Core\Core.lua

--[[ 228]] L["没有事件["] = "沒有事件["
--[[ 228]] L["]的处理函数."] = "]的處理函數."
--[[ 420]] L["忘记设置isscript了？"] = "忘記設置isscript了？"

--[[    ]] -- File: Controls\Controls.lua

--[[ 106]] L["|cffff0000需要重新加载界面|r"] = "|cffff0000需要重新載入介面|r"
--[[ 108]] L["注意"] = "注意"
--[[ 108]] --L["|cffff0000需要重新加载界面|r"] = "|cffff0000需要重新載入介面|r"

--[[    ]] -- File: Controls\SpinBox.lua

--[[  76]] L["请输入 |cffffd200%s|r ~ |cffffd200%s|r 之间的数字"] = "請輸入 |cffffd200%s|r ~ |cffffd200%s|r 之間的數字"

--[[    ]] -- File: Configs\Cfg!!!163UI!!!.lua

--[[   3]] --L["网易有爱"] = "網易有愛"
--[[   5]] L["网易有爱（163UI）插件是由网易大神官方推出的一款新一代整合插件。其设计理念是兼顾整合插件的易用性和单体插件的灵活性，同时适合普通和高级用户群体。``插件中心控制台是网易有爱团队全力打造的管理界面，整合了'插件加载管理'、'插件选项配置'、'标签式分类'、'实时全文搜索'、'小地图按钮收集'等一系列先进功能。而且任意插件均可'一键启用'，不需重载界面。``网易有爱将依靠强大的技术实力，让插件更少的报错、让问题更快的回复、让建议更快的实现，为您提供更新更快更强大的新一代整合插件。"] = "網易有愛（163UI）插件是由網易遊戲頻道官方推出的一款新一代整合插件。其設計理念是兼顧整合插件的易用性和單體插件的靈活性，同時適合普通和高級用戶群體。``插件中心控制台是網易有愛團隊全力打造的管理介面，整合了'插件載入管理'、'插件選項配置'、'標籤式分類'、'即時全文檢索搜尋'、'小地圖按鈕收集'等一系列先進功能。而且任意插件均可'一鍵啟用'，不需重載介面。``網易有愛將依靠強大的技術實力，讓插件更少的報錯、讓問題更快的回復、讓建議更快的實現，為您提供更新更快更強大的新一代整合插件。"
--[[   9]] L["|cffcd1a1c[网易原创]|r"] = "|cffcd1a1c[網易原創]|r"
--[[  13]] L["延迟加载插件"] = "延遲加載插件"
--[[  14]] L["说明`网易有爱独家支持，可以先读完蓝条然后再逐一加载插件。会大大加快读条速度，但是加载大型插件时会有卡顿。如果不喜欢这种方式，请取消勾选即可，下次进游戏时就会采用新设置。` `对比测试：`未开启时，在第7.5秒后读完蓝条同时加载完全部插件`开启后，在第3.8秒读完蓝条，第8.0秒加载完全部插件"] = "說明`網易有愛獨家支援，可以先讀完藍條然後再逐一載入插件。會大大加快讀條速度，但是載入大型插件時會有卡頓。如果不喜歡這種方式，請取消勾選即可，下次進遊戲時就會採用新設置。` `對比測試：`未開啟時，在第7.5秒後讀完藍條同時載入完全部插件`開啟後，在第3.8秒讀完藍條，第8.0秒載入完全部插件"
--[[  22]] L["插件加载速度（个/秒）"] = "插件載入速度（個/秒）"
--[[  23]] L["说明`　控制进入游戏时插件加载的速度，如果数值大，则单次卡顿的时间长，但总的加载时间会短，比如设置成100就会大卡一下后插件就全部加载好了。而设置成5则是每秒只会小卡一下，但要很久才能加载完全部插件。` `　另外可以使用/rl2命令来强制最慢速度加载，适合副本战斗中界面出错后（比如上载具没出动作条）迅速重载界面。"] = "說明`　控制進入遊戲時插件載入的速度，如果數值大，則單次卡頓的時間長，但總的載入時間會短，比如設置成100就會大卡一下後插件就全部載入好了。而設置成5則是每秒只會小卡一下，但要很久才能載入完全部插件。` `　另外可以使用/rl2命令來強制最慢速度載入，適合副本戰鬥中介面出錯後（比如上載具沒出動作條）迅速重載介面。"
--[[  36]] L["允许加载过期插件"] = "允許載入過期插件"
--[[  37]] L["说明`和人物选择功能插件界面上的选项一致"] = "說明`和人物選擇功能插件介面上的選項一致"
--[[  46]] L["完全屏蔽默认的团队框架"] = "完全屏蔽默認的團隊框架"
--[[  47]] L["说明`完全屏蔽暴雪团队框架及屏幕左侧的控制条，在使用Grid等团队框架时可以减少占用。` `注意此选项不能在战斗中设置"] = "說明`完全屏蔽暴雪團隊框架及螢幕左側的控制條，在使用Grid等團隊框架時可以減少佔用。` `注意此選項不能在戰鬥中設置"
--[[  53]] L["此选项不适合此游戏版本"] = "此選項不適合此遊戲版本"
--[[  56]] L["此选项无法在战斗中设置，请脱战后重试"] = "此選項無法在戰鬥中設置，請脫戰後重試"
--[[  89]] L["设置最远镜头距离"] = "設置最遠鏡頭距離"
--[[  90]] L["说明`这个值是修改\"界面-镜头-最大镜头距离\"绝对值, 比如, 系统默认为15, 界面设置里调到最大是15，调到中间是7.5。当设置此选项为25时，调到最大是25，调到中间是12.5"] = "說明`這個值是修改\"介面-鏡頭-最大鏡頭距離\"絕對值, 比如, 系統預設為15, 介面設置裡調到最大是15，調到中間是7.5。當設置此選項為25時，調到最大是25，調到中間是12.5"
--[[  99]] L["控制台设置"] = "控制台設置"
--[[ 102]] L["显示插件英文名"] = "顯示插件英文名"
--[[ 104]] L["说明`选中显示插件目录的名字，适合中高级用户快速选择所需插件。"] = "說明`選中顯示插件目錄的名字，適合中高級用戶快速選擇所需插件。"
--[[ 116]] L["按插件所用内存排序"] = "按插件所用記憶體排序"
--[[ 118]] L["说明`选中则按插件(包括子模块)所占内存大小进行排序，否则按插件名称排序。"] = "說明`選中則按插件(包括子模組)所占記憶體大小進行排序，否則按插件名稱排序。"
--[[ 130]] L["小地图相关"] = "小地圖相關"
--[[ 133]] L["收集全部小地图图标"] = "收集全部小地圖按鈕"
--[[ 140]] L["还原全部小地图图标"] = "還原全部小地圖按鈕"
--[[ 149]] L["隐藏缩小放大按钮"] = "隱藏縮小放大按鈕"
--[[ 150]] L["说明`隐藏后用鼠标滚轮缩放小地图"] = "說明`隱藏後用滑鼠滾輪縮放小地圖"


