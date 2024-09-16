// Apparently LWOTC's version of Solace can't target aliens.
// Obviously this is a problem for Playable Aliens, so this is an attempted fix.

class OPTC_SolaceLW extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    AdjustSolaceLWAbility(AbilityTemplateManager.FindAbilityTemplate('Solace_LW'));
}
 
static function AdjustSolaceLWAbility(X2AbilityTemplate Template)
{
	local X2Condition_UnitProperty          UnitPropertyCondition;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		UnitPropertyCondition = new class'X2Condition_UnitProperty';
		UnitPropertyCondition.ExcludeFriendlyToSource=false;
		UnitPropertyCondition.ExcludeAlien = false;
		Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
    }
}