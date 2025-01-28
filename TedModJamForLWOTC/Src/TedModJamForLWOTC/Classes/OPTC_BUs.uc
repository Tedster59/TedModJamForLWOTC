// This is an Unreal Script

class OPTC_BUs extends X2DownloadableContentInfo config(Game);

var config array<name> IncludedTemplates;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2CharacterTemplateManager CharacterTemplateManager;
	local name BUName;
	local X2CharacterTemplate Template;
	local array<X2DataTemplate> DataTemplateAllDifficulties;
	local X2DataTemplate DataTemplate;
	local int idx;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AddBUTechCondition(AbilityTemplateManager.FindAbilityTemplate('RM_BrutalizeProtocol'), 'DummyNonexistantTech');
	AddBUTechCondition(AbilityTemplateManager.FindAbilityTemplate('BrutalObliterator'), 'BU_All_Tier4_Tech');

	AddBUTechCondition(AbilityTemplateManager.FindAbilityTemplate('M31_Botnet'), 'BU_Utility_Tier3_Tech');
	AddBUTechCondition(AbilityTemplateManager.FindAbilityTemplate('Anatomy_LW'), 'BU_Firepower_Tier3_Tech');


	CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	foreach default.IncludedTemplates (BUName)
	{
		CharacterTemplateManager.FindDataTemplateAllDifficulties(BUName, DataTemplateAllDifficulties);

		foreach DataTemplateAllDifficulties (DataTemplate)
		{
			Template = X2CharacterTemplate(DataTemplate);

			if(Template != none)
			{
				idx = Template.Abilities.Find('RM_BrutalizeProtocol');

				if (idx != INDEX_NONE)
				{
					Template.Abilities.Remove(idx,1);
					AddAbilityToBU(Template, 'BrutalObliterator');
				}
			}
		}
	}

}

static function AddBUTechCondition(X2AbilityTemplate Template, name TechTemplate)
{
    local X2Condition_HasPurchasedtechUnlock_BU UnlockReq;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //create new condition
        UnlockReq = new class'X2Condition_HasPurchasedTechUnlock_BU';
        UnlockReq.TemplateNames = default.IncludedTemplates;
        UnlockReq.TechTemplatesThatUnlocks = TechTemplate;

        //add new condition
	    Template.AbilityShooterConditions.AddItem(UnlockReq);
    }
}

static function AddAbilityToBU(X2CharacterTemplate Template, name AbilityName)
{
	if(Template != None)
	{
		Template.Abilities.AddItem(AbilityName);
	}
}