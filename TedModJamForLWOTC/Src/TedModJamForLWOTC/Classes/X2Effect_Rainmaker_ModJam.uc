class X2Effect_Rainmaker_ModJam extends X2Effect_Persistent config(SPARKLaunchers);

var config int RAINMAKER_DMG_SHOULDERLAUNCHER;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	switch (AbilityState.GetMyTemplateName())
	{
	case 'RM_SPARKMissiles':
		return default.RAINMAKER_DMG_SHOULDERLAUNCHER;
	default:
		break;
	}
	return 0;
}

defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}