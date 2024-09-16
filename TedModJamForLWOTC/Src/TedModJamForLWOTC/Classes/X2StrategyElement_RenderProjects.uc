class X2StrategyElement_RenderProjects extends X2StrategyElement_DefaultTechs config(GameData);

var config int RENDER_REWARD_ADVENTCRYOPRIEST_CORPSE;
var config int RENDER_REWARD_ADVENTCRYOROCKETEER_CORPSE;
var config int RENDER_REWARD_ADVENTPURGEPRIEST_CORPSE;
var config int RENDER_REWARD_ADVENTEXALTEDPURGEBISHOP_CORPSE;
var config int RENDER_REWARD_BIOTROOPER_CORPSE;
var config int RENDER_REWARD_BIOOFFICER_CORPSE;
var config int RENDER_REWARD_BIOMEC_WRECK;
var config int RENDER_REWARD_BIOBARRIERTROOPER_CORPSE;
var config int RENDER_REWARD_BIO_CANISTER;
var config int RENDER_REWARD_BIOVIPER_CORPSE;
var config int RENDER_REWARD_ELITEBIOVIPER_CORPSE;
var config int RENDER_REWARD_BIOZERKER_CORPSE;
var config int RENDER_REWARD_BIOFACELESS_CORPSE;
var config int RENDER_REWARD_BIOASSAULTTROOPER_CORPSE;
var config int RENDER_REWARD_BIOROCKETTROOPER_CORPSE;
var config int RENDER_REWARD_BIOGENERAL_CORPSE;
var config int RENDER_REWARD_FLAMEVIPER_CORPSE;
var config int RENDER_REWARD_MUTONDESTROYER_CORPSE;
var config int RENDER_REWARD_CELATID_CORPSE;
var config int RENDER_REWARD_BLACKFLAMEGRENADE_REMAINS;
var config int RENDER_REWARD_ADVENTDUELIST_CORPSE;
var config int RENDER_REWARD_ADVENTSNIPER_CORPSE;
var config int RENDER_REWARD_PATHFINDER_CORPSE;
var config int RENDER_REWARD_PATHFINDERCAPTAIN_CORPSE;
var config int RENDER_REWARD_PATHFINDER_SCANNER;
var config int RENDER_REWARD_CHOSENPATHFINDER_SCANNER;
var config int RENDER_REWARD_PATHFINDERCAPTAIN_STUNMINE;
var config int RENDER_REWARD_CHOSENPATHFINDERCAPTAIN_HALLUCINOGENICROUNDS;
var config int RENDER_REWARD_ADVENTWARLOCK_CORPSE;
var config int RENDER_REWARD_PHASEDRONE_WRECK;
var config int RENDER_REWARD_CUSTODIAN_CORPSE;
var config int RENDER_REWARD_CUSTODIANMK2_CORPSE;
var config int RENDER_REWARD_CUSTODIANMASTER_CORPSE;
var config int RENDER_REWARD_EXALTEDCUSTODIAN_CORPSE;
var config int RENDER_REWARD_EXALTEDCUSTODIANGRANDMASTER_CORPSE;
var config int RENDER_REWARD_ADVENTASSAULTTROOPERT1_CORPSE;
var config int RENDER_REWARD_ADVENTASSAULTTROOPERT2_CORPSE;
var config int RENDER_REWARD_ADVENTASSAULTTROOPERT3_CORPSE;
var config int RENDER_REWARD_ADVENTASSAULTTROOPERCAPTAIN_CORPSE;
var config int RENDER_REWARD_GATLINGMEC_WRECK;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Techs.AddItem(CreateRenderTech ('RenderBioCanister', "img:///UILibrary_StrategyImages.ScienceIcons.IC_Elerium", 'BioCanister', 500, 'HybridMaterials', 'AlienAlloy'));
	Techs.AddItem(CreateRenderTech ('RenderBioViperSilverCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioViper", 'CorpseBioViper', 600, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioViperGoldCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioViper", 'CorpseEliteBioViper', 600, 'AlienBiotech', 'EleriumDust'));
	Techs.AddItem(CreateRenderTech ('RenderBioZerkerCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioZerker", 'CorpseBioZerker', 600, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioTrooperCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioTrooper", 'CorpseAdvBioTrooper', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioOfficerCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioCaptain", 'CorpseAdvBioOfficer', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioAssaultTrooperCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioAssault", 'CorpseAdvBioAssaultTrooper', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioBarrierTrooperCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioAssault", 'CorpseAdvBioBarrierTrooper', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioRocketTrooperCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioRocket", 'CorpseAdvBioRocketTrooper', 600, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioMECWreck', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyMEC", 'CorpseBioMec', 600, 'HybridMaterials'));
	Techs.AddItem(CreateRenderTech ('RenderBioFacelessCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioFaceless", 'CorpseBioFaceless', 600, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderBioGeneralCorpse', "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioCaptain", 'CorpseAdvBioGeneral', 500, 'AlienBiotech', 'EleriumDust'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('MutonHarriers'))
    {
	Techs.AddItem(CreateRenderTech ('RenderGrenadeRemains', "img:///WoTC_Muton_Harrier_UI.Autopsy_BlackFlameGrenadeImage", 'CorpseGrenadeRemains', 500, 'HybridMaterials', 'AlienAlloy'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WotC_AshlynneFlameViper'))
    {
	Techs.AddItem(CreateRenderTech ('RenderFlameViperCorpse', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyViper", 'Corpse_AshFlameViper', 600, 'AlienBiotech'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WotC_AshlynneMutonDestroyer'))
    {
	Techs.AddItem(CreateRenderTech ('RenderMutonDestroyerCorpse', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyMuton", 'Corpse_AshMutonDestroyer', 600, 'AlienBiotech'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CelatidAlien'))
	{
	Techs.AddItem(CreateRenderTech ('RenderCelatidCorpse', "img:///StenchCelatid.textures.IC_AutopsyCelatid", 'CorpseCelatid', 300, 'AlienBiotech'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AdventDuelist_WoTC'))
	{
	Techs.AddItem(CreateRenderTech ('RenderAdventDuelistCorpse', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyAdventTrooper", 'CorpseAdventDuelist', 500, 'AlienBiotech'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AdventSniper_WoTC'))
	{
	Techs.AddItem(CreateRenderTech ('RenderAdventSniperCorpse', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyAdventStunLancer", 'CorpseAdventSniper', 500, 'AlienBiotech'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WoTCPathfinders'))
	{
	Techs.AddItem(CreateRenderTech ('RenderPathfinderCorpse', "img:///WoTC_Pathfinder_Strategy_UI.Autopsy.Autopsy_PathfinderAutopsyImage", 'CorpseAdventPathfinder', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderPathfinderCaptainCorpse', "img:///WoTC_Pathfinder_Strategy_UI.Autopsy.Autopsy_PathfinderHunterAutopsyImage", 'CorpseAdventPathfinderCaptain', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderPathfinderScanner', "img:///WoTC_Pathfinder_Strategy_UI.Autopsy.Autopsy_PathfinderSmartScanner", 'CorpseAdventPathfinderScanner', 300, 'HybridMaterials'));
	Techs.AddItem(CreateRenderTech ('RenderChosenPathfinderScanner', "img:///WoTC_Pathfinder_Strategy_UI.Autopsy.Autopsy_ChosenSmartScannerImage", 'CorpseChosenAdventPathfinderScanner', 300, 'HybridMaterials', 'EleriumDust'));
	Techs.AddItem(CreateRenderTech ('RenderPathfinderCaptainStunMine', "img:///WoTC_Pathfinder_Strategy_UI.Autopsy.Autopsy_PathfinderHunterStunMine", 'CorpseAdventPathfinderCaptainStunMine', 300, 'HybridMaterials', 'EleriumDust'));
	Techs.AddItem(CreateRenderTech ('RenderChosenPathfinderCaptainHallucinogenicRounds', "img:///WoTC_Pathfinder_Strategy_UI.Autopsy.Autopsy_ChosenPathfinderHunterTerrorRounds", 'CorpseChosenAdventPathfinderCaptainHallucinogenicRounds', 300, 'HybridMaterials', 'AlienAlloy'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CustodianPack'))
    {
	Techs.AddItem(CreateRenderTech ('RenderCustodianCorpse', "img:///WoTC_CustodianPack_UI.Autopsy_CustodianAutopsyImage", 'CorpseCustodian', 900, 'AlienBiotech', 'EleriumCore'));
	Techs.AddItem(CreateRenderTech ('RenderCustodianMK2Corpse', "img:///WoTC_CustodianPack_UI.Autopsy_CustodianMk2AutopsyImage", 'CorpseCustodianMK2', 950, 'AlienBiotech', 'EleriumCore'));
	Techs.AddItem(CreateRenderTech ('RenderCustodianMasterCorpse', "img:///WoTC_CustodianPack_UI.Autopsy_CustodianMasterAutopsyImage", 'CorpseCustodianMaster', 1000, 'AlienBiotech', 'EleriumCore'));
	Techs.AddItem(CreateRenderTech ('RenderExaltedCustodianCorpse', "img:///WoTC_CustodianPack_UI.Autopsy_ExaltedCustodianAutopsyImage", 'CorpseExaltedCustodian', 1050, 'AlienBiotech', 'EleriumCore'));
	Techs.AddItem(CreateRenderTech ('RenderExaltedCustodianGrandmasterCorpse', "img:///WoTC_CustodianPack_UI.Autopsy_ExaltedCustodianGrandmasterAutopsyImage", 'CorpseExaltedCustodianGrandmaster', 1100, 'AlienBiotech', 'EleriumCore'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PurgePriests'))
	{
	Techs.AddItem(CreateRenderTech ('RenderAdventPurgePriestCorpse', "img:///UILibrary_XPACK_StrategyImages.IC_Priest", 'CorpseAdventPurgePriest', 800, 'AlienBiotech', 'EleriumCore'));
	Techs.AddItem(CreateRenderTech ('RenderAdventExaltedPurgeBishopCorpse', "img:///UILibrary_XPACK_StrategyImages.IC_Priest", 'CorpseAdventExaltedPurgeBishop', 900, 'AlienBiotech', 'EleriumCore'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CryoPriest') || class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('ABetterADVENTDLC'))
    {
	Techs.AddItem(CreateRenderTech ('RenderAdventCryoPriestCorpse', "img:///UILibrary_XPACK_StrategyImages.IC_Priest", 'CorpseAdventCryoPriest', 600, 'AlienBiotech', 'AlienAlloy'));
	Techs.AddItem(CreateRenderTech ('RenderAdventCryoRocketeerCorpse', "img:///UILibrary_XPACK_StrategyImages.IC_Priest", 'CorpseAdventCryoRocketeer', 600, 'AlienBiotech', 'AlienAlloy'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WotC_AshlynneAdvWarlock'))
    {
	Techs.AddItem(CreateRenderTech ('RenderAdventWarlockCorpse', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyAdventTrooper", 'Corpse_AshAdvWarlock', 600, 'AlienBiotech', 'MZFD_Cryolite'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AdventCommandos'))
    {
	Techs.AddItem(CreateRenderTech ('RenderPhaseDroneWreck', "img:///UILib_AdventCommando.Tex_PsyDrone_tech", 'CorpsePsiDrone', 300, 'HybridMaterials', 'EleriumDust'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AssTroopers'))
	{
	Techs.AddItem(CreateRenderTech ('RenderAssaultTrooperT1Corpse', "img:///WoTC_Advent_Assault_Trooper_UI.Autopsy_T1Trooper", 'CorpseT1AssaultTrooper', 500, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderAssaultTrooperT2Corpse', "img:///WoTC_Advent_Assault_Trooper_UI.Autopsy_T2Trooper", 'CorpseT2AssaultTrooper', 550, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderAssaultTrooperT3Corpse', "img:///WoTC_Advent_Assault_Trooper_UI.Autopsy_T3Trooper", 'CorpseT3AssaultTrooper', 600, 'AlienBiotech'));
	Techs.AddItem(CreateRenderTech ('RenderAssaultTrooperCaptainCorpse', "img:///WoTC_Advent_Assault_Trooper_UI.Autopsy_CaptnTrooper", 'CorpseCaptnAssaultTrooper', 650, 'AlienBiotech'));
	}

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('GatlingMec'))
	{
	Techs.AddItem(CreateRenderTech ('RenderGatlingMECWreck', "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyMEC", 'CorpseGatlingMec', 600, 'HybridMaterials'));
	}

	return Techs;
}

static function X2DataTemplate CreateRenderTech (name TechName, string strImage, name ItemName, int PointsToComplete, optional name ReqTech, optional name BonusItemName)
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, TechName);
	Template.PointsToComplete = PointsToComplete;
	Template.RepeatPointsIncrease = 0;
	Template.SortingTier = 3;
	Template.bRepeatable = true;

	Template.Requirements.bVisibleIfTechsNotMet = false;
	Template.Requirements.bVisibleIfItemsNotMet = false;

	Template.strImage = strImage;
	if (ReqTech != '')
		Template.Requirements.RequiredTechs.AddItem(ReqTech);

	Template.Requirements.RequiredItems.AddItem(ItemName);

	Artifacts.ItemTemplateName = ItemName;
	Artifacts.Quantity = 1;

	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	if (BonusItemName != '')
		Template.ItemRewards.AddItem (BonusItemName);

	Template.ResearchCompletedFn = RenderTechCompleted;

	return Template;
}

function RenderTechCompleted(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local string Techname;
	local name RewardType;
	local int RewardAmount, TechID;
	local X2ItemTemplateManager ItemTemplateManager;
	local X2ItemTemplate ItemTemplate;

	History = `XCOMHISTORY;

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if(XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);
	}

	TechName = string(TechState.GetMyTemplateName());

	switch (TechName)
	{
		case "RenderBioCanister":									RewardType = 'EleriumDust';		RewardAmount = default.RENDER_REWARD_BIO_CANISTER; break;
		case "RenderFlameViperCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_FLAMEVIPER_CORPSE; break;
		case "RenderBioViperSilverCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOVIPER_CORPSE; break;
		case "RenderBioViperGoldCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ELITEBIOVIPER_CORPSE; break;
		case "RenderMutonDestroyerCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_MUTONDESTROYER_CORPSE; break;
		case "RenderBioZerkerCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOZERKER_CORPSE; break;
		case "RenderGrenadeRemains":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BLACKFLAMEGRENADE_REMAINS; break;
		case "RenderBioFacelessCorpse":								RewardType = 'EleriumDust';		RewardAmount = default.RENDER_REWARD_BIOFACELESS_CORPSE; break;
		case "RenderCelatidCorpse":									RewardType = 'EleriumDust';		RewardAmount = default.RENDER_REWARD_CELATID_CORPSE; break;
		case "RenderAdventDuelistCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTDUELIST_CORPSE; break;
		case "RenderAdventSniperCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTSNIPER_CORPSE; break;
		case "RenderPathfinderCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_PATHFINDER_CORPSE; break;
		case "RenderPathfinderCaptainCorpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_PATHFINDERCAPTAIN_CORPSE; break;
		case "RenderBioTrooperCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOTROOPER_CORPSE; break;
		case "RenderBioAssaultTrooperCorpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOASSAULTTROOPER_CORPSE; break;
		case "RenderBioOfficerCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOOFFICER_CORPSE; break;
		case "RenderBioBarrierTrooperCorpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOBARRIERTROOPER_CORPSE; break;
		case "RenderBioRocketTrooperCorpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOROCKETTROOPER_CORPSE; break;
		case "RenderBioMECWreck":									RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOMEC_WRECK; break;
		case "RenderCustodianCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_CUSTODIAN_CORPSE; break;
		case "RenderCustodianMK2Corpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_CUSTODIANMK2_CORPSE; break;
		case "RenderCustodianMasterCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_CUSTODIANMASTER_CORPSE; break;
		case "RenderExaltedCustodianCorpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_EXALTEDCUSTODIAN_CORPSE; break;
		case "RenderExaltedCustodianGrandmasterCorpse":				RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_EXALTEDCUSTODIANGRANDMASTER_CORPSE; break;
		case "RenderAdventPurgePriestCorpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTPURGEPRIEST_CORPSE; break;
		case "RenderAdventExaltedPurgeBishopCorpse":				RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTEXALTEDPURGEBISHOP_CORPSE; break;
		case "RenderBioGeneralCorpse":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_BIOGENERAL_CORPSE; break;
		case "RenderAdventWarlockCorpse":							RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTWARLOCK_CORPSE; break;
		case "RenderAdventCryoPriestCorpse":						RewardType = 'MZFD_Cryolite'; 	RewardAmount = default.RENDER_REWARD_ADVENTCRYOPRIEST_CORPSE; break;
		case "RenderAdventCryoRocketeerCorpse":						RewardType = 'MZFD_Cryolite'; 	RewardAmount = default.RENDER_REWARD_ADVENTCRYOROCKETEER_CORPSE; break;
		case "RenderPhaseDroneWreck":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_PHASEDRONE_WRECK; break;
		case "RenderPathfinderScanner":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_PATHFINDER_SCANNER; break;
		case "RenderChosenPathfinderScanner":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_CHOSENPATHFINDER_SCANNER; break;
		case "RenderPathfinderCaptainStunMine":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_PATHFINDERCAPTAIN_STUNMINE; break;
		case "RenderChosenPathfinderCaptainHallucinogenicRounds":	RewardType = 'EleriumDust';		RewardAmount = default.RENDER_REWARD_CHOSENPATHFINDERCAPTAIN_HALLUCINOGENICROUNDS; break;
		case "RenderAssaultTrooperT1Corpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTASSAULTTROOPERT1_CORPSE; break;
		case "RenderAssaultTrooperT2Corpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTASSAULTTROOPERT2_CORPSE; break;
		case "RenderAssaultTrooperT3Corpse":						RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTASSAULTTROOPERT3_CORPSE; break;
		case "RenderAssaultTrooperCaptainCorpse":					RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_ADVENTASSAULTTROOPERCAPTAIN_CORPSE; break;
		case "RenderGatlingMECWreck":								RewardType = 'AlienAlloy'; 		RewardAmount = default.RENDER_REWARD_GATLINGMEC_WRECK; break;

		default: break;
	}

	TechID = TechState.ObjectID;
	TechState = XComGameState_Tech(NewGameState.GetGameStateForObjectID(TechID));

	if(TechState == none)
	{
		TechState = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech', TechID));
		NewGameState.AddStateObject(TechState);
	}

	// Contrary to its name
	TechState.IntelReward = RewardAmount;
	XCOMHQ.AddResource(NewGameState, RewardType, RewardAmount);

	if (TechState.GetMyTemplate().ItemRewards.length > 0)
	{
		//`LWTRACE("ITEM REWARD HIT");

		ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
		ItemTemplate = ItemTemplateManager.FindItemTemplate(TechState.GetMyTemplate().ItemRewards[TechState.GetMyTemplate().ItemRewards.length-1]);
		class'XComGameState_HeadquartersXCom'.static.GiveItem(NewGameState, ItemTemplate);
		TechState.ItemRewards.AddItem(ItemTemplate);
		TechState.bSeenResearchCompleteScreen = false;
	}
}