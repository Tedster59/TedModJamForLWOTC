// This is an Unreal Script
class X2StatusEffects_RipplingRifle extends X2StatusEffects config(MutonHarrier);

//PsiRipple

var name PsiRippleName;

var config int PSIRIPPLE_TURNS;
var config int PSIRIPPLE_INFECT_DISTANCE;
var config int PSIRIPPLE_INFECT_PERCENTAGE;
var config array<name> PSIRIPPLE_SPREAD_ALLOWED_UNIT_TYPES;
var config int PSIRIPPLE_SPREAD_MAX_ALLOWED;


var localized string PsiRippleFriendlyName;
var localized string PsiRippleFriendlyDesc;
var localized string PsiRippleEffectAcquiredString;
var localized string PsiRippleEffectTickedString;
var localized string PsiRippleEffectLostString;


var config string PsiRippleEnteredParticle_Name;
var config name PsiRippleEnteredSocket_Name;
var config name PsiRippleEnteredSocketsArray_Name;

var config string PsiRippleEnteredPerk_Name;



static function X2Effect_PsiRipple CreatePsiRippleStatusEffect(int DamagePerTick, int DamageSpreadPerTick)
{
	local X2Effect_PsiRipple PsiRippleEffect;
	local X2Condition_UnitProperty UnitPropCondition;

	PsiRippleEffect = new class'X2Effect_PsiRipple';
	PsiRippleEffect.EffectName = default.PsiRippleName;
	PsiRippleEffect.BuildPersistentEffect(default.PSIRIPPLE_TURNS,, false,,eGameRule_PlayerTurnBegin);
	PsiRippleEffect.SetDisplayInfo(ePerkBuff_Penalty, default.PsiRippleFriendlyName, default.PsiRippleFriendlyDesc, "img:///WoTC_Muton_Harrier_UI.UIPerk_Psionic_Rippling"); //Texture2D'WoTC_Muton_Harrier_UI.UIPerk_Psionic_Rippling'
	PsiRippleEffect.SetPsiRippleDamage(DamagePerTick, DamageSpreadPerTick, 'Psi');
	PsiRippleEffect.VisualizationFn = PsiRippleVisualization;
	PsiRippleEffect.EffectTickedVisualizationFn = PsiRippleVisualizationTicked;
	PsiRippleEffect.EffectRemovedVisualizationFn = PsiRippleVisualizationRemoved;
	PsiRippleEffect.bRemoveWhenTargetDies = true;
	PsiRippleEffect.DamageTypes.AddItem('Psi');
	PsiRippleEffect.DuplicateResponse = eDupe_Refresh;
	PsiRippleEffect.bCanTickEveryAction = true;
	PsiRippleEffect.EffectAppliedEventName = class'X2Effect_PsiRipple'.default.PsiRippleEffectAddedEventName;

	if (default.PsiRippleEnteredParticle_Name != "")
	{
		PsiRippleEffect.VFXTemplateName = default.PsiRippleEnteredParticle_Name;
		PsiRippleEffect.VFXSocket = default.PsiRippleEnteredSocket_Name;
		PsiRippleEffect.VFXSocketsArrayName = default.PsiRippleEnteredSocketsArray_Name;
	}
	PsiRippleEffect.PersistentPerkName = default.PsiRippleEnteredPerk_Name;

	PsiRippleEffect.EffectTickedFn = PsiRippleTicked;

	UnitPropCondition = new class'X2Condition_UnitProperty';
	UnitPropCondition.ExcludeFriendlyToSource = false;
	PsiRippleEffect.TargetConditions.AddItem(UnitPropCondition);

	return PsiRippleEffect;
}

static function X2Effect CreatePsiRippleSpreadEffect()
{
	local X2Effect PsiRippleSpreadEffect;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_Visibility TargetVisibilityCondition;

	// TODO: DISCUSS WITH DESIGN ON WHAT THE SPREAD BURNING DAMAGE SHOULD BE
	PsiRippleSpreadEffect = CreatePsiRippleStatusEffect(2, 0);

	PsiRippleSpreadEffect.ApplyChance = default.PSIRIPPLE_INFECT_PERCENTAGE;

	//Only want it to be able to spread to 1 target at a time
	//PsiRippleSpreadEffect.MultiTargetStatContestInfo.MaxNumberAllowed = default.PSIRIPPLE_SPREAD_MAX_ALLOWED;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeCivilian = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	PsiRippleSpreadEffect.TargetConditions.AddItem(UnitPropertyCondition);

	// don't allow PsiRipple to infect through walls
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bCannotPeek = true;
	PsiRippleSpreadEffect.TargetConditions.AddItem(TargetVisibilityCondition);

	return PsiRippleSpreadEffect;
}

// At start of each turn, PsiRipple units can set PsiRipple to nearby units.
function bool PsiRippleTicked(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit TargetUnit;
	local XComGameState_Unit PlayerUnit;

	local EffectAppliedData PsiRippleEffectAppliedData;
	local X2Effect PsiRippleSpreadEffect;

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (TargetUnit == none)
		return true; // effect is done

	// create the PsiRipple effect template
	PsiRippleSpreadEffect = CreatePsiRippleSpreadEffect();
	if (PsiRippleSpreadEffect == none)
		return true; // effect is done

	// iterate thorugh all player units
	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Unit', PlayerUnit)
	{
		// skip if it's the same unit
		if (PlayerUnit.ObjectID == TargetUnit.ObjectID)
			continue;

		// skip if unit is not within range
		if (PlayerUnit.TileDistanceBetween(TargetUnit) > default.PSIRIPPLE_INFECT_DISTANCE)
			continue;

		// skip if the unit is not an allowed type
		//if (default.PSIRIPPLE_SPREAD_ALLOWED_UNIT_TYPES.Find(PlayerUnit.GetMyTemplate().CharacterGroupName) == INDEX_NONE)
		//	continue;

		// make a copy of the ApplyEffectParameters, and set the source and target appropriately
		PsiRippleEffectAppliedData = ApplyEffectParameters;
		PsiRippleEffectAppliedData.SourceStateObjectRef = TargetUnit.GetReference();
		PsiRippleEffectAppliedData.TargetStateObjectRef = PlayerUnit.GetReference();

		if (PsiRippleSpreadEffect.ApplyEffect(PsiRippleEffectAppliedData, PlayerUnit, NewGameState) == 'AA_Success')
		{
			if (NewGameState.GetContext().PostBuildVisualizationFn.Find(PsiRippleSpreadVisualization) == INDEX_NONE)
				NewGameState.GetContext().PostBuildVisualizationFn.AddItem(PsiRippleSpreadVisualization);
		}
	}

	return false; // effect persists
}


static function PsiRippleSpreadVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameState_Effect EffectState;
	local XComGameState_Effect OldEffectState;
	local XComGameState_Unit EffectTarget;
	local X2VisualizerInterface VisualizerInterface;
	local VisualizationActionMetadata BuildTrack;
	local VisualizationActionMetadata EmptyTrack;

	History = `XCOMHISTORY;

	//Find any newly-applied PsiRipple effects and visualize them here.
	//(the normal Context_TickEffect doesn't handle these, because they're not in EffectTemplate.ApplyOnTick - and they get applied to other units) 
	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', EffectState)
	{
		EffectTarget = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
		if (EffectTarget == None)
			continue;

		OldEffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectState.ObjectID, , VisualizeGameState.HistoryIndex - 1));
		if (OldEffectState != None) //Not a new effect - don't visualize here
			continue;

		BuildTrack = EmptyTrack;
		BuildTrack.VisualizeActor = History.GetVisualizer(EffectTarget.ObjectID);
		VisualizerInterface = X2VisualizerInterface(BuildTrack.VisualizeActor);

		History.GetCurrentAndPreviousGameStatesForObjectID(EffectTarget.ObjectID, BuildTrack.StateObject_OldState, BuildTrack.StateObject_NewState, eReturnType_Reference, VisualizeGameState.HistoryIndex);
		if (BuildTrack.StateObject_NewState == none)
			BuildTrack.StateObject_NewState = BuildTrack.StateObject_OldState;
		else if (BuildTrack.StateObject_OldState == none)
			BuildTrack.StateObject_OldState = BuildTrack.StateObject_NewState;

		//Add the normal "PsiRipple" visualization
		EffectState.GetX2Effect().AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, 'AA_Success');

		//Allow for target being killed/etc
		if (VisualizerInterface != none)
			VisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildTrack);
	}

}

static function PsiRippleVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{

	if (EffectApplyResult != 'AA_Success')
		return;
	if (!ActionMetadata.StateObject_NewState.IsA('XComGameState_Unit'))
		return;

	AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.PsiRippleFriendlyName, 'PsiRipple', eColor_Bad, class'UIUtilities_Image_Ripple'.const.UnitStatus_PsiRipple);
	AddEffectMessageToTrack(
		ActionMetadata,
		default.PsiRippleEffectAcquiredString,
		VisualizeGameState.GetContext(),
		class'UIEventNoticesTactical_Ripple'.default.PsiRippleTitle,
		"img:///WoTC_Muton_Harrier_UI.UIPerk_Psionic_Rippling",
		eUIState_Bad);
	UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function PsiRippleVisualizationTicked(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	// dead units should not be reported
	if(UnitState == None || UnitState.IsDead() )
	{
		return;
	}

	AddEffectMessageToTrack(
		ActionMetadata,
		default.PsiRippleEffectTickedString,
		VisualizeGameState.GetContext(),
		class'UIEventNoticesTactical_Ripple'.default.PsiRippleTitle,
		"img:///WoTC_Muton_Harrier_UI.UIPerk_Psionic_Rippling",
		eUIState_Warning);
	UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function PsiRippleVisualizationRemoved(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	// dead units should not be reported
	if(UnitState == None || UnitState.IsDead() )
	{
		return;
	}

	AddEffectMessageToTrack(
		ActionMetadata,
		default.PsiRippleEffectLostString,
		VisualizeGameState.GetContext(),
		class'UIEventNoticesTactical_Ripple'.default.PsiRippleTitle,
		"img:///WoTC_Muton_Harrier_UI.UIPerk_Psionic_Rippling",
		eUIState_Good);
	UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

DefaultProperties
{
	PsiRippleName="PsiRipple"
}