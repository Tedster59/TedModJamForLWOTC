class X2Character_CryoPriestM1 extends X2Character_DefaultCharacters config(GameData_CharacterStats);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CryoPriest') || class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('ABetterADVENTDLC'))
    {
	Templates.AddItem(CreateTemplate_AdventCryoPriestM1());
	}
	return Templates;
}

static function X2CharacterTemplate CreateTemplate_AdventCryoPriestM1()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'AdventCryoPriestM1');
	CharTemplate.CharacterGroupName = 'AdventPurifier';
	CharTemplate.DefaultLoadout = 'AdventCryoPriestM1_Loadout';
	CharTemplate.strBehaviorTree = "AdventCryoPriest_ABA::CharacterRoot";
	CharTemplate.BehaviorClass = class'XGAIBehavior';
    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CryoPriest'))
    {
	CharTemplate.strPawnArchetypes.AddItem("CryoPriestContent.ARC_GameUnit_CryoPriest_M");
	CharTemplate.strPawnArchetypes.AddItem("CryoPriestContent.ARC_GameUnit_CryoPriest_F");
	}
    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('ABetterADVENTDLC'))
    {
	CharTemplate.strPawnArchetypes.AddItem("CryoPriest.ARC_GameUnit_CryoPriest_M");
	CharTemplate.strPawnArchetypes.AddItem("CryoPriest.ARC_GameUnit_CryoPriest_F");
	}
	// Auto-Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdventCryoPriestM1_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdvPurifierM1_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'AdvPurifierM1_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	CharTemplate.strMatineePackages.AddItem("CIN_Advent");
	CharTemplate.strMatineePackages.AddItem("CIN_XP_Advent");
	CharTemplate.RevealMatineePrefix = "CIN_Advent_Purifier";
	CharTemplate.GetRevealMatineePrefixFn = GetAdventMatineePrefix;

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = true;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = false;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;
	CharTemplate.bSetGenderAlways = true;
	CharTemplate.bCanTakeCover = true;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = false;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = false;

	CharTemplate.Abilities.AddItem('DarkEventAbility_SealedArmor');
	CharTemplate.Abilities.AddItem('DarkEventAbility_UndyingLoyalty');
	CharTemplate.Abilities.AddItem('DarkEventAbility_Barrier');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_captain_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}