class OPTC_CurbInfiniteActionEconomy extends X2DownloadableContentInfo;


static event OnPostTemplatesCreated()
{
	local X2AbilityTemplateManager TemplateMgr;
	local X2AbilityTemplate Template;
	local X2Effect_SerialCritReduction SerialCritReduction;

	TemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	Template = TemplateMgr.FindAbilityTemplate('ShadowOps_SlamFire');
	if (Template != none)
	{
		SerialCritReduction = new class 'X2Effect_SerialCritReduction';
		SerialCritReduction.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
		SerialCritReduction.CritReductionPerKill = class'LWTemplateMods'.default.SERIAL_CRIT_MALUS_PER_KILL;
		SerialCritReduction.AimReductionPerKill = class'LWTemplateMods'.default.SERIAL_AIM_MALUS_PER_KILL;
		SerialCritReduction.Damage_Falloff = class'LWTemplateMods'.default.SERIAL_DAMAGE_FALLOFF;
		SerialCritReduction.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true,, Template.AbilitySourceName);
		SerialCritReduction.EffectName = 'SerialCritReduction';
		Template.AbilityTargetEffects.AddItem(SerialCritReduction);
	}
}