// Make alien damper field cost 1 AP and not be a free action.  XCOM damper field untouched

class OPTC_DamperField extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustDamperField(AbilityTemplateManager.FindAbilityTemplate('Ability_AshDamperFieldAlien'));
}


static function AdjustDamperField(X2AbilityTemplate Template)
{
    local X2AbilityCost Costs;
    local X2AbilityCost_ActionPoints    APCost;

	if(Template != none)
	{
		foreach Template.AbilityCosts( Costs ) 
		{
			if (X2AbilityCost_ActionPoints (Costs) != none )
			{
				APCost = X2AbilityCost_ActionPoints (Costs);
				APCost.bFreeCost = false;
			}
		}
	}
}