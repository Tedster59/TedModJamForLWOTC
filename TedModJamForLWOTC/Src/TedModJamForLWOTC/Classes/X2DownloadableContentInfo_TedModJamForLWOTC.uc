//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_TedModJamForLWOTC.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_TedModJamForLWOTC extends X2DownloadableContentInfo config(Game);

var config array<name> IncludedHumanoidTemplates;
var config array<LootTable> ModJamStealCorpsesLootEntry;
var config array<name> PULLANDBIND_EXCLUDE_CHARACTER_GROUPS;

var config array<MissionDefinition> ReplacementMissionDefs;

var config bool IMMOLATOR_DESTROYSLOOT;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{
    AddTechGameStates();
}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{}

// True Primary Secondaries is trying to give primary Whippit Shotguns a magazine size of 6. This is not okay, so I'm not letting Whippit Shotguns into the primary slot at all.

static function bool UnitIsHumanoid(const XComGameState_Unit UnitState)
{
	return default.IncludedHumanoidTemplates.Find(UnitState.GetMyTemplateName()) != INDEX_NONE;
}

static function bool CanAddItemToInventory_CH_Improved(
    out int bCanAddItem,                   // out value for XComGameState_Unit
    const EInventorySlot Slot,             // Inventory Slot you're trying to equip the Item into
    const X2ItemTemplate ItemTemplate,     // Item Template of the Item you're trying to equip
    int Quantity, 
    XComGameState_Unit UnitState,          // Unit State of the Unit you're trying to equip the Item on
    optional XComGameState CheckGameState, 
    optional out string DisabledReason,    // out value for the UIArmory_Loadout
    optional XComGameState_Item ItemState) // Item State of the Item we're trying to equip
{
	local XGParamTag	LocTag;

	local bool OverrideNormalBehavior;
    local bool DoNotOverrideNormalBehavior;

    // Prepare return values to make it easier for us to read the code.
    OverrideNormalBehavior = CheckGameState != none;
    DoNotOverrideNormalBehavior = CheckGameState == none;

	if(DisabledReason != "")
    return DoNotOverrideNormalBehavior;

	// do the filtering only if trying to...
	if(UnitIsHumanoid(UnitState) &&	//	equip something on your humanoid class
		Slot == eInvSlot_PrimaryWeapon || Slot == eInvSlot_SecondaryWeapon)	// into the primary or secondary slot
	{
		if (ItemTemplate.DataName == 'WHIPPITSHOTGUN')
		{

			// if we're trying to equip one of these items
			// we build a message that will be shown to the player stating that this item is not available to the alien class
			LocTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
			LocTag.StrValue0 = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager().FindSoldierClassTemplate(UnitState.GetSoldierClassTemplateName()).DisplayName;
			DisabledReason = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(`XEXPAND.ExpandString(class'UIArmory_Loadout'.default.m_strNeedsSoldierClass));

			bCanAddItem = 0;

			return OverrideNormalBehavior; // and disallow equipping the item
		}

	}

	 // in all other cases don't do any filtering.
	return DoNotOverrideNormalBehavior;
}

// This is that thing RustyDios gave me for Buildable Units PG projects, it probably needs to be here too, I don't really know though

static event OnLoadedSavedGameToStrategy()
{
    AddTechGameStates();
}

static function AddTechGameStates()
{
    local XComGameStateHistory History;
    local XComGameState NewGameState;
    local X2TechTemplate TechTemplate;
    local X2StrategyElementTemplateManager    StratMgr;

    //This adds the techs to games that installed the mod in the middle of a campaign.
    StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
    History = `XCOMHISTORY;    

    //Create a pending game state change
    NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding Mod Jam Tech Templates");

    //Find tech templates .... repeat block as needed
    if ( !IsResearchInHistory('NeurotoxinGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('NeurotoxinGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('NeurotoxinBombProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('NeurotoxinBombProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioAlloyPlatingProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioAlloyPlatingProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioRocketLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioRocketLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioBlasterLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioBlasterLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioDemonweaveProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioDemonweaveProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioCyaneaSuitProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioCyaneaSuitProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioNanoscaleVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioNanoscaleVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BioViperScaleVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BioViperScaleVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AdvancedBioViperScaleVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AdvancedBioViperScaleVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('RadRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('RadRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('CorrosiveRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('CorrosiveRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdvBioTrooper') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdvBioTrooper'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdvBioBarrierTrooper') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdvBioBarrierTrooper'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdvBioOfficer') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdvBioOfficer'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyBioMec') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyBioMec'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZScabWeaveProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZScabWeaveProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZBubbleWeaveProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZBubbleWeaveProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZRepairWeaveProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZRepairWeaveProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('PsiArmorTech_LW') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('PsiArmorTech_LW'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZMicroRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZMicroRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZScrambleRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZScrambleRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZEnervativeRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZEnervativeRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MZAntiVioletRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MZAntiVioletRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdventCryoPriest') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdventCryoPriest'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdventCryoRocketeer') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdventCryoRocketeer'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BitterfrostRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BitterfrostRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BitterfrostGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BitterfrostGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BitterfrostBombProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BitterfrostBombProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('CryoLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('CryoLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('CryoLauncherMk2Project') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('CryoLauncherMk2Project'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('FrostweaveProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('FrostweaveProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('CustodianAPRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('CustodianAPRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('HyperdriveVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('HyperdriveVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('DestroyerGauntletProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('DestroyerGauntletProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AdaptedLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AdaptedLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('ArcherLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('ArcherLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('SmokeLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('SmokeLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('SupportLauncherProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('SupportLauncherProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('WraithVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('WraithVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('PurgePlatingProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('PurgePlatingProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdventPurgePriest') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdventPurgePriest'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('AutopsyAdventExaltedPurgeBishop') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('AutopsyAdventExaltedPurgeBishop'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('FlameScaleVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('FlameScaleVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('SeethingRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('SeethingRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('RippleRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('RippleRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('BlackFlameGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('BlackFlameGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('PhantomSlayerRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('PhantomSlayerRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('DestroyerVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('DestroyerVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('ConcussionGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('ConcussionGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('MagneticGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('MagneticGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('LaserGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('LaserGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('RadiationGrenadeProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('RadiationGrenadeProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('RadiationRoundsProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('RadiationRoundsProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('LeadVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('LeadVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

	if ( !IsResearchInHistory('LeadHazmatVestProject') )
    {
        TechTemplate = X2TechTemplate(StratMgr.FindStrategyElementTemplate('LeadHazmatVestProject'));
        NewGameState.CreateNewStateObject(class'XComGameState_Tech', TechTemplate);
    }

    if( NewGameState.GetNumGameStateObjects() > 0 )
    {
        //Commit the state change into the history.
        History.AddGameStateToHistory(NewGameState);
    }
    else
    {
        History.CleanupPendingGameState(NewGameState);
    }
}

static function bool IsResearchInHistory(name ResearchName)
{
    // Check if we've already injected the tech templates
    local XComGameState_Tech    TechState;
    
    foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Tech', TechState)
    {
        if ( TechState.GetMyTemplateName() == ResearchName )
        {
            return true;
        }
    }
    return false;
}

static function bool IsModActive(name ModName)
{
    local XComOnlineEventMgr    EventManager;
    local int                   Index;

    EventManager = `ONLINEEVENTMGR;

    for (Index = EventManager.GetNumDLC() - 1; Index >= 0; Index--) 
    {
        if (EventManager.GetDLCNames(Index) == ModName) 
        {
            return true;
        }
    }
    return false;
}

static function bool IsModInactive(name ModName)
{
    local XComOnlineEventMgr    EventManager;
    local int                   Index;

    EventManager = `ONLINEEVENTMGR;

    for (Index = EventManager.GetNumDLC() - 1; Index >= 0; Index--) 
    {
        if (EventManager.GetDLCNames(Index) == ModName) 
        {
            return false;
        }
    }
    return true;
}

static function AddLootTables()
{
	local X2LootTableManager	LootManager;
	local LootTable				LootBag;
	local LootTableEntry		Entry;
	
	LootManager = X2LootTableManager(class'Engine'.static.FindClassDefaultObject("X2LootTableManager"));

	Foreach default.ModJamStealCorpsesLootEntry(LootBag)
	{
		if ( LootManager.default.LootTables.Find('TableName', LootBag.TableName) != INDEX_NONE )
		{
			foreach LootBag.Loots(Entry)
			{
				class'X2LootTableManager'.static.AddEntryStatic(LootBag.TableName, Entry, true);
			}
		}	
	}
}

//static event OnPostTemplatesCreated()
//{
//	AddLootTables();
//}

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireSparkFlamethrower'));
	//`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireSparkFlamethrowerOverwatch'));
	//`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireThrower'));
	//`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireThrowerOverwatchShot'));
	//`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireCanisterActivate'));
	//`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZBlastCanisterActivate'));
	//`LOG("a flamethrower single effect was searched",,'flame_ability');

	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('Justice'));
	`LOG("a pull single effect was searched",,'pull_ability');
	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('DestroyerPull'));
	`LOG("a pull single effect was searched",,'pull_ability');
	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('PullFromHarm'));
	`LOG("a pull single effect was searched",,'pull_ability');
	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('GetOverHere'));
	`LOG("a pull single effect was searched",,'pull_ability');
	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('Bind'));
	`LOG("a pull single effect was searched",,'pull_ability');
	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDAdderRushAndBind'));
	`LOG("a pull single effect was searched",,'pull_ability');
	AdjustPullAbility(AbilityTemplateManager.FindAbilityTemplate('GetOverHereAlly'));
	`LOG("a pull single effect was searched",,'pull_ability');

	PatchLimitBreak(AbilityTemplateManager.FindAbilityTemplate('DP_LimitBreak'));
	PatchLastStand(AbilityTemplateManager.FindAbilityTemplate('ShadowOps_LastStand'));

	AddLootTables();

	PatchAbilityForBotnet('PistolStandardShot');

	FixCouriers();
	FixBotnet('StandardShot');
	FixBotnet('SniperStandardFire');
	FixBotnet('PistolStandardShot');

	FixSidewinderSMGs('PA_SidewinderGun');
	FixSidewinderSMGs('PA_SidewinderGunLaser');
	FixSidewinderSMGs('PA_SidewinderGunMagnetic');
	FixSidewinderSMGs('PA_SidewinderGunCoil');
	FixSidewinderSMGs('PA_SidewinderGunBeam');

	ReplaceSchedules();
}
 
static function AdjustFlamethrowerAbility(X2AbilityTemplate Template)
{
    local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
    local X2Effect                          TempEffect;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //single target effects
        foreach Template.AbilityTargetEffects( TempEffect )
        {
            if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
            {
                WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                WeaponDamageEffect.bExplosiveDamage = default.IMMOLATOR_DESTROYSLOOT;
                //`LOG("a flamethrower single effect was adjusted",,'flame_loot');
            }
        }
    
        //multitarget effects
        foreach Template.AbilityMultiTargetEffects( TempEffect )
        {
            if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
            {
                WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                WeaponDamageEffect.bExplosiveDamage = default.IMMOLATOR_DESTROYSLOOT;
                //`LOG("a flamethrower multi effect was adjusted",,'flame_loot');
            }
        }
    }

}

static function AdjustPullAbility(X2AbilityTemplate Template)
{
	local X2Condition_UnitType					UnitTypeCondition;
	local X2Condition_MetionBattlesuitEquipped	MetionBattlesuitCondition;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		UnitTypeCondition = new class'X2Condition_UnitType';
		UnitTypeCondition.ExcludeTypes = default.PULLANDBIND_EXCLUDE_CHARACTER_GROUPS;
		Template.AbilityTargetConditions.AddItem(UnitTypeCondition);
		`LOG("a pull single effect was adjusted",,'pull_effect');

		MetionBattlesuitCondition = new class'X2Condition_MetionBattlesuitEquipped';
		Template.AbilityTargetConditions.AddItem(MetionBattlesuitCondition);
		`LOG("a pull single effect was adjusted",,'pull_effect');
    }
}


static function FixCouriers()
{
	local X2CharacterTemplateManager	CharacterMgr;
	local array<X2DataTemplate>			DataTemplates;
	local X2DataTemplate				DataTemplate;
	local X2CharacterTemplate			CharTemplate;
	local LootReference					Loot;

	CharacterMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	CharacterMgr.FindDataTemplateAllDifficulties('Advent_Courier', DataTemplates);

	foreach DataTemplates(DataTemplate)
	{
		CharTemplate = X2CharacterTemplate(DataTemplate);

		if(CharTemplate != none)
		{
			Loot.ForceLevel = 0;
			Loot.LootTableName = 'AdventCourier_BaseLoot';

			CharTemplate.TimedLoot.LootReferences.Length = 0;
			CharTemplate.VultureLoot.LootReferences.Length = 0;

			CharTemplate.TimedLoot.LootReferences.AddItem(Loot);
			CharTemplate.VultureLoot.LootReferences.AddItem(Loot);
		}
	}
}

static function PatchAbilityForBotnet(name AbilityName)
{
	local X2AbilityTemplate Template;

	Template = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(AbilityName);

	if (Template != none)
	{
		Template.AddTargetEffect(class'X2Ability_ShadowOpsCharge'.static.BotnetEffect());
	}
}

static function FixBotnet(name TemplateName)
{
	local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2AbilityTemplate Template;
	local X2Effect Effect;
	local X2Effect_PersistentStatChange StatChangeEffect;
	local X2Condition Condition;
	local X2Condition_UnitEffectsOnSource SourceCondition;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	Template = AbilityTemplateManager.FindAbilityTemplate('TemplateName');

	if(Template != none)
	{
		foreach Template.AbilityTargetEffects (Effect)
		{
			if(Effect != none)
			{
				StatChangeEffect = X2Effect_PersistentStatChange(Effect);

				if(StatChangeEffect != none)
				{
					foreach StatChangeEffect.TargetConditions (Condition)
					{
						if(Condition != none)
						{
							SourceCondition = X2Condition_UnitEffectsOnSource(Condition);
							
							if(SourceCondition != none)
							{
								if(SourceCondition.RequireEffects[0].EffectName == 'F_Botnet_Valid')
								{
									StatChangeEffect.DuplicateResponse = eDupe_Allow;
								}
							}
						}
					}
				}
			}
		}
	}

}

static function FixSidewinderSMGs(Name TemplateName)
{
	 local X2ItemTemplateManager    ItemMgr;
     local array<X2DataTemplate>    DataTemplates;
     local X2DataTemplate       DataTemplate;
     local X2WeaponTemplate     Template;

     ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
     ItemMgr.FindDataTemplateAllDifficulties(TemplateName, DataTemplates);

     foreach DataTemplates(DataTemplate)
     {
        Template = X2WeaponTemplate(DataTemplate);

        if(Template != none)
		{
			Template.strImage = "img:///LWSidewinderSMG.LWBeamSMG_Common";
		}
	}
}

static function PatchLimitBreak(X2AbilityTemplate Template)
{
	if(Template != none)
	{
		Template.PrerequisiteAbilities.AddItem('NOT_ShadowOps_LastStand');
	}
}

static function PatchLastStand(X2AbilityTemplate Template)
{
	if (Template != none)
	{
		Template.PrerequisiteAbilities.AddItem('NOT_DP_LimitBreak');
	}
}

exec function Ted_CheckPsiAbilitiesLength()
{
	local UIArmory							Armory;
	local StateObjectReference				UnitRef;
	local XComGameState_Unit				UnitState;
	
	Armory = UIArmory(`SCREENSTACK.GetFirstInstanceOf(class'UIArmory'));
	if (Armory == none)
	{
		class'Helpers'.static.OutputMsg("No unit selected - cannot respec soldier");
		return;
	}

	UnitRef = Armory.GetUnitRef();
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
	if (UnitState == none)
	{
		class'Helpers'.static.OutputMsg("No unit selected - cannot respec soldier");
		return;
	}

	class'Helpers'.static.OutputMsg("Selected Unit Psi Abilities Length:" @UnitState.PsiAbilities.Length);

}


static function bool ShouldUpdateMissionSpawningInfo(StateObjectReference MissionRef)
{
	local XComGameState_MissionSite MissionState;

	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(MissionRef.ObjectID));

	// Waterworld hardcode here
	if(MissionState.GetMissionSource().DataName == 'MissionSource_Final')
	{
		`Log("Updating waterworld caching.",,'TedLog');
		return true;
	}

	return false;
}


static function ReplaceSchedules()
{
	local XComTacticalMissionManager MissionManager;
	local int MissionIdx;
	local string MissionFamilyName;
	local MissionDefinition CurrentMissionDef;

	MissionManager = `TACTICALMISSIONMGR;

	foreach default.ReplacementMissionDefs (CurrentMissionDef)
	{
		MissionFamilyName = CurrentMissionDef.MissionFamily;
		MissionIdx = MissionManager.arrMissions.Find('MissionFamily', MissionFamilyName);
		if(MissionIdx != -1)
		{
			if(MissionManager.arrMissions[MissionIdx].MissionFamily == CurrentMissionDef.MissionFamily && MissionManager.arrMissions[MissionIdx].sType == CurrentMissionDef.sType &&  MissionManager.arrMissions[MissionIdx].MissionName == CurrentMissionDef.MissionName)
			{
				MissionManager.arrMissions[MissionIdx].MissionSchedules = CurrentMissionDef.MissionSchedules;
				`Log("Replacing mission def for mission " @CurrentMissionDef.MissionName @"Mission Family" @ CurrentMissionDef.MissionFamily,, 'WWLog');
			}
			else
			{
				`Log("replacement Mission Name or Mission sType didn't match for mission family" @CurrentMissionDef.MissionFamily,, 'WWLog'); 
			}
		}
		else
		{
			`Log("Couldn't find base missiondef to replace for family" @CurrentMissionDef.MissionFamily,, 'WWLog');
		}
	}

}


static function bool UpdateMissionSpawningInfo(StateObjectReference MissionRef)
{
	local XComGameState_MissionSite MissionState;
	local MissionDefinition MissionDef;
	local XComGameState NewGameState;

	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(MissionRef.ObjectID));

	// Waterworld hardcoded here.
	if(MissionState.GetMissionSource().DataName == 'MissionSource_Final')
	{

		// LW waterworld hardcode here:
		`TACTICALMISSIONMGR.GetMissionDefinitionForType("GP_Fortress_LW", MissionDef);

		// Hardcode checking for MJ schedules
		if(instr(MissionState.SelectedMissionData.SelectedMissionScheduleName, "LW_TJ") != -1)
		{
			return false;
		}

		`Log("Mission Def schedule 1:" @MissionDef.MissionSchedules[0],, 'TedLog');

		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Update Mission Data");

		MissionState = XComGameState_MissionSite(NewGameState.ModifyStateObject(class'XComGameState_MissionSite', MissionState.ObjectID));
		MissionState.SelectedMissionData.SelectedMissionScheduleName = Name(MissionState.SelectedMissionData.SelectedMissionScheduleName $ "_TJ");
		MissionState.GeneratedMission.Mission.MissionSchedules = MissionDef.MissionSchedules;
	
		`Log("Updating waterworld cached missiondef.",,'TedLog');

		`GAMERULES.SubmitGameState(NewGameState);

		return true;
	}

	return false;
}