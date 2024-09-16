// This will make This One's Mine a neutral ability so it (hopefully) won't trigger Return Fire and similar abilities

class OPTC_ThisOnesMine extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustThisOnesMineAbility(AbilityTemplateManager.FindAbilityTemplate('ShadowOps_ThisOnesMine'));
}
 
static function AdjustThisOnesMineAbility(X2AbilityTemplate Template)
{
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  Add Soulfire requirement
		Template.Hostility = eHostility_Neutral;
    }
}