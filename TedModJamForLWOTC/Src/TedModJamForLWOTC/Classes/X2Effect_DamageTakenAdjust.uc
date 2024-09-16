class X2Effect_DamageTakenAdjust extends X2Effect_Persistent;

var int DamageMod; // positive values increase damage taken, negative valus reduce damage taken

var name DamageTypeName;

function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	// The damage effect's DamageTypes must be empty or have a specific damage type in order to adjust the damage
	if( (WeaponDamageEffect.EffectDamageValue.DamageType == DamageTypeName) || (WeaponDamageEffect.DamageTypes.Find(DamageTypeName) != INDEX_NONE) && (WeaponDamageEffect.DamageTypes.Length != 0) && !(TargetDamageable.IsImmuneToDamage(DamageTypeName)))
	//if( (WeaponDamageEffect.EffectDamageValue.DamageType == DamageTypeName) || (WeaponDamageEffect.DamageTypes.Find(DamageTypeName) != INDEX_NONE) ||
		//((WeaponDamageEffect.EffectDamageValue.DamageType == '') && (WeaponDamageEffect.DamageTypes.Length == 0)) )
		{
			return DamageMod;
		}

	return 0;
}

defaultproperties
{
//	DamageTypeName="melee"
	bDisplayInSpecialDamageMessageUI = true
}
