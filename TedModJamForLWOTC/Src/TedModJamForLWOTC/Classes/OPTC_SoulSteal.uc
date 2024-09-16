// This will add Soulfire as a prerequisite for Soul Steal, preventing you from rolling the latter in your Psion training tube without the former.
// Soul Steal doesn't work without Soulfire anyway, and it won't do any harm to those of you not running Psionics Overhaul V3.

class OPTC_SoulSteal extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustSoulStealAbility(AbilityTemplateManager.FindAbilityTemplate('SoulSteal'));
}
 
static function AdjustSoulStealAbility(X2AbilityTemplate Template)
{
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  Add Soulfire requirement
		Template.PrerequisiteAbilities.AddItem ('Soulfire');
    }
}