class X2Effect_RussianRoulette extends X2Effect_Persistent;

var array<name> AllowedAbilities;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local XComGameState_Unit UnitState;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;

	EffectObj = EffectGameState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	EventMgr.RegisterForEvent(EffectObj, 'RussianRouletteTriggered', EffectGameState.TriggerAbilityFlyover, ELD_OnStateSubmitted, , UnitState);
}

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local X2EventManager EventMgr;
	local XComGameState_Ability AbilityState;       //  used for looking up our source ability (Guardian), not the incoming one that was activated

	if (SourceUnit.ReserveActionPoints.Length != PreCostReservePoints.Length && AbilityContext.IsResultContextMiss() && AllowedAbilities.Find(kAbility.GetMyTemplate().DataName) != INDEX_NONE)
	{
		AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
		if (AbilityState != none)
			{
				SourceUnit.ReserveActionPoints = PreCostReservePoints;

				EventMgr = `XEVENTMGR;
				EventMgr.TriggerEvent('RussianRouletteTriggered', AbilityState, SourceUnit, NewGameState);

				return true;
			}
	}
	return false;
}

DefaultProperties
{
	AllowedAbilities(0) = "OverwatchShot"
	//AllowedAbilities(1) = "PistolOverwatchShot"
}