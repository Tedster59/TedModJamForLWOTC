// Mitzruti wrote the Ice Shield part; this version just exists so Mod Jam can mess with the value for the damage reduction
// Except it doesn't fucking work for some reason
// But hey at least there's a new Flail ability for the zombies now

class X2Ability_FrostLegion extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(FDIceShield_MJ());
	Templates.AddItem(ZombieFlail());
	Templates.AddItem(ZombieFlailAttack());
	Templates.AddItem(CreateRemoveSpectralFrostZombies());

	return Templates;
}

static function X2AbilityTemplate FDIceShield_MJ()
{
	local X2AbilityTemplate						Template;
	local X2Effect_IceShield_MJ       DamageModifier;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MZ_FDIceShield_MJ');

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_DLC2Images.UIPerk_freezingbreath";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	DamageModifier = new class'X2Effect_IceShield_MJ';
	DamageModifier.BuildPersistentEffect(1, true, true, true);
	DamageModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(DamageModifier);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.bUniqueSource = true;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate ZombieFlail()
{
	local X2AbilityTemplate                 Template;

	Template = PurePassive('ZombieFlail', "img:///KetarosPkg_Abilities.UIPerk_hulk", false, 'eAbilitySource_Perk');
	Template.AdditionalAbilities.AddItem('ZombieFlailAttack');

	return Template;
}

static function X2AbilityTemplate ZombieFlailAttack(name TemplateName = 'ZombieFlailAttack')
{
	local X2AbilityTemplate                 Template;
	local X2AbilityToHitCalc_StandardMelee  ToHitCalc;
	local X2AbilityTrigger_EventListener	Trigger;
	local X2Effect_Persistent               BladestormTargetEffect;
	local X2Condition_UnitEffectsWithAbilitySource BladestormTargetCondition;
	local X2Condition_UnitProperty          SourceNotConcealedCondition;
	local X2Condition_Visibility			TargetVisibilityCondition;
	local X2Condition_UnitEffects			UnitEffectsCondition;
	local X2Condition_UnitProperty			ExcludeSquadmatesCondition;
	local X2AbilityCooldown                 Cooldown;
	local X2Condition_UnitProperty			AdjacencyCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_bladestorm";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY;

	ToHitCalc = new class'X2AbilityToHitCalc_StandardMelee';
	ToHitCalc.bReactionFire = true;
	Template.AbilityToHitCalc = ToHitCalc;
	Template.AbilityTargetStyle = default.SimpleSingleMeleeTarget;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;

	//  trigger on movement
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'ObjectMoved';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	Template.AbilityTriggers.AddItem(Trigger);
	//  trigger on an attack
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'AbilityActivated';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalAttackListener;
	Template.AbilityTriggers.AddItem(Trigger);

	//  it may be the case that enemy movement caused a concealment break, which made Bladestorm applicable - attempt to trigger afterwards
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.EventID = 'UnitConcealmentBroken';
	Trigger.ListenerData.Filter = eFilter_Unit;
	Trigger.ListenerData.EventFn = BladestormConcealmentListener;
	Trigger.ListenerData.Priority = 55;
	Template.AbilityTriggers.AddItem(Trigger);
	
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitDisallowMindControlProperty);
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility = true;
	TargetVisibilityCondition.bDisablePeeksOnMovement = true; //Don't use peek tiles for over watch shots	
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
	// Adding exclusion condition to prevent friendly bladestorm fire when panicked.
	ExcludeSquadmatesCondition = new class'X2Condition_UnitProperty';
	ExcludeSquadmatesCondition.ExcludeSquadmates = true;
	Template.AbilityTargetConditions.AddItem(ExcludeSquadmatesCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);	
	Template.AddShooterEffectExclusions();

	//Don't trigger when the source is concealed
	SourceNotConcealedCondition = new class'X2Condition_UnitProperty';
	SourceNotConcealedCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(SourceNotConcealedCondition);

	// Don't trigger if the unit has vanished
	UnitEffectsCondition = new class'X2Condition_UnitEffects';
	UnitEffectsCondition.AddExcludeEffect('Vanish', 'AA_UnitIsConcealed');
	UnitEffectsCondition.AddExcludeEffect('VanishingWind', 'AA_UnitIsConcealed');
	Template.AbilityShooterConditions.AddItem(UnitEffectsCondition);

	Template.bAllowBonusWeaponEffects = true;
	Template.AddTargetEffect(new class'X2Effect_ApplyWeaponDamage');

	class'BitterfrostHelper'.static.AddBitterfrostToTarget(Template);

	//Prevent repeatedly hammering on a unit with Bladestorm triggers.
	//(This effect does nothing, but enables many-to-many marking of which Bladestorm attacks have already occurred each turn.)
	BladestormTargetEffect = new class'X2Effect_Persistent';
	BladestormTargetEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
	BladestormTargetEffect.EffectName = 'BladestormTarget';
	BladestormTargetEffect.bApplyOnMiss = true; //Only one chance, even if you miss (prevents crazy flailing counter-attack chains with a Muton, for example)
	Template.AddTargetEffect(BladestormTargetEffect);
	
	BladestormTargetCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	BladestormTargetCondition.AddExcludeEffect('BladestormTarget', 'AA_DuplicateEffectIgnored');
	Template.AbilityTargetConditions.AddItem(BladestormTargetCondition);

	AdjacencyCondition = new class'X2Condition_UnitProperty';
	AdjacencyCondition.RequireWithinRange = true;
	AdjacencyCondition.WithinRange = 144; //1.5 tiles in Unreal units, allows attacks on the diag
	Template.AbilityTargetConditions.AddItem(AdjacencyCondition);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = BladeStorm_BuildVisualization;
	Template.bShowActivation = true;

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NormalChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	//BEGIN AUTOGENERATED CODE: Template Overrides 'BladestormAttack'
	Template.bFrameEvenWhenUnitIsHidden = true;
	//END AUTOGENERATED CODE: Template Overrides 'BladestormAttack'

	return Template;
}

//Must be static, because it will be called with a different object (an XComGameState_Ability)
//Used to trigger Bladestorm when the source's concealment is broken by a unit in melee range (the regular movement triggers get called too soon)
static function EventListenerReturn BladestormConcealmentListener(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit ConcealmentBrokenUnit;
	local StateObjectReference BladestormRef;
	local XComGameState_Ability BladestormState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	ConcealmentBrokenUnit = XComGameState_Unit(EventSource);	
	if (ConcealmentBrokenUnit == None)
		return ELR_NoInterrupt;

	//Do not trigger if the Bladestorm Ranger himself moved to cause the concealment break - only when an enemy moved and caused it.
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext().GetFirstStateInEventChain().GetContext());
	if (AbilityContext != None && AbilityContext.InputContext.SourceObject != ConcealmentBrokenUnit.ConcealmentBrokenByUnitRef)
		return ELR_NoInterrupt;

	BladestormRef = ConcealmentBrokenUnit.FindAbility('ZombieFlailAttack');
	if (BladestormRef.ObjectID == 0)
		return ELR_NoInterrupt;

	BladestormState = XComGameState_Ability(History.GetGameStateForObjectID(BladestormRef.ObjectID));
	if (BladestormState == None)
		return ELR_NoInterrupt;
	
	BladestormState.AbilityTriggerAgainstSingleTarget(ConcealmentBrokenUnit.ConcealmentBrokenByUnitRef, false);
	return ELR_NoInterrupt;
}

simulated function BladeStorm_BuildVisualization(XComGameState VisualizeGameState)
{
	// Build the first shot of Bladestorm's visualization
	TypicalAbility_BuildVisualization(VisualizeGameState);
}

static function X2DataTemplate CreateRemoveSpectralFrostZombies()
{
	local X2AbilityTemplate Template;
	local X2AbilityTrigger_EventListener EventListener;
	local X2Effect_RemoveEffects RemoveEffects;
	local X2Condition_UnitEffects MultiTargetCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RemoveSpectralFrostZombies');

	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_corrupt";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityMultiTargetStyle = new class'X2AbilityMultiTarget_AllUnits';

	// This ability fires when the unit takes damage
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitRemovedFromPlay';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.Priority = 75;	// We need this to happen before the unit is actually removed from play
	Template.AbilityTriggers.AddItem(EventListener);

	// Multi Targets - Remove all Daze status effects
	MultiTargetCondition = new class'X2Condition_UnitEffects';
	MultiTargetCondition.AddRequireEffect(class'X2Effect_SpectralFrostZombie'.default.EffectName, 'AA_MissingRequiredEffect');
	Template.AbilityMultiTargetConditions.AddItem(MultiTargetCondition);

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2Effect_SpectralFrostZombie'.default.EffectName);
	RemoveEffects.bCleanse = true;
	Template.AddMultiTargetEffect(RemoveEffects);

	Template.bSkipFireAction = true;
	Template.FrameAbilityCameraType = eCameraFraming_Never;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}