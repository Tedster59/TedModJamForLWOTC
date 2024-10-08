class X2Effect_GrantCharges extends X2Effect;

var array<name> AbilityNames;
var int NumCharges;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		UnitState;
	local XComGameState_Ability		AbilityState;
	local name						AbilityName;

	UnitState = XComGameState_Unit(kNewTargetState);
	
	if (UnitState != none)
	{
		foreach AbilityNames(AbilityName)
		{
			AbilityState = XComGameState_Ability(NewGameState.ModifyStateObject(class'XComGameState_Ability', UnitState.FindAbility(AbilityName).ObjectID));

			if (AbilityState != none)
			{
				AbilityState.iCharges += NumCharges;
			}
		}
	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}