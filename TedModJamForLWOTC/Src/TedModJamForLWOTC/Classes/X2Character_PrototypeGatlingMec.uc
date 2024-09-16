// This is an Unreal Script
class X2Character_PrototypeGatlingMec extends X2Character_DefaultCharacters;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('GatlingMec'))
    {
	Templates.AddItem(CreateTemplate_PrototypeGatlingMec());
	}
return Templates;
}

static function X2CharacterTemplate CreateTemplate_PrototypeGatlingMec()
{
	local X2CharacterTemplate CharTemplate;
	local LootReference Loot;

	`CREATE_X2CHARACTER_TEMPLATE(CharTemplate, 'PrototypeGatlingMec');
	CharTemplate.CharacterGroupName = 'GatlingMec';
	CharTemplate.DefaultLoadout='PrototypeGatlingMec_Loadout';
	CharTemplate.BehaviorClass=class'XGAIBehavior';
	CharTemplate.strBehaviorTree = "GatlingMecModJamRoot";
	///XComAlienPawn'WoTC_Advent_Gatling_MEC.Archetypes.ARC_Gatling_Mec'
	CharTemplate.strPawnArchetypes.AddItem("WoTC_Advent_Gatling_MEC.Archetypes.ARC_Gatling_Mec");
	Loot.ForceLevel=0;
	Loot.LootTableName='GatlingMec_BaseLoot';
	CharTemplate.Loot.LootReferences.AddItem(Loot);

	// Timed Loot
	Loot.ForceLevel = 0;
	Loot.LootTableName = 'AdvMEC_M2_TimedLoot';
	CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
	Loot.LootTableName = 'AdvMEC_M2_VultureLoot';
	CharTemplate.VultureLoot.LootReferences.AddItem(Loot);

	//CharTemplate.strMatineePackages.AddItem("CIN_AdventMEC");
	//CharTemplate.strTargetingMatineePrefix = "CIN_AdventMEC_FF_StartPos";

	CharTemplate.strMatineePackages.AddItem("CIN_GatlingMEC");
	CharTemplate.RevealMatineePrefix = "CIN_GatlingMEC";

	CharTemplate.UnitSize = 1;

	// Traversal Rules
	CharTemplate.bCanUse_eTraversal_Normal = true;
	CharTemplate.bCanUse_eTraversal_ClimbOver = true;
	CharTemplate.bCanUse_eTraversal_ClimbOnto = true;
	CharTemplate.bCanUse_eTraversal_ClimbLadder = false;
	CharTemplate.bCanUse_eTraversal_DropDown = true;
	CharTemplate.bCanUse_eTraversal_Grapple = false;
	CharTemplate.bCanUse_eTraversal_Landing = true;
	CharTemplate.bCanUse_eTraversal_BreakWindow = true;
	CharTemplate.bCanUse_eTraversal_KickDoor = true;
	CharTemplate.bCanUse_eTraversal_JumpUp = true;
	CharTemplate.bCanUse_eTraversal_WallClimb = false;
	CharTemplate.bCanUse_eTraversal_BreakWall = false;
	CharTemplate.bAppearanceDefinesPawn = false;    
	CharTemplate.bCanTakeCover = false;
	CharTemplate.bAllowRushCam = false;

	CharTemplate.bIsAlien = false;
	CharTemplate.bIsAdvent = true;
	CharTemplate.bIsCivilian = false;
	CharTemplate.bIsPsionic = false;
	CharTemplate.bIsRobotic = true;
	CharTemplate.bIsSoldier = false;

	CharTemplate.bCanBeTerrorist = false;
	CharTemplate.bCanBeCriticallyWounded = false;
	CharTemplate.bIsAfraidOfFire = true;
	CharTemplate.bFacesAwayFromPod = true;
	CharTemplate.AcquiredPhobiaTemplate = 'FearOfMecs';

	//CharTemplate.strScamperBT = "ScamperRoot_NoCover";
	CharTemplate.strScamperBT = "ScamperRoot_Overwatch";

	CharTemplate.Abilities.AddItem('RobotImmunities');
	CharTemplate.Abilities.AddItem('DarkEventAbility_Barrier');

	CharTemplate.strHackIconImage = "UILibrary_Common.TargetIcons.Hack_robot_icon";
	CharTemplate.strTargetIconImage = class'UIUtilities_Image'.const.TargetIcon_Advent;

	return CharTemplate;
}