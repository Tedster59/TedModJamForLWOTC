class OPTC_RequiemStuff extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager  AbilityTemplateManager;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	FixUnload(AbilityTemplateManager.FindAbilityTemplate('F_Unload'));
	FixUnload(AbilityTemplateManager.FindAbilityTemplate('SoulReaper'));
	FixUnload(AbilityTemplateManager.FindAbilityTemplate('ShadowOps_SlamFire'));
	FixUnload(AbilityTemplateManager.FindAbilityTemplate('RM_OverclockCore'));
}

static function FixUnload(X2AbilityTemplate Template)
{
	if(Template != None)
	{
		Template.AbilityShooterConditions.AddItem(new class'X2Condition_NotUnlimitedAmmo');
	}
}