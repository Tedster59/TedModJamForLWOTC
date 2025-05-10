class OPTC_VolatileMix extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	UpdateIridarRocketLauncher();
	//UpdateIridarDisposableRocketLauncher();
	//TweakIridarRocketLauncher();
}

static function UpdateIridarRocketLauncher()
{
    local X2AbilityTemplateManager            AbilityTemplateManager;
    local X2AbilityTemplate                    FireRocketLauncherAbilityTemplate, FireRocketAbilityTemplate, FireRocketSparkAbilityTemplate, FireTacticalNukeAbilityTemplate, IRILaunchOrdnanceTemplate, IRIBlastOrdnanceTemplate;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
    FireRocketLauncherAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocketLauncher');
    FireRocketAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket');
    FireRocketSparkAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket_Spark');
	FireTacticalNukeAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireTacticalNuke');

	IRILaunchOrdnanceTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_LaunchOrdnance');
	IRIBlastOrdnanceTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_BlastOrdnance');

    X2AbilityMultiTarget_Radius(FireRocketLauncherAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
    X2AbilityMultiTarget_Radius(FireRocketAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
    X2AbilityMultiTarget_Radius(FireRocketSparkAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
	X2AbilityMultiTarget_Radius(FireTacticalNukeAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
	X2AbilityMultiTarget_Radius(IRILaunchOrdnanceTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
	X2AbilityMultiTarget_Radius(IRIBlastOrdnanceTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);

	FixCannonade(AbilityTemplateManager.FindAbilityTemplate('ABB_Cannonade'));
}

//static function UpdateIridarDisposableRocketLauncher()
//{
//    local X2AbilityTemplateManager            AbilityTemplateManager;
//    local X2AbilityTemplate                    FireDisposableRocketLauncherAbilityTemplate, FireDisposableRocketAbilityTemplate;

 //   AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 //   FireDisposableRocketLauncherAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('RocketFuse');
 //   FireDisposableRocketAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRPG');
 //   X2AbilityMultiTarget_Radius(FireDisposableRocketLauncherAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
 //   X2AbilityMultiTarget_Radius(FireDisposableRocketAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
//}

//static function TweakIridarRocketLauncher()
//{
 //   local X2AbilityTemplateManager            AbilityTemplateManager;
 //   local X2AbilityTemplate                    FireRocketLauncherAbilityTemplate, FireRocketAbilityTemplate, FireRocketSparkAbilityTemplate;
//	local X2AbilityMultiTarget_Radius       RadiusMultiTarget;

//    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 //   FireRocketLauncherAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocketLauncher');
 //   FireRocketAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket');
//    FireRocketSparkAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket_Spark');

//	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
//	RadiusMultiTarget.bUseWeaponBlockingCoverFlag = false;
//	FireRocketLauncherAbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;
//	FireRocketAbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;
//	FireRocketSparkAbilityTemplate.AbilityMultiTargetStyle = RadiusMultiTarget;


static function FixCannonade(X2AbilityTemplate Template)
{
	local int i;
	local X2Effect_BonusGrenadeSlotUse_Fixed	BonusEffect;

	if(Template != None)
	{
		for (i = 0; i < Template.AbilityTargetEffects.Length; i++)
		{
			if(Template.AbilityTargetEffects[i].IsA('X2Effect_BonusGrenadeSlotUse'))
			{
				BonusEffect = new class'X2Effect_BonusGrenadeSlotUse_Fixed';
				BonusEffect.EffectName='CannonadeEffect_Fixed';
				BonusEffect.bDamagingGrenadesOnly = false;
				BonusEffect.bNonDamagingGrenadesOnly = false;
				BonusEffect.BonusUses = 1;
				BonusEffect.BuildPersistentEffect (1, true, false);
				BonusEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
				Template.AbilityTargetEffects[i] = BonusEffect;
			}
		}
	}
}
