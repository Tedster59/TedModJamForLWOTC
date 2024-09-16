class OPTCPsiPull extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate         Template;
    local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2Condition_IsTooHeavyForPull		IsTooHeavyForPullCondition;
	local X2AbilityToHitCalc_StandardAim    StandardAim;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate('DestroyerPull');

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  (in this case, add the X2Condition_IsTooHeavyForPull and change the aim roll to a standard one)

        IsTooHeavyForPullCondition = new class'X2Condition_IsTooHeavyForPull';
		Template.AbilityTargetConditions.AddItem(IsTooHeavyForPullCondition);

		StandardAim = new class'X2AbilityToHitCalc_StandardAim';
		StandardAim.bAllowCrit = false;
		Template.AbilityToHitCalc = StandardAim;
    }
}