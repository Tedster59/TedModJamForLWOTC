class X2Ability_FrostTech extends X2Ability config(GameData_SoldierSkills);

var config float GREMLIN_PERK_EFFECT_WINDOW; // seconds
var config float GREMLIN_ARRIVAL_TIMEOUT;   //  seconds

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(ScanningProtocolFrostTech());
	Templates.AddItem(MZIceVestStatsDummy());
	Templates.AddItem(InsulatedWeaveStats());
	Templates.AddItem(BioViperAcidBloodDummy());
	Templates.Additem(BlindImmunity());

	return Templates;
}

static function X2AbilityTemplate MZIceVestStatsDummy()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('MZIceVestStatsDummy', "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate BioViperAcidBloodDummy()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('BioViperAcidBloodDummy', "img:///UILibrary_PerkIcons.UIPerk_burn",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate InsulatedWeaveStats()
{

	local X2AbilityTemplate				Template;
	local X2Effect_DamageImmunity               ImmunityEffect;

	Template = PurePassive('InsulatedWeaveStats', "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest",, 'eAbilitySource_Perk');

	ImmunityEffect = new class'X2Effect_DamageImmunity';
	ImmunityEffect.EffectName = 'InsulatedWeaveImmunity';
	ImmunityEffect.ImmuneTypes.AddItem('Frost');
	ImmunityEffect.BuildPersistentEffect(1, true, false, false);
	ImmunityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true, , Template.AbilitySourceName);
	Template.AddTargetEffect(ImmunityEffect);

	return Template;
}

static function X2AbilityTemplate BlindImmunity()
{

	local X2AbilityTemplate				Template;
	local X2Effect_DamageImmunity               ImmunityEffect;

	Template = PurePassive('BlindImmunity', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	ImmunityEffect = new class'X2Effect_DamageImmunity';
	ImmunityEffect.EffectName = 'InsulatedWeaveImmunity';
	ImmunityEffect.ImmuneTypes.AddItem('Blind');
	ImmunityEffect.BuildPersistentEffect(1, true, false, false);
	ImmunityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true, , Template.AbilitySourceName);
	Template.AddTargetEffect(ImmunityEffect);

	return Template;
}

static function X2AbilityTemplate ScanningProtocolFrostTech()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityMultiTarget_Radius		RadiusMultiTarget;
	local X2Effect_PersistentSquadViewer    ViewerEffect;
	local X2Effect_ScanningProtocol			ScanningEffect;
	local X2AbilityCost_Charges				ChargeCost;
	local X2Condition_UnitProperty			CivilianProperty;
	local X2AbilityCooldown_LocalAndGlobal  Cooldown;
	local X2Effect_Persistent				AllSeeingEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ScanningProtocolFrostTech');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sensorsweep";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;

	Template.AbilityCharges = new class'X2AbilityCharges_ScanningProtocol';

	// Cooldown on the ability
	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 1;
	Cooldown.NumGlobalTurns = 1;
	Template.AbilityCooldown = Cooldown;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.Additem(ChargeCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AbilityTargetStyle = default.SelfTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bUseWeaponRadius = true;
	RadiusMultiTarget.bIgnoreBlockingCover = true; // skip the cover checks, the squad viewer will handle this once selected
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	ScanningEffect = new class'X2Effect_ScanningProtocol';
	ScanningEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	ScanningEffect.TargetConditions.AddItem(default.LivingHostileUnitOnlyProperty);
	Template.AddMultiTargetEffect(ScanningEffect);

	ScanningEffect = new class'X2Effect_ScanningProtocol';
	ScanningEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	CivilianProperty = new class'X2Condition_UnitProperty';
	CivilianProperty.ExcludeNonCivilian = true;
	CivilianProperty.ExcludeHostileToSource = false;
	CivilianProperty.ExcludeFriendlyToSource = false;
	ScanningEffect.TargetConditions.AddItem(CivilianProperty);
	Template.AddMultiTargetEffect(ScanningEffect);

	AllSeeingEffect = new class'X2Effect_Persistent';
    AllSeeingEffect.BuildPersistentEffect(1, true, false, false);
    AllSeeingEffect.EffectName = 'ScanningProtocolFrostTech';
    AllSeeingEffect.DuplicateResponse = eDupe_Ignore;
    AllSeeingEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, , , Template.AbilitySourceName);
    AllSeeingEffect.UnitBreaksConcealmentIgnoringDistanceFn = UnitBreaksConcealmentIgnoringDistance_PERKNAME;
    Template.AddShooterEffect(AllSeeingEffect);

	Template.TargetingMethod = class'X2TargetingMethod_TopDown';

	ViewerEffect = new class'X2Effect_PersistentSquadViewer';
	ViewerEffect.bUseSourceLocation = true;
	ViewerEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	Template.AddShooterEffect(ViewerEffect);

	Template.bStationaryWeapon = true;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.bSkipPerkActivationActions = true;

	Template.ActivationSpeech = 'ScanningProtocol';
	Template.PostActivationEvents.AddItem('ItemRecalled');
	Template.BuildNewGameStateFn = SendGremlinToOwnerLocation_BuildGameState;
	Template.BuildVisualizationFn = GremlinScanningProtocol_BuildVisualization;
	Template.CinescriptCameraType = "Specialist_ScanningProtocol";
	
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'ScanningProtocol'
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
//END AUTOGENERATED CODE: Template Overrides 'ScanningProtocol'

	return Template;
}

static function bool UnitBreaksConcealmentIgnoringDistance_PERKNAME()
{
    return true;
}

simulated function GremlinScanningProtocol_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local X2AbilityTemplate             AbilityTemplate;
	local StateObjectReference          InteractingUnitRef;
	local XComGameState_Item			GremlinItem;
	local XComGameState_Unit			GremlinUnitState, ShooterState;
	local XComGameState_Ability         AbilityState;
	local array<PathPoint> Path;

	local VisualizationActionMetadata        EmptyTrack;
	local VisualizationActionMetadata        ActionMetadata;
	local X2Action_WaitForAbilityEffect DelayAction;

	local int EffectIndex, MultiTargetIndex;
	local PathingInputData              PathData;
	local PathingResultData				ResultData;
	local X2Action_RevealArea			RevealAreaAction;
	local TTile TargetTile;
	local vector TargetPos;

	local X2Action_PlayAnimation PlayAnimation;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID, , VisualizeGameState.HistoryIndex));
	AbilityTemplate = AbilityState.GetMyTemplate();

	GremlinItem = XComGameState_Item(History.GetGameStateForObjectID(Context.InputContext.ItemObject.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
	GremlinUnitState = XComGameState_Unit(History.GetGameStateForObjectID(GremlinItem.CosmeticUnitRef.ObjectID, , VisualizeGameState.HistoryIndex - 1));

	//Configure the visualization track for the shooter
	//****************************************************************************************

	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.SourceObject;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);
	ShooterState = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	class'X2Action_IntrusionProtocolSoldier'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	/*for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityShooterEffects.Length; ++EffectIndex)
	{
		AbilityTemplate.AbilityShooterEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, Context.FindShooterEffectApplyResult(AbilityTemplate.AbilityShooterEffects[EffectIndex]));
	}*/

	
	//Configure the visualization track for the gremlin
	//****************************************************************************************
	InteractingUnitRef = GremlinUnitState.GetReference();

	ActionMetadata = EmptyTrack;
	History.GetCurrentAndPreviousGameStatesForObjectID(GremlinUnitState.ObjectID, ActionMetadata.StateObject_OldState, ActionMetadata.StateObject_NewState, , VisualizeGameState.HistoryIndex);
	ActionMetadata.VisualizeActor = GremlinUnitState.GetVisualizer();

	class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	// Given the target location, we want to generate the movement data.  
	TargetTile = ShooterState.TileLocation;
	TargetPos = `XWORLD.GetPositionFromTileCoordinates(TargetTile);

	class'X2PathSolver'.static.BuildPath(GremlinUnitState, GremlinUnitState.TileLocation, TargetTile, PathData.MovementTiles);
	class'X2PathSolver'.static.GetPathPointsFromPath(GremlinUnitState, PathData.MovementTiles, Path);
	class'XComPath'.static.PerformStringPulling(XGUnitNativeBase(ActionMetadata.VisualizeActor), Path);
	PathData.MovingUnitRef = GremlinUnitState.GetReference();
	PathData.MovementData = Path;
	Context.InputContext.MovementPaths.AddItem(PathData);
	class'X2TacticalVisibilityHelpers'.static.FillPathTileData(PathData.MovingUnitRef.ObjectID,	PathData.MovementTiles,	ResultData.PathTileData);
	Context.ResultContext.PathResults.AddItem(ResultData);
	class'X2VisualizerHelpers'.static.ParsePath(Context, ActionMetadata);
	class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	RevealAreaAction = X2Action_RevealArea(class'X2Action_RevealArea'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	RevealAreaAction.TargetLocation = TargetPos;
	RevealAreaAction.ScanningRadius = GremlinItem.GetItemRadius(AbilityState) * class'XComWorldData'.const.WORLD_METERS_TO_UNITS_MULTIPLIER / class'XComWorldData'.const.WORLD_StepSize;
	
	PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	PlayAnimation.Params.AnimName = 'NO_ScanningProtocol';
	
	DelayAction = X2Action_WaitForAbilityEffect(class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	DelayAction.ChangeTimeoutLength(default.GREMLIN_PERK_EFFECT_WINDOW);

	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	//****************************************************************************************

	//Configure the visualization track for the target
	//****************************************************************************************
	for (MultiTargetIndex = 0; MultiTargetIndex < Context.InputContext.MultiTargets.Length; ++MultiTargetIndex)
	{
		InteractingUnitRef = Context.InputContext.MultiTargets[MultiTargetIndex];
		ActionMetadata = EmptyTrack;
		ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
		ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

		DelayAction = X2Action_WaitForAbilityEffect(class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		DelayAction.ChangeTimeoutLength(default.GREMLIN_ARRIVAL_TIMEOUT);       //  give the gremlin plenty of time to show up

		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityMultiTargetEffects.Length; ++EffectIndex)
		{
			AbilityTemplate.AbilityMultiTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, Context.FindMultiTargetEffectApplyResult(AbilityTemplate.AbilityMultiTargetEffects[EffectIndex], MultiTargetIndex));
		}

	}
	//****************************************************************************************
}

function XComGameState SendGremlinToOwnerLocation_BuildGameState( XComGameStateContext Context )
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState NewGameState;
	local XComGameState_Item GremlinItemState;
	local XComGameState_Unit GremlinUnitState, OwnerUnitState;

	AbilityContext = XComGameStateContext_Ability(Context);
	NewGameState = TypicalAbility_BuildGameState(Context);

	GremlinItemState = XComGameState_Item(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.ItemObject.ObjectID));
	if (GremlinItemState == none)
	{
		GremlinItemState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', AbilityContext.InputContext.ItemObject.ObjectID));
	}
	GremlinUnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(GremlinItemState.CosmeticUnitRef.ObjectID));
	if (GremlinUnitState == none)
	{
		GremlinUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', GremlinItemState.CosmeticUnitRef.ObjectID));
	}
	OwnerUnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	
	`assert(GremlinItemState != none && GremlinUnitState != none && OwnerUnitState != none);

	GremlinItemState.AttachedUnitRef.ObjectID = OwnerUnitState.ObjectID;
	GremlinUnitState.SetVisibilityLocation(OwnerUnitState.TileLocation);

	return NewGameState;
}