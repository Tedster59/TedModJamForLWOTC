// This is an Unreal Script

class OPTC_Bullseye extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated ()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	local X2AbilityTemplate AbilityTemplate;
	local X2Effect			Effect;
	local X2Effect_PersistentStatChange StatChangeEffect;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('ShadowOps_Bullseye');

	if(AbilityTemplate != NONE)
	{
		foreach AbilityTemplate.AbilityTargetEffects (Effect)
		{
			StatChangeEffect = X2Effect_PersistentStatChange(Effect);

			if(StatChangeEffect != None)
			{
				StatChangeEffect.DuplicateResponse = eDupe_Ignore;
			}
		}
	}
}