class X2Effect_ShieldGuard extends X2Effect_Persistent config(Shields);

// modification of antiflank script by bg

var config bool LogEffects;

var config bool Affect_SPARKs;
var config int	SoldierDefenceModifier;
var config int	SPARKDefenceModifier;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local XComGameState_Unit UnitState;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	EventMgr.RegisterForEvent(EffectObj, 'UnitMoveFinished', EffectGameState.GenerateCover_ObjectMoved_Update, ELD_OnStateSubmitted,, UnitState);
	EventMgr.RegisterForEvent(EffectObj, 'UnitCoverUpdated', EffectGameState.GenerateCover_ObjectMoved_Update, ELD_OnStateSubmitted,, UnitState);

}

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ModInfo;
	local GameRulesCache_VisibilityInfo VisInfo;

	if (bFlanking) //if flanked
		{
			`LOG("Flanked upgraded to low cover", default.LogEffects, 'ShieldRework');
			ModInfo.ModType = eHit_Success;
			ModInfo.Reason = FriendlyName;
			ModInfo.Value = 0 - class'X2AbilityToHitCalc_StandardAim'.default.LOW_COVER_BONUS - default.SoldierDefenceModifier;

			ShotModifiers.AddItem(ModInfo);

			ModInfo.ModType = eHit_Crit;
			ModInfo.Reason = FriendlyName;
			ModInfo.Value = 0 - Attacker.GetCurrentStat(eStat_FlankingCritChance);

			ShotModifiers.AddItem(ModInfo);

		}

		if  ((VisInfo.TargetCover == CT_None) && !bFlanking && Affect_SPARKs) // if the unit has no cover and is not flanked, assign the extra defence but not the crit bonus
		{
			`LOG("No cover upgraded to low cover", default.LogEffects, 'ShieldRework');
			ModInfo.ModType = eHit_Success;
			ModInfo.Reason = FriendlyName;
			ModInfo.Value = 0 - class'X2AbilityToHitCalc_StandardAim'.default.LOW_COVER_BONUS - default.SPARKDefenceModifier;

			ShotModifiers.AddItem(ModInfo);

			ModInfo.ModType = eHit_Crit;
			ModInfo.Reason = FriendlyName;
			ModInfo.Value = 0 - Attacker.GetCurrentStat(eStat_FlankingCritChance);

			ShotModifiers.AddItem(ModInfo);
			
		}

}

DefaultProperties
{
	EffectName = "SimulatedCover"
	DuplicateResponse = eDupe_Refresh;
	bApplyOnHit = true;
	bApplyOnMiss = true;
}