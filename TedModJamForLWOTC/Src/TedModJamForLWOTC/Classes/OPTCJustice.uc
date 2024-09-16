class OPTCJustice extends X2DownloadableContentInfo config(Game);

var config name JusticeAbility;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate         Template;
    local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2Condition_IsTooHeavyForPull		IsTooHeavyForPullCondition;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate(default.JusticeAbility);

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  (in this case, add the X2Condition_IsTooHeavyForPull)

        IsTooHeavyForPullCondition = new class'X2Condition_IsTooHeavyForPull';
		Template.AbilityTargetConditions.AddItem(IsTooHeavyForPullCondition);
    }
}