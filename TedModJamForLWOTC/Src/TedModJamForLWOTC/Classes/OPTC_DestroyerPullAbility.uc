class OPTC_DestroyerPullAbility extends X2DownloadableContentInfo config(AbilityConfigsOPTC);

var config int DestroyerPullEnvironmentalDamageValue;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	
	AdjustDestroyerPullAbility(AbilityTemplateManager.FindAbilityTemplate('DestroyerPull'));

}

static function AdjustDestroyerPullAbility(X2AbilityTemplate Template)
{

local X2Effect_ApplyWeaponDamage EnvironmentDamageForProjectile;
local int i;
//check if the Ability Template was found
if (Template != none)
{

for (i = 0; i < Template.AbilityTargetEffects.Length; i++)
	{
		EnvironmentDamageForProjectile = X2Effect_ApplyWeaponDamage(Template.AbilityTargetEffects[i]);
	if (EnvironmentDamageForProjectile != none)
	{
		EnvironmentDamageForProjectile.EnvironmentalDamageAmount= default.DestroyerPullEnvironmentalDamageValue;
		}
	}
}
}




