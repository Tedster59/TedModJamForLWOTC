// Disables an ability if bound to infinite ammo

class X2Condition_NotUnlimitedAmmo extends X2Condition;

event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget) 
{
	local XComGameState_Item SourceWeapon;

	SourceWeapon = kAbility.GetSourceWeapon();

	if (SourceWeapon != none && !SourceWeapon.HasInfiniteAmmo())
	{
		return 'AA_Success'; 
	}

	return 'AA_WeaponIncompatible';
}
