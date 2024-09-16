// This makes Underbarrel Grenade Launchers guaranteed to hit.

class OPTC_Underbarrels extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustUnderbarrelLauncherAbility(AbilityTemplateManager.FindAbilityTemplate('Fire_UBGL_Conv'));
	AdjustUnderbarrelLauncherAbility(AbilityTemplateManager.FindAbilityTemplate('Fire_UBGL_Mag'));
	AdjustUnderbarrelLauncherAbility(AbilityTemplateManager.FindAbilityTemplate('Fire_UBGL_Beam'));
}
 
static function AdjustUnderbarrelLauncherAbility(X2AbilityTemplate Template)
{
	local X2AbilityToHitCalc_StandardAim    StandardAim;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  Make it a guaranteed hit
			StandardAim = new class'X2AbilityToHitCalc_StandardAim';
			StandardAim.bAllowCrit = false;
			StandardAim.bGuaranteedHit = true;
			StandardAim.bIndirectFire = true;
			Template.AbilityToHitCalc = StandardAim;
    }
}