// This is an Unreal Script

class OPTC_NapalmProtocol extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	
	AddCooldownToNapalm(AbilityTemplateManager.FindAbilityTemplate('MZNapalmProtocol'));

}

static function AddCooldownToNapalm(X2AbilityTemplate Template)
{
	local X2AbilityCooldown Cooldown;

	if(Template != none)
	{
		Cooldown = new class'X2AbilityCooldown';

		Cooldown.iNumTurns = 4;
		Template.AbilityCooldown = Cooldown;
	}

}