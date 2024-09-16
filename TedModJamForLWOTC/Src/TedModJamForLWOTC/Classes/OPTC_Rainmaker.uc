// This will update Shellshock Protocol with the new effect that lets it boost the damage of relevant Spark Launchers Redux weapons

class OPTC_Rainmaker extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    AdjustRainmakerAbility(AbilityTemplateManager.FindAbilityTemplate('Rainmaker'));
}
 
static function AdjustRainmakerAbility(X2AbilityTemplate Template)
{
	local X2Effect_Persistent           PersistentEffect;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		PersistentEffect = new class'X2Effect_Rainmaker_ModJam';
		PersistentEffect.BuildPersistentEffect(1, true, false);
		PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true, ,Template.AbilitySourceName);
		Template.AddTargetEffect(PersistentEffect);
    }
}