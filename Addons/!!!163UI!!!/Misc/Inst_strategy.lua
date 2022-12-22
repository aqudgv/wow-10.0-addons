--[[--
	复用代码请在显著位置标注来源【ALA@网易有爱】
	refers:
		https://wow.gamepedia.com/InstanceID
--]]--
if select(4, GetBuildInfo()) < 90000 then
	return;
end

local max = max;
local IsInInstance, GetInstanceInfo = IsInInstance, GetInstanceInfo;
local LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE;
local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME;
local GameTooltip = GameTooltip;

local BUTTON_HEIGHT = 16;
local BUTTON_INTERVAL = 1;

local _PREFIX = "网.易.有.爱>";
local _SUFFIX = "<攻略：";
local _STRATEGY_DATA = {
	--[=[
	[34] = {		--	test purpose
		{
			-1,
			"BOSS_TEST1",
			"STRATEGY_TEST1",
		},
		{
			-1,
			"BOSS_TEST2",
			"STRATEGY_TEST2",
		},
		{
			-1,
			"BOSS_TEST3",
			"STRATEGY_TEST3",
		},
	},
	--]=]
	[2284] = {	--	"赤红深渊"
		{
			-1,
			"贪食的克里克西斯",
			"BOSS巨兽奔袭技能点名，注意集合分担；打断饥苦吸取，注意看全队血量吃精华球。",
		},
		{
			-1,
			"执行者塔沃德",
			"开场躲开地上移动的两个红圈，这两个红圈会在大厅里一直绕圈，后面也注意躲开；被严惩点名出人群，优先击杀小怪、躲开小怪死亡后的红水。",
		},
		{
			-1,
			"大学监贝律莉娅",
			"坦克被BOSS钢条尖刺时注意开技能；满能量读条技能至高仪式时，注意吃地上的黄球叠最多5层buff减轻AOE伤害；躲开地上多个黄圈。",
		},
		{
			-1,
			"卡尔将军",
			"BOSS飑风技能有击退，在外面平台上注意靠近墙，不要被击退下平台；点名出人群、躲BOSS冲锋，同时注意躲开场地边缘BOSS虚影的红色连线。",
		},
	},
	[2285] = {	--	"晋升高塔"
		{
			-1,
			"金·塔拉",
			"最好BOSS和鸟一起死，否则会狂暴。",
			"开场优先人形BOSS，拉着背对人群；不要穿过鸟和BOSS之间的连线，躲开鸟正面的黑色弹幕、打断BOSS黑暗长枪。",
			"飞天阶段远程持续打BOSS本体，被点名充能长矛开减伤躲开。",
		},
		{
			-1,
			"雯图纳柯丝",
			"BOSS拉场地边缘，放黑雾，躲黑球，治疗抬血被BOSS暗影步点名的队友，同时注意躲开BOSS正面锥形范围的眩光技能。",
		},
		{
			-1,
			"奥莱芙莉安",
			"BOSS放天域军火技能时，全队集合放白圈，几波白圈尽量挨着放。",
			"BOSS读条心能回灌易伤阶段，开爆发技能，同时坦克单人挡飞向BOSS的黑球，其余人可以不挡，要么开自保技能挡2次；被点名净化冲击波出人群。",
		},
		{
			-1,
			"疑虑圣杰德沃斯",
			"一阶段BOSS深渊爆炸进地上白圈规避伤害，BOSS点名直线冲锋时躲开。二阶段BOSS上天，躲地上风圈、捡白球到中间的长矛，捡完球用长矛把BOSS射下地。",
		},
	},
	[2286] = {	--	"通灵战潮"
		{
			-1,
			"凋骨",
			"躲BOSS吐息，吐息完毕后被腐虫追的人迅速跑开，被咬到3次会被秒杀，优先控制和集火杀掉腐虫。",
		},
		{
			-1,
			"收割者阿玛厄斯",
			"打断箭雨，躲BOSS正面扇形范围喷吐、优先转火小怪，远离地上尸体堆。",
		},
		{
			-1,
			"外科医生缝肉",
			"三波小怪阶段帮挡飞刀，被凝视点名快速跑开风筝，躲地上绿水。",
			"被缝肉造物<肉钩>技能点名的人，跑到小怪和BOSS中间，让小怪肉钩的红色箭头朝着BOSS，然后躲开，利用小怪的肉钩把BOSS拉下平台。",
		},
		{
			-1,
			"缚霜者纳尔佐",
			"分散站位，被点名冰冻会出现白圈，其他人远离白圈、再驱散被冰的队友。",
			"BOSS读条彗星风暴时，需要一直移动、移动、移动，站着不动会被天上掉下来的冰箭秒掉；被放逐后回来的人靠墙站放冰圈。",
		},
	},
	[2287] = {	--	"赎罪大厅"
		{
			-1,
			"罪污巨像",
			"BOSS拉到开阔场地、躲boss扔石头和地上红水、躲开缓慢转动的四柱红光。",
		},
		{
			-1,
			"艾谢朗",
			"躲地上红水，小怪出来群拉集火，被BOSS点名开减伤、跑到变成石头的小怪位置炸死小怪。",
		},
		{
			-1,
			"高阶裁决官阿丽兹",
			"打断能量箭，DPS站在场地边缘的赎罪容器后面、让追人的小怪撞到容器自动消失，躲地上红圈。",
		},
		{
			-1,
			"宫务大臣",
			"BOSS念力投掷拉动雕像时注意站位躲开。",
			"BOSS念力突袭读条时会拉拢四个雕像，躲开即可。",
			"BOSS弹开雕像、读条哀伤仪式技能时，去挡连接雕像的红线；治疗注意抬血被傲慢罪印点名的玩家。",
		},
	},
	[2289] = {	--	"凋魂之殇"
		{
			-1,
			"酤团",
			"躲BOSS正面软泥浪潮，软泥吃控制、出来速度转火打掉小软。",
		},
		{
			-1,
			"依库斯博士",
			"躲BOSS跳跃，注意驱散疾病，优先转火绿软魔药炸弹、断红软疾病，踩红软死后血水有急速加成、但会持续掉血。",
		},
		{
			-1,
			"多米娜·毒刃",
			"点名出人群、AOE技能找BOSS蜘蛛网小怪。",
		},
		{
			-1,
			"斯特拉达玛侯爵",
			"开场小怪T拉住打，BOSS消失转阶段，触须扇形拍地板，快点跑到无触须的一侧场地，否则拍中秒杀，同时注意击杀狂热者小怪。",
		},
	},
	[2290] = {	--	"塞兹仙林的迷雾"
		{
			-1,
			"英格拉·马洛克",
			"开场留爆发技能，先打大树奥法兰、拉着背对人群，坦克躲正面迷乱花粉技能。",
			"20%血奥法兰变友好、然后开爆发打马洛克，打断马洛克灵魂箭。",
			"奥法兰变敌对后再转火或视boss血量直接rush掉。",
		},
		{
			-1,
			"1号到2号路上的迷宫",
			"打完1号进入迷宫，每个区域的门前面4个柱子，根据柱子图案的有圈、无圈、实心、空心、叶子、花几个特点来找不同",
			"比如三个图案有圈、一个没圈，没圈的就是正确道路。",
		},
		{
			-1,
			"唤雾者",
			"躲开地上箭头方向、被肉饼蛋糕点名的人打断该技能、硬控追人的小狐狸",
			"BOSS分身阶段有AOE，分身头上有图标，也是根据之前迷宫图案找不同的方式来确定该正确击杀的分身。",
		},
		{
			-1,
			"特雷德奥瓦",
			"BOSS开场拉到场地边缘，躲绿水和吞噬阶段的白圈，被心灵连接点名、跑到40码外拉断蓝线；注意转火救队友。",
		},
	},
	[2291] = {	--	"彼界"	--	[2439] = "彼界",
		{
			-1,
			"夺灵者哈卡",
			"鲜血护盾时有全团AOE、注意减伤和治疗，中红圈远离队友，二阶段优先打掉锁定人的小怪。",
		},
		{
			-1,
			"法力风暴夫妇",
			"打断米尔豪斯寒冰箭、注意挡水晶的连线；转阶段时拉住米尔菲斯、注意全队分散、拆炸弹，同时被米尔豪斯点名的人去炸米尔菲斯。",
		},
		{
			-1,
			"商人赛·艾柯莎",
			"传好奥术闪电DOT；躲开传送门的冲击波射线。",
			"地上有白色的陷阱，BOSS爆破计谋读条快完时、踩陷阱上天躲伤害，被点名定时炸弹的人也要在倒计时快完时踩陷阱上天、避免炸团。",
		},
		{
			-1,
			"穆厄扎拉",
			"一阶段被点名后跑到场边放球；拉远视角注意BOSS三连击的走位：左手高举会砸左边场地、右手高举会砸右边场地、双手高举则是砸身前的场地，近战注意远离。",
			"二阶段BOSS读条<粉碎现实>时全部进门，在外面会直接被秒杀；分别进左右两边的传送门，传到4个台子上击杀大怪、点对应图腾，需要点4个图腾，同时注意躲紫圈。",
			"再出来循环一阶段。",
		},
	},
	[2293] = {	--	"伤逝剧场"
		{
			-1,
			"狭路相逢",
			"躲地上绿水；被点名灼热之陨出人群 ；BOSS激怒追人时注意驱散。",
		},
		{
			-1,
			"斩血",
			"躲开小怪死亡后地上的绿水；注意场地两侧移动的肉钩墙，会横扫全场，站在肉钩墙的缺口处躲避。",
		},
		{
			-1,
			"无堕者哈夫",
			"优先集火打战旗；躲开BOSS跳斩后的正面直线和绿色扇形的顺劈三连击；被BOSS点名下场对战的两个人注意45秒内分胜负。",
		},
		{
			-1,
			"库尔萨洛克",
			"被点名幻影寄生出人群；治疗注意被抽取灵魂的队友的血量；躲开地上的绿圈。",
		},
		{
			-1,
			"无尽女皇莫得蕾莎",
			"分散站位，躲开BOSS正面小角度转动的光柱技能，场地出现黑色裂隙时远离、反方向奔跑。",
		},
	},
	[2296] = {
		{
			2393,
			"啸翼",
			"一阶段BOSS能量会涨到100，坦克中[抽干]换坦，BOSS[裂耳尖啸]读条，躲柱子规避伤害；被点名回声定位出人群分散放血池；远离脚下有红圈的队友；大团站在BOSS背面躲音波圈。",
			"二阶段BOSS免伤，不用输出，远离BOSS脚下红圈，和一阶段一样躲好技能即可。BOSS能量降到0再次循环一阶段。",
		},
		{
			2429,
			"猎手阿尔迪莫",
			"BOSS放寻罪箭有点名，中点名者有红色箭头，分开站、其余人躲开红色箭头方向。",
			"第一只熊和BOSS拉一起，2层锯齿利爪换T；被点名有红圈，需要多人分担伤害；",
			"第二只熊巴加斯特和BOSS位置分开拉；读条灵魂剥离时，过量刷狗T，刷出来的狗影子需要放控制技能，优先集火打掉；",
			"第三只熊拉着尽量不动，狗的[碾石]层数高了后拉着移动消层数，消除碾石时有AOE；被点名石化嚎叫的人到场地边缘放黄圈。",
		},
		{
			2422,
			"太阳之王的救赎（凯尔萨斯）",
			"小怪击杀优先级：灵魂灌注者>神秘学者>缚石征服者>荒翼刺客>难缠的石精",
			"[高阶折磨官]点名至高惩戒，脚下有红圈，分散开远离队友；打断[神秘学者]读条；",
			"拉[缚石征服者]的T，4-5层征服dot换T；",
			"[荒翼刺客]点名玩家头上有红箭头，出人群远离队友，低血量读条岩石形态时，集火击杀，否则读完条满血;",
			"[难缠的石精]死亡后尸爆，注意远离。",
			"凯子四种加血方式：1.直接加血 2.击杀[神秘学者]后刷满地上的精华之泉 3.击杀[灵魂灌注者]刷新红色宝珠、吃宝珠提高50%治疗量 4.坦克和DPS可以点灵魂底座输血。",
			"凯尔萨斯血量加到45%和90%，会刷新[凯尔萨斯之影]，影子在场期间，给凯子加血无效。",
			"T拉影子1-2层[火焰打击]换T；被影子点名红圈的人，全团集合分担伤害；影子满能量时躲正面喷吐技能；被凤凰小怪点名出人群风筝。",
		},
		{
			2418,
			"圣物匠赛·墨克斯",
			"被点名[空间撕裂]的两个人，分别跑到场地两边去放虫洞白圈。",
			"大团把BOSS拉在一个虫洞附近，被BOSS[毁灭符文]点名的T，用虫洞传送离开大团，避免炸团；",
			"地上白线技能（类似彼界虚灵BOSS技能）需要全程躲开；",
			"地上白色莲花陷阱，注意躲开，可以开免疫技能踩掉陷阱。",
			"一阶段被绿色灵魂点名锁定的人，踩地上虫洞传送来风筝灵魂；",
			"二阶段地上蓝色种子，拾取后踩虫洞搬到场地边缘远离人群；",
			"三阶段虫洞不用放太远、全团虫洞传送远离吸人的大白圈。",
		},
		{
			2428,
			"饥饿的毁灭者",
			"BOSS叠5-6层吞噬饥饿就换T、留技能应对BOSS压制；",
			"被BOSS暴食瘴气点名有白圈、需要4人集合在一起吸血；",
			"全团中蓝圈时、全团分散、刷满血，血量越高、蓝圈越小。",
			"远离炸完留下的球，满血开个人减伤去撞掉；被点名不稳定喷发的人，出人群分散、所有人躲开点名人和BOSS直线的方向。",
			"BOSS施放吞噬技能时，全团跑到场地边缘、远离BOSS，避免给BOSS回太多血。",
		},
		{
			2420,
			"伊涅瓦·暗脉女勋爵",
			"场地两边从左至右共4个心能罐，对应游戏界面上的四个心能条，每个心能条分为三级、每级BOSS技能会加强。需要控制四个罐子的心能，与罐子互动泄能、避免心能满了灭团。",
			"开场BOSS激活左边第一个罐，心能条开始增长；四层扭曲欲望换T，坦克DOT扭曲欲望快结束时，出人群避免炸团；治疗注意给带有共享认知debuff的队友刷血（团队框架上心碎图标）。",
			"第二罐激活后，需要一直接瓶子，地上会出现红圈，必须有人站在里面去接力，接完躲开地上血池。",
			"第三罐激活后，被连线点名的玩家需要各自站在红球位置，让球和线连在一起；第三罐心能条在二级后，其余人注意躲开连线区域。",
			"第四罐激活后，红圈点名的全部集合到boss脚下放小怪；如果心能条到二级，被点名红圈无法移动，需要提前在BOSS[暗影释放]技能前集合；心能条三级时小怪出来有血池，躲开即可。",
			"全程注意打断小怪读条。",
		},
		{
			2426,
			"猩红议会",
			"两个T拉堡主和勋爵，吃2层技能换T。女人不用拉，但需要安排打断女人技能[惊骇箭雨]。三个BOSS根据击杀顺序有不同技能，按照测试服情况，建议击杀顺序：女男爵>堡主>勋爵。",
			"勋爵的冲锋需要近战和T分担、优先击杀堡主的小怪[忠实的侍从]、勋爵点名跳舞时，红色连线的两个人靠拢8码内，持续移动躲红圈；",
			"任一BOSS血量降到50%，开始跳舞，提前准备、跑到跳舞的光柱里，根据指令点按键，点错点快点慢都会被惩罚。",
			"只剩一个BOSS在场时：如果最后只剩堡主、注意拉住召唤的[精英石卫]，先转火它。只剩女人、注意全团绕场地放血池。只剩勋爵、减少移动、注意躲开召唤出来的跳舞NPC。",
		},
		{
			2394,
			"泥拳",
			"两个T一直重合站、拉BOSS，可以不换T。开场拉场地边缘，不要靠近4个柱子！近战等T拉好再上，远程职业尽量集中站位、远离近战组。",
			"躲地上黄圈落石；BOSS践踏时全部跑出大圈；被点名有锁链的人，头上有红箭头，迅速找另一个锁链队友集合12码内，不要拉断锁链！",
			"被点名红圈的人，其余人进圈等BOSS拉到身前，分担伤害后再远离。",
			"BOSS满能量会冲锋,T头上有红箭头、迅速跑到柱子后，让BOSS撞柱子，其余人躲开BOSS冲锋路线，撞完有易伤，开技能输出。BOSS 20%血量软狂暴、开嗜血rush。",
		},
		{
			2425,
			"顽石军团干将",
			"一阶段女人BOSS，2层[锯齿撕裂]换T。点名飞刀有红色箭头，出人群，躲开飞刀的路径。50%血转阶段先打大怪、躲地上红圈，怪物死亡后的血球拾取去给雷纳索尔王子回血。",
			"被点名连线的人，迅速跑到BOSS附近，与坦克、被飞刀点名的人站在一起分担伤害，同时消除Debuff。",
			"二阶段男人BOSS，5层DOT换T，点名黄色箭头的人出人群，BOSS会大跳踩出一个黄圈、全场击退；躲开地上的尖刺；飞刀点名和连线按照一阶段方式处理，50%血再进入转阶段打小怪。",
			"两个BOSS同时在场后，注意换好T，同时削减两个BOSS的血量，否则一个BOSS先倒，另一个伤害增加200%。",
		},
		{
			2424,
			"德纳修斯大帝",
			"全团人分成两组，AB两组轮流吃BOSS正面的[净化痛苦]技能、消层数，吃完正面技能A小怪。",
			"BOSS镜像点名两个玩家，有红色连线，分开跑到两组后面，让其他人处于冲锋路线上、分担伤害。",
			"BOSS满能量读条毁灭，中间长剑会放120度扇形的红水区域，需要迅速跑开。",
			"需要把debuff降到2层、并在BOSS第三次满能量前打到70%血进入转阶段。转阶段BOSS会弹开玩家，之后要迅速跑到BOSS身边。",
			"二阶段1个T拉BOSS正面对着秘法师，让BOSS毁灭痛苦技能打到秘法师、产生易伤、集火打掉，秘法师死亡前所有人3码分散。",
			"吃了一层毁灭痛苦就换T，另一个人拉BOSS的剑，其余人不要站BOSS正面。",
			"被剑标记的玩家出人群、靠边放水，其他人躲开剑的路径；BOSS放毁灭之手前，将BOSS拿到场地边的镜子旁，通过镜子传送来规避毁灭之手的幻象爆炸；",
			"BOSS满能量放屠灭大招，开减伤躲好场地上的红色巨剑。",
			"40%血量进三阶段，进三阶段前要击杀全部秘法师。",
			"躲开心能漩涡、粉碎痛苦坦克注意开减伤，被点名出人群分散站位、撞心能球削弱爆炸伤害。",
			"同时注意有一二阶段的技能：远离幻象爆炸、躲开扇形技能、躲好屠灭大招。",
		},	
	},
};

local main = CreateFrame("BUTTON", nil, UIParent);
main:SetSize(24, 24);
main:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Abilities-Up");
main:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Abilities-Up");
main:GetNormalTexture():SetTexCoord(4 / 32, 28 / 32, 31 / 64, 55 / 64);
main:GetPushedTexture():SetTexCoord(4 / 32, 28 / 32, 31 / 64, 55 / 64);
main:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
main:SetPoint("RIGHT", ChatFrame1EditBox, "LEFT", -1, 0);
main:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:AddLine("副本一句话攻略");
	GameTooltip:Show();
end);
main:SetScript("OnLeave", function(self)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end);

local current = nil;
local menu = CreateFrame("FRAME", nil, main, "BackdropTemplate");
menu:SetBackdrop({
	bgFile = "Interface\\Buttons\\WHITE8X8";
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 2,
	edgeSize = 2,
	insets = { left = 2, right = 2, top = 2, bottom = 2 }
});
menu:SetBackdropColor(0.05, 0.05, 0.05, 1.0);
menu:Hide();
local pool = {  };
local eles = {  };
local function OnClick(self)
	if current ~= nil then
		local index = self.id;
		local val = current[index];
		local channel = nil;
		if IsInRaid(LE_PARTY_CATEGORY_INSTANCE) or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			channel = "INSTANCE_CHAT";
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			channel = "RAID";
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			channel = "PARTY";
		else
		end
		if val[1] > 0 then
			local d;
			local _, t = IsInInstance();
			if t == 'raid' then
				d = GetRaidDifficultyID() or '14';
			else
				d = GetDungeonDifficultyID() or '2';
			end
			local link = "\124cff66bbff\124Hjournal:1:" .. val[1] .. ":" .. d .. "\124h[" .. (val[2] or val[1]) .. "]\124h\124r";
			if channel ~= nil then
				SendChatMessage(_PREFIX .. link .. _SUFFIX, channel);
			else
				ChatFrame1:AddMessage(_PREFIX .. link .. _SUFFIX);
			end
		else
			if channel ~= nil then
				SendChatMessage(_PREFIX .. val[2] .. _SUFFIX, channel);
			else
				ChatFrame1:AddMessage(_PREFIX .. val[2] .. _SUFFIX);
			end
		end
		if channel ~= nil then
			for index = 3, #val do
				SendChatMessage(val[index], channel);
			end
		else
			for index = 3, #val do
				ChatFrame1:AddMessage(val[index]);
			end
		end
	end
	menu:Hide();
end
local function update()
	if current ~= nil then
		local num = #current;
		local w = -1;
		for index = 1, num do
			local ele = pool[index];
			if ele == nil then
				ele = CreateFrame("BUTTON", nil, menu);
				ele:SetHeight(BUTTON_HEIGHT);
				ele:SetPoint("TOPLEFT", 0, -(BUTTON_HEIGHT + BUTTON_INTERVAL) * (index - 1));
				ele:SetHighlightTexture("Interface\\TargetingFrame\\UI-StatusBar");
				ele:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.0, 0.75);
				local text = ele:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
				text:SetPoint("LEFT", 2, 0);
				text:SetTextColor(0.9, 0.9, 0.9, 0.9);
				ele.text = text;
				ele.id = index;
				ele:SetScript("OnClick", OnClick);
				pool[index] = ele;
			else
				ele:Show();
			end
			local val = current[index];
			ele.text:SetText(val[2]);
			w = max(ele.text:GetWidth() + 4, w);
		end
		for index = 1, num do
			pool[index]:SetWidth(w);
		end
		menu:SetSize(w, num * (BUTTON_HEIGHT + BUTTON_INTERVAL));
		if num < #pool then
			for index = num + 1, #pool do
				pool[index]:Hide();
			end
		end
	end
end

main:SetScript("OnClick", function(self, button)
	if menu:IsShown() then
		menu:Hide();
	else
		menu:Show();
		menu:ClearAllPoints();
		local l, r, t, b = main:GetLeft(), main:GetRight(), main:GetTop(), main:GetBottom();
		local w, h = UIParent:GetSize();
		if l + r > w then
			if t + b > h then
				menu:SetPoint("TOPRIGHT", main, "BOTTOMLEFT", -2, -2);
			else
				menu:SetPoint("BOTTOMRIGHT", main, "TOPLEFT", -2, 2);
			end
		else
			if t + b > h then
				menu:SetPoint("TOPLEFT", main, "BOTTOMRIGHT", 2, -2)
			else
				menu:SetPoint("BOTTOMLEFT", main, "TOPRIGHT", 2, 2);
			end
		end
	end
end);

local function hook_dwchat()
	-- local dw = LibStub('AceAddon-3.0'):GetAddon('DuowanChat'):GetModule("CHATFRAME");
	if DWCPullButton then
		main:ClearAllPoints();
		main:SetPoint("LEFT", DWCPullButton, "RIGHT", 1, 0);
	end
end

local _EventHandler = CreateFrame("FRAME");
local function OnEvent(self, event, arg1)
	if event == "LOADING_SCREEN_DISABLED" then
		local inInstance, instanceType
				= IsInInstance();
		if inInstance then
			local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceID, instanceGroupSize, LfgDungeonID
					= GetInstanceInfo();
			current = _STRATEGY_DATA[instanceID];
			if current ~= nil then
				main:Show();
				update();
			else
				main:Hide();
			end
		else
			main:Hide();
		end
	elseif event == "ADDON_LOADED" and arg1 == "DuowanChat" then
		hook_dwchat();
		_EventHandler:UnregisterEvent("ADDON_LOADED");
	end
end
_EventHandler:SetScript("OnEvent", OnEvent);

_EventHandler:RegisterEvent("LOADING_SCREEN_DISABLED");
if IsAddOnLoaded("DuowanChat") then
	hook_dwchat();
else
	_EventHandler:RegisterEvent("ADDON_LOADED");
end

