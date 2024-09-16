// This is an Unreal Script

class OPTC_TakeDown extends X2DownloadableContentInfo config(AbilityConfigsOPTC);

var config int TakeDown_Cooldown;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	local X2AbilityTemplate AbilityTemplate;
	local X2AbilityCooldown Cooldown;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('ABB_TakeDown');

	if(AbilityTemplate != NONE)
	{
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = default.TakeDown_Cooldown;

		AbilityTemplate.AbilityCooldown = Cooldown;
		
	}

	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('TakeUnder');

	if(AbilityTemplate != NONE)
	{
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = default.TakeDown_Cooldown;

		AbilityTemplate.AbilityCooldown = Cooldown;
		
	}
}