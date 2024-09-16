// The purpose of this is to add a one-turn cooldown to Shield Bash for the SPARK version of the Ballistic Shield.
// This is to prevent using Overdrive or similar abilities to get a bunch of 2-action stuns in one turn.

class OPTC_ShieldBash extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustShieldBashAbility(AbilityTemplateManager.FindAbilityTemplate('ShieldBash'));
}
 
static function AdjustShieldBashAbility(X2AbilityTemplate Template)
{
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    { 
        //  Add the new cooldown
        Template.AbilityCooldown = new class'X2AbilityCooldown_ShieldBash';
    }
}