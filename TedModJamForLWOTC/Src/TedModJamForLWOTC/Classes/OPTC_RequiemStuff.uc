class OPTC_RequiemStuff extends X2DownloadableContentInfo;

var config array<name> AbilitiesNotUsableWithUnlimitedAmmo;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager		AbilityTemplateManager;
	local name							AbilityName;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	foreach default.AbilitiesNotUsableWithUnlimitedAmmo(AbilityName)
	{
		// None check in this helper
		MakeNotWorkWithUnlimitedAmmoWeapons(AbilityTemplateManager.FindAbilityTemplate(AbilityName));
	}
}

static function MakeNotWorkWithUnlimitedAmmoWeapons(X2AbilityTemplate Template)
{
	if(Template != None)
	{
		Template.AbilityShooterConditions.AddItem(new class'X2Condition_NotUnlimitedAmmo');
	}
}