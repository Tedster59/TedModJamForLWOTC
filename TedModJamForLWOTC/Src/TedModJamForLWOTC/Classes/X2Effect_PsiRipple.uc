// This is an Unreal Script
class X2Effect_PsiRipple extends X2Effect_Burning;

var privatewrite name PsiRippleEffectAddedEventName;

function bool IsThisEffectBetterThanExistingEffect(const out XComGameState_Effect ExistingEffect)
{
	local X2Effect_PsiRipple ExistingPsiRippleEffectTemplate;

	ExistingPsiRippleEffectTemplate = X2Effect_PsiRipple(ExistingEffect.GetX2Effect());

	if( ExistingPsiRippleEffectTemplate != None && ExistingPsiRippleEffectTemplate.GetPsiRippleDamage().EffectDamageValue.Damage > GetPsiRippleDamage().EffectDamageValue.Damage )
	{
		return false;
	}
	return true;
}

//simulated function ApplyEffectToWorld(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState)
//{
	
//}

simulated function SetPsiRippleDamage(int Damage, int Spread, name DamageType)
{
	local X2Effect_ApplyWeaponDamage PsiRippleDamage;

	PsiRippleDamage = new class'X2Effect_ApplyWeaponDamage';
	PsiRippleDamage.bAllowFreeKill = false;
	PsiRippleDamage.bIgnoreArmor = true;

	PsiRippleDamage.EffectDamageValue.Damage = Damage;
	PsiRippleDamage.EffectDamageValue.Spread = Spread;
	PsiRippleDamage.EffectDamageValue.DamageType = DamageType;
	PsiRippleDamage.bIgnoreBaseDamage = true;
	PsiRippleDamage.DamageTag = self.Name;

	ApplyOnTick.AddItem(PsiRippleDamage);
}

simulated function X2Effect_ApplyWeaponDamage GetPsiRippleDamage()
{
	return X2Effect_ApplyWeaponDamage(ApplyOnTick[0]);
}

DefaultProperties
{
	DamageTypes(0)="Psi"
	DuplicateResponse=eDupe_Refresh
	bCanTickEveryAction=true

	PsiRippleEffectAddedEventName="PsiRippleEffectAdded"
}