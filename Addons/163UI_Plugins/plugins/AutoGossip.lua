--[[--
	PLUGIN: AutoGossip
--]]--

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;

local __meta = __ns.__meta;
local __plugins = __ns.__plugins;

local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

local _F_coreDebug = __ns._F_coreDebug;
local _F_metaOnEvent = __meta._F_metaOnEvent;
----------------------------------------------------------------

-->	upvalue


local _TimelessQuestData = {
	"告诉我，英雄，亡灵鱼人被称作什么？ A. 鳄鱼人 !B. 行尸鱼人 C. 狼獾人 D. 巫妖鱼人",
	"下列哪句话是龙语中“谢谢你”的意思？ A. Borela mir !B. Belan shi C. Avral shi D. Alena mir",
	"下列哪一位的墓志铭上刻有“愿血染的王冠永远被遗失和忘却”这句话？ A. 阿尔萨斯·米奈希尔王子 B. 莱恩·乌瑞恩国王 C. 乌瑟尔·光明使者 !D. 泰瑞纳斯·米奈希尔二世国王",
	"在撕心狼变成狼人之前，他也曾有过家室。他的妻子叫什么名字？ A. 艾玛·哈林顿 !B. 卡莉莎·哈林顿 C. 薇妮莎·怀特豪尔 D. 卡特里娜·怀特豪尔",
	"有一位王后，在大灾变和被遗忘者袭击她的国度时，她井井有条地安排了人民的疏散工作。这位王后叫什么名字？ A. 莉亚·格雷迈恩王后 B. 玛利亚·格雷迈恩王后 C. 莉莉娅·格雷迈恩王后 !D. 米亚·格雷迈恩王后",
	"在上古之战后，守护巨龙们给了暗夜精灵什么东西？ A. 泰达希尔 B. 永恒之井 !C. 诺达希尔 D. 月亮井",
	"不久之前，一个脆弱的赞达拉巨魔想要驯服一头恐角龙。虽然他登上了巨兽岛，却在任务过程中遇害。请问这个巨魔叫什么名字？ A. 玛尔卡 B. 格里麦斯 !C. 塔拉克 D. 拉维里",
	"瓦里安·乌瑞恩国王的第一任妻子的正确名字是什么？ A. 蒂芬·温德米尔·乌瑞恩 B. 泰丽丝·安妮·乌瑞恩 C. 泰丽丝·安哈蕾德·乌瑞恩 !D. 蒂芬·艾莉安·乌瑞恩",
	"一位血色十字军保卫者在刺杀恐惧魔王贝塞利斯时遇害，她叫什么名字？ A. 菲尔拉蕾·迅箭 !B. 霍利亚·萨希尔德 C. 亚娜·血矛 D. 瓦雷亚",
	"在担任家庭教师期间，斯塔文·密斯特曼托爱上了自己的学生，一个名叫蒂罗亚的年轻姑娘。请问她的弟弟叫什么名字？ A. 比利 B. 威廉姆 !C. 基尔斯 D. 托比亚斯",
	"魅魔热衷于制造痛苦，她们在燃烧军团中专门负责进行可怕的拷问工作。请问魅魔属于哪个品种的恶魔？ A. 埃雷杜因 !B. 萨亚德 C. 破坏魔 D. 艾瑞达",
	"铁炉堡图书馆中展出了一具巨型山羊的骨架复制品。这头传奇山羊叫什么名字？ A. 污蹄 !B. 磨齿 C. 血角 D. 钢拳",
	"艾泽拉斯出现的第一个死亡骑士是谁？ !A. 塔隆·血魔 B. 阿尔萨斯·米奈希尔 C. 亚历山德罗斯·莫格莱尼 D. 库尔迪拉·织亡者",
	"头衔中包含“夜晚之友”的是哪位神灵？ A. 西瓦尔拉 B. 吉布尔 !C. 缪萨拉 D. 沙德拉",
	"德鲁伊的最高称号是什么？ A. 萨满祭司 B. 唤雷者 !C. 大德鲁伊 D. 先知",
	"由玛法里奥·怒风协助建立的，艾泽拉斯最主要的德鲁伊组织叫什么名字？ A. 深红之环 B. 翡翠议会 C. 大地之环 !D. 塞纳里奥议会",
	"在牛头人的语言中，lar'korwi是什么意思？ !A. 锋利的爪子 B. 剃刀般的牙齿 C. 锋利的牙齿 D. 剃刀般的爪子",
	"侏儒如今的领袖是谁？ !A. 格尔宾·梅卡托克 B. 米尔豪斯·法力风暴 C. 希科·瑟玛普拉格 D. 菲兹兰克·铁阀",
	"白狼曾是哪个兽人氏族最喜爱的坐骑？ A. 白爪氏族 B. 战歌氏族 !C. 霜狼氏族 D. 冰牙氏族",
	"虚灵的家乡叫什么名字？ !A. 卡雷什 B. 夏罗迪 C. 库拉尔 D. 克索诺斯",
	"嫌弃银月城过于明亮和干净的部落大使叫什么名字？ A. 科内塔 B. 克莉丝汀·德尼 !C. 塔泰 D. 德拉·符文图腾",
	"由地精制造，原计划搭载萨尔和阿格娜前往大漩涡，却被联盟意外摧毁的部落舰船叫什么名字？ !A. 德拉卡的狂怒 B. 地狱咆哮的狂怒 C. 阿格娜的狂怒 D. 杜隆坦的狂怒",
	"大领主库德兰·蛮锤最近痛失爱将，他英勇的狮鹫在一次大火中不幸丧生。这头狮鹫叫什么名字？ A. 迅捷之翼 B. 沙普比克 !C. 斯卡雷 D. 风暴比克",
	"在第三次大战过去数年之后，黑暗之门重新开启时，艾泽拉斯首次出现了棕色皮肤的兽人。这些兽人被称为什么？ !A. 玛格汉兽人 B. 魔血兽人 C. 莫克纳萨兽人 D. 邪兽人",
	"阿尔萨斯用来训练死亡骑士，后来又由于大部分死亡骑士背叛巫妖王而被占领的浮空堡垒叫什么名字？ !A. 阿彻鲁斯 B. 纳克萨纳尔 C. 科尔拉玛斯 D. 纳克萨玛斯",
	"这个世界上的第一个萨特是谁？ A. 佩罗萨恩 B. 贾拉克萨斯 !C. 萨维斯 D. 维利塔恩",
	"在突袭冰冠堡垒时，部落军队无耻地偷袭正与天灾军团激战的联盟士兵，并试图占领的那座城门叫什么名字？ A. 科雷萨 B. 奥尔杜萨 C. 安加萨 !D. 莫德雷萨",
	"被洛肯捕获并变成锋鳞的强大始祖龙叫什么名字？ A. 迦拉克隆 !B. 维拉努斯 C. 塞普泰克 D. 维利塔恩",
	"在最初的部落建立之前，有一种高传染性的病毒在兽人间快速传播。兽人们称这种病为什么？ A. 猩红热 B. 血色天灾 C. 血红热 !D. 红色天灾",
	"在第三次大战期间，是什么证据促使阿尔萨斯王子屠杀了斯坦索姆的居民？ A. 被污染的泥土 B. 被污染的野生动物 C. 被污染的水 !D. 被污染的粮食",
	"赞加沼泽有一个地方，那里为纳迦所控制，他们还试图在那里抽取一种珍贵而稀有的资源：外域之水。这个地方叫什么名字？ A. 盘蛇洞穴 B. 蛇形盆地 !C. 盘牙水库 D. 旋牙水潭",
	"提里奥·弗丁的灰色公马叫什么名字？ A. 阿什纳尔 B. 米瑟维尔 C. 菲奥尼尔 !D. 米拉多尔",
	"在黑曜石圣殿守护暮光龙蛋的三头暮光幼龙分别叫什么？ !A. 塔尼布隆、维斯匹隆和沙德隆 B. 塔尼布隆、维斯匹隆和海里昂 C. 瑟纳利昂、沙德隆和艾比希昂 D. 瑟纳利昂、海里昂和艾比希昂",
	"隶属于万神殿精锐的泰坦知识守护者叫什么名字？ A. 阿曼苏尔 !B. 诺甘农 C. 艾欧纳尔 D. 卡兹格罗斯",
	"在被阿尔萨斯复活为亡灵，并加入天灾军团之前，辛达苟萨曾属于哪个巨龙军团？ A. 红龙军团 !B. 蓝龙军团 C. 绿龙军团 D. 青铜龙军团",
	"根据德莱尼人的玩笑，“埃索达”在纳鲁语中是什么意思？ !A. 残次的雷象粪便 B. 水晶死亡陷阱 C. 毫无价值的雷象粪便 D. 放射性生化灾难",
	"有一位德莱尼人，他曾是一个健康的圣骑士，但在与燃烧军团作战时，他身染恶疾，变成了破碎者。后来，他成了一个强大的萨满。这个德莱尼人是谁？ A. 维纶 B. 阿卡玛 C. 玛尔拉得 !D. 努波顿",
};
local _NazmirData = {
	["我寻求神灵的祝福。"] = 1,
	["永远鼓足勇气去行动。"] = 2,
	["坚定的意志。"] = 3,
	["光荣的生活。"] = 4,
	["他们看到自己属于自然。"] = 5,
};
local _WormHoleData = {
	"阿兰卡峰林",
	"塔拉多",
	"影月谷",
	"纳格兰",
	"戈尔德隆",
	"霜火岭",
};


local _enabled = true;
_F_metaOnEvent("GOSSIP_SHOW", function(event, ...)
	if _enabled then
		local _buttons = GossipFrame.buttons;
		if _buttons ~= nil then
		local _GUID = UnitGUID('npc');
			if _GUID ~= nil then
				local _, _, _, _, _, _unit = strsplit("-", _GUID);
				if _unit == "172714" then			--	晋升堡垒世界任务【枯竭情况】被困的看护者
					if _buttons[1] ~= nil and _buttons[1]:IsShown() then
						_buttons[1]:Click();
					end
				elseif _unit == "35004" or _unit == "35005" then
					if _buttons[2] ~= nil and _buttons[2]:IsShown() then
						_buttons[2]:Click();
					elseif _buttons[1] ~= nil and _buttons[1]:IsShown() then
						_buttons[1]:Click();
					end
				end
			end
			local _name = GossipFrameNpcNameText:GetText();
			if _name == "资深历史学家伊夫琳娜" then		--	永恒岛日常
				local body = GossipGreetingText:GetText();
				if body == "答对了！" then
					return;
				end
				local _, _, questbody = strfind(body, "那就让我们来测试一下你的历史知识吧！(.+)");
				if not questbody then
					return;
				end
				--_F_coreDebug("资深历史学家伊夫琳娜 actived:", questbody);
				for _, v in next, _TimelessQuestData do
					local _, _, match = strfind(v, questbody);
					if match then
						local _, _, choose = strfind(v,"!(%a)");
						local chossebutton;
						if choose == "A"		then
							choosebutton = _buttons[3];
						elseif choose == "B"	then
							choosebutton = _buttons[4];
						elseif choose == "C"	then
							choosebutton = _buttons[5];
						elseif choose == "D"	then
							choosebutton = _buttons[6];
						end
						choosebutton:SetText("\124cff4040ff" .. choosebutton:GetText() .. "\124r");
						--_F_coreDebug(v,choose);
						break;
					end
				end
			elseif _name == "夜之子贱民" then
				if _buttons[1] ~= nil and _buttons[1]:IsShown() then
					_buttons[1]:Click();
				end
			elseif _name == "熊猫人志愿者" then		--	翡翠林--是敌非友
				if _buttons[1] ~= nil and _buttons[1]:IsShown() then
					_buttons[1]:Click();
				end
			elseif _name == "吉布尔-埃拉卡的雕像" then		--	纳兹米尔 吉布尔的祝福
				for _index = 1, 6 do
					local _title = _buttons[_index];
					if _NazmirData[_title:GetText()] ~= nil then
						_title:Click();
					end
				end
			elseif _name == "被俘的鳍地精" and _name == "被俘的渊壳龙虾人" and _name == "被俘的海巨人" then		--	纳沙塔尔 损坏的控制器
				if _buttons[1] ~= nil and _buttons[1]:IsShown() then
					_buttons[1]:Click();
				end
			elseif _name == "虫洞" then
				for _index = 1, 6 do
					local _title = _buttons[_index];
					_title:SetText(_WormHoleData[_index] .. ":" .. _title:GetText());
				end
			end
		end
	end
end);

__plugins['AutoGossip'] = {
	function()
		_enabled = true;
	end,
	function()
		_enabled = false;
	end,
};

