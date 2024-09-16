// The purpose of this is to normalize the Backburner flamethrower's burning duration, as burning is much more powerful in LWOTC.

class OPTC_BackburnerAbility extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustBackburnerAbility(AbilityTemplateManager.FindAbilityTemplate('DromeDome_BackBurner'));
}
 
static function AdjustBackburnerAbility(X2AbilityTemplate Template)
{
	local X2Effect_Burning BurningEffect;
	local X2Effect Effect;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {

		forEach Template.AbilityMultiTargetEffects (Effect)
		{
			BurningEffect = X2Effect_Burning(Effect);
			if(BurningEffect != none)
			{
				BurningEffect.iNumTurns = 2;
			}
		}
    }
}