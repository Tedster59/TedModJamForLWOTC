class X2Ability_BioSabers extends X2Ability config(Shields);

var config int SHIELD_MOBILITY_PENALTY;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(ToxinSlashM1());
	Templates.AddItem(ReflexSlash());
	Templates.AddItem(ReflexSlashAttack());
	Templates.AddItem(CreateToxinSlashM1ImpairEffectAbility());
	Templates.AddItem(BioShieldMobilityPenalty());

	return Templates;
}

static function X2AbilityTemplate ToxinSlashM1()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Condition_UnitProperty          TargetPropertyCondition;
	local X2Condition_UnitProperty          ShooterPropertyCondition;
	local X2AbilityTarget_MovingMelee       MeleeTarget;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local X2AbilityCooldown                 Cooldown;
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ToxinSlashM1');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventstunlancer_stunlance";

	Template.AdditionalAbilities.AddItem('ToxinSlashM1Impair');

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	Template.AbilityTargetStyle = MeleeTarget;

	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_PlayerInput');
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	// Target Conditions
	//
	TargetPropertyCondition = new class'X2Condition_UnitProperty';	
	TargetPropertyCondition.ExcludeDead = true;                     //Can't target dead
	TargetPropertyCondition.ExcludeFriendlyToSource = true;         //Can't target friendlies
	Template.AbilityTargetConditions.AddItem(TargetPropertyCondition);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	// Shooter Conditions
	//
	ShooterPropertyCondition = new class'X2Condition_UnitProperty';	
	ShooterPropertyCondition.ExcludeDead = true;                    //Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(ShooterPropertyCondition);

	Template.AddShooterEffectExclusions();

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StandardMelee';

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 2;
	Template.AbilityCooldown = Cooldown;

	//Impairing effects need to come before the damage. This is needed for proper visualization ordering.
	//Effect on a successful melee attack is triggering the Apply Impairing Effect Ability
	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'ImmediateStunImpair';
	ImpairingAbilityEffect.AbilityName = 'ToxinSlashM1Impair';
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = ImpairingAbilityEffectTriggeredVisualization;
	Template.AddTargetEffect(ImpairingAbilityEffect);

	// Damage Effect
	//
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.DamageTypes.AddItem('Electrical');
	Template.AddTargetEffect(WeaponDamageEffect);

	//Add Poison as a single target effect
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

	Template.bSkipMoveStop = true;

	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	//Template.CinescriptCameraType = "AdvStunLancer_StunLancer";	

    Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	//if (AbilityName == 'AssaultStun')
	//	Template.PostActivationEvents.AddItem('StunLanceActivated');

	Template.bFrameEvenWhenUnitIsHidden = true;


	return Template;
}

static function X2AbilityTemplate ReflexSlash()
{
	local X2AbilityTemplate                 Template;

	Template = PurePassive('ReflexSlash', "img:///UILibrary_PerkIcons.UIPerk_bladestorm", false, 'eAbilitySource_Perk');
	Template.AdditionalAbilities.AddItem('ReflexSlashAttack');

	return Template;
}

static function X2AbilityTemplate ReflexSlashAttack(name TemplateName = 'ReflexSlashAttack')
{
	local X2AbilityTemplate                 Template;
	local X2AbilityToHitCalc_StandardMelee  ToHitCalc;
	local X2AbilityTrigger_EventListener	Trigger;
	local X2Effect_Persistent               BladestormTargetEffect;
	local X2Condition_UnitEffectsWithAbilitySource BladestormTargetCondition;
	local X2Condition_UnitProperty          SourceNotConcealedCondition;
	local X2Condition_Visibility			TargetVisibilityCondition;
	local X2Condition_UnitEffects			UnitEffectsCondition;
	local X2Condition_NotItsOwnTurn			NotItsOwnTurnCondition;
	local X2Condition_UnitProperty			ExcludeSquadmatesCondition;
	local X2AbilityCooldown					Cooldown;
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_bladestorm";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_CAPTAIN_PRIORITY;

	Template.AdditionalAbilities.AddItem('ToxinSlashM1Impair');

	ToHitCalc = new class'X2AbilityToHitCalc_StandardMelee';
	ToHitCalc.bReactionFire = true;
	Template.AbilityToHitCalc = ToHitCalc;
	Template.AbilityTargetStyle = default.SimpleSingleMeleeTarget;

	NotItsOwnTurnCondition = new class'X2Condition_NotItsOwnTurn';
	Template.AbilityShooterConditions.AddItem(NotItsOwnTurnCondition);

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

	//Impairing effects need to come before the damage. This is needed for proper visualization ordering.
	//Effect on a successful melee attack is triggering the Apply Impairing Effect Ability
	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'ImmediateStunImpair';
	ImpairingAbilityEffect.AbilityName = 'ToxinSlashM1Impair';
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = ImpairingAbilityEffectTriggeredVisualization;
	Template.AddTargetEffect(ImpairingAbilityEffect);

	Template.bAllowBonusWeaponEffects = true;
	Template.AddTargetEffect(new class'X2Effect_ApplyWeaponDamage');

	//Add Poison as a single target effect
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

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

	BladestormRef = ConcealmentBrokenUnit.FindAbility('BladestormAttack');
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

static function X2DataTemplate CreateToxinSlashM1ImpairEffectAbility()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityToHitCalc_StatCheck_UnitVsUnit    StatContest;
	local X2AbilityTarget_Single            SingleTarget;
	local X2Effect_Persistent               DisorientedEffect;
	local X2Effect_Stunned				    StunnedEffect;
	local X2Effect_Persistent               UnconsciousEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ToxinSlashM1Impair');

	Template.bDontDisplayInAbilitySummary = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_Placeholder');      //  ability is activated by another ability that hits

	// Target Conditions
	//
	Template.AbilityTargetConditions.AddItem(default.LivingTargetUnitOnlyProperty);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	// Shooter Conditions
	//
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	Template.AddShooterEffectExclusions();

	// This will be a stat contest
	StatContest = new class'X2AbilityToHitCalc_StatCheck_UnitVsUnit';
	StatContest.AttackerStat = eStat_Strength;
	Template.AbilityToHitCalc = StatContest;

	// On hit effects
	//  Stunned effect for 1 or 2 unblocked hit
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.MinStatContestResult = 1;
	DisorientedEffect.MaxStatContestResult = 2;
	DisorientedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(DisorientedEffect);

	//  Stunned effect for 3 or 4 unblocked hit
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, 100, false);
	StunnedEffect.MinStatContestResult = 3;
	StunnedEffect.MaxStatContestResult = 4;
	StunnedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(StunnedEffect);

	//  3-action stun effect for 5 unblocked hits
	UnconsciousEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(3, 100, false);
	UnconsciousEffect.MinStatContestResult = 5;
	UnconsciousEffect.MaxStatContestResult = 0;
	UnconsciousEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(UnconsciousEffect);

	Template.bSkipPerkActivationActions = true;
	Template.bSkipPerkActivationActionsSync = false;
	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = StunLancerImpairing_BuildVisualization;

	return Template;
}

simulated function StunLancerImpairing_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference InteractingUnitRef;
	local VisualizationActionMetadata EmptyTrack;
	local VisualizationActionMetadata ActionMetadata;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

}

static function ImpairingAbilityEffectTriggeredVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameStateContext Context;
	local XComGameStateContext_Ability TestAbilityContext;
	local int i, j, ChildIndex;
	local XComGameStateHistory History;
	local bool bAbilityWasSuccess;
	local X2AbilityTemplate AbilityTemplate;
	local X2VisualizerInterface TargetVisualizerInterface;
	local XComGameStateVisualizationMgr VisMgr;
	local X2Action_ApplyWeaponDamageToUnit DamageAction;
	local X2Action TempAction;
	local X2Action_MarkerNamed HitReactAction;

	if( (EffectApplyResult != 'AA_Success') || (XComGameState_Unit(ActionMetadata.StateObject_NewState) == none) )
	{
		return;
	}

	Context = VisualizeGameState.GetContext();
	AbilityContext = XComGameStateContext_Ability(Context);

	if( AbilityContext.EventChainStartIndex != 0 )
	{
		History = `XCOMHISTORY;

		// This GameState is part of a chain, which means there may be a stun to the target
		for( i = AbilityContext.EventChainStartIndex; !Context.bLastEventInChain; ++i )
		{
			Context = History.GetGameStateFromHistory(i).GetContext();

			TestAbilityContext = XComGameStateContext_Ability(Context);
			bAbilityWasSuccess = (TestAbilityContext != none) && class'XComGameStateContext_Ability'.static.IsHitResultHit(TestAbilityContext.ResultContext.HitResult);

			if( bAbilityWasSuccess &&
				TestAbilityContext.InputContext.AbilityTemplateName == 'ToxinSlashM1Impair' &&
				TestAbilityContext.InputContext.SourceObject.ObjectID == AbilityContext.InputContext.SourceObject.ObjectID &&
				TestAbilityContext.InputContext.PrimaryTarget.ObjectID == AbilityContext.InputContext.PrimaryTarget.ObjectID )
			{
				// The Melee Impairing Ability has been found with the same source and target
				// Move that ability's visualization forward to this track
				AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(TestAbilityContext.InputContext.AbilityTemplateName);

				for( j = 0; j < AbilityTemplate.AbilityTargetEffects.Length; ++j )
				{
					AbilityTemplate.AbilityTargetEffects[j].AddX2ActionsForVisualization(TestAbilityContext.AssociatedState, ActionMetadata, TestAbilityContext.FindTargetEffectApplyResult(AbilityTemplate.AbilityTargetEffects[j]));
				}

				TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
				if (TargetVisualizerInterface != none)
				{
					TargetVisualizerInterface.BuildAbilityEffectsVisualization(Context.AssociatedState, ActionMetadata);
				}

				VisMgr = `XCOMVISUALIZATIONMGR;

				DamageAction = X2Action_ApplyWeaponDamageToUnit(VisMgr.GetNodeOfType(VisMgr.BuildVisTree, class'X2Action_ApplyWeaponDamageToUnit', ActionMetadata.VisualizeActor));

				if( DamageAction.ChildActions.Length > 0 )
				{
					HitReactAction = X2Action_MarkerNamed(class'X2Action_MarkerNamed'.static.AddToVisualizationTree(ActionMetadata, AbilityContext, true, DamageAction));
					HitReactAction.SetName("ImpairingReact");
					HitReactAction.AddInputEvent('Visualizer_AbilityHit');

					for( ChildIndex = 0; ChildIndex < DamageAction.ChildActions.Length; ++ChildIndex )
					{
						TempAction = DamageAction.ChildActions[ChildIndex];
						VisMgr.DisconnectAction(TempAction);
						VisMgr.ConnectAction(TempAction, VisMgr.BuildVisTree, false, , DamageAction.ParentActions);
					}

					VisMgr.DisconnectAction(DamageAction);
					VisMgr.ConnectAction(DamageAction, VisMgr.BuildVisTree, false, ActionMetadata.LastActionAdded);
				}

				break;
			}
		}
	}
}

static function X2AbilityTemplate BioShieldMobilityPenalty()
{
	local X2AbilityTemplate Template;
	local X2Effect_PersistentStatChange PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BioShieldMobilityPenalty');
	Template.IconImage = "img:///WoTC_Shield_UI.BallisticShield_Icon";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false, , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.SHIELD_MOBILITY_PENALTY);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}