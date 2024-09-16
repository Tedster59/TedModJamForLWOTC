// This will make Blazing Storm and Melting Stream cost 2 actions each
// Doing it this way rather than through Ability Editor so that I don't have to mess with their cooldowns

class OPTC_MeltingStreamBlazingStorm extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate				Template;
    local X2AbilityTemplateManager		AbilityTemplateManager;
	local X2AbilityCost_ActionPoints    ActionPointCost;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate('BlazingStorm');
	Template = AbilityTemplateManager.FindAbilityTemplate('MeltingStream');

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 

		ActionPointCost = new class'X2AbilityCost_ActionPoints';
		ActionPointCost.iNumPoints = 2;
		ActionPointCost.bConsumeAllPoints = true;
		Template.AbilityCosts.AddItem(ActionPointCost);
    }
}