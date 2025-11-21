class OPTC_ShieldAbilities extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate         Template;
    local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2Effect_DeflectEx_Updated NewDeflectEffect;
	local int i;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate('MZEnGardeAttack');

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  (in this case, add the X2Condition_IsTooHeavyForPull)

    }

	Template = AbilityTemplateManager.FindAbilityTemplate('AdvBioShieldDeflect');

	 if (Template != none)
    {
		for (i = 0; i< Template.AbilityTargetEffects.Length; i++)
		{
			if(Template.AbilityTargetEffects[i].isA('X2Effect_DeflectEx'))
			{

				NewDeflectEffect = new class'X2Effect_DeflectEx_Updated';

				NewDeflectEffect.BuildPersistentEffect(1, true, false);
				NewDeflectEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true, , Template.AbilitySourceName);
				NewDeflectEffect.DeflectChance = 25;
				NewDeflectEffect.MaxDeflectsPerTurn = 3;

				Template.AbilityTargetEffects[i] = NewDeflectEffect;

			}
		}
	}
}