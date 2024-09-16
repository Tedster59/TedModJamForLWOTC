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
    local X2AbilityTemplate                    FireRocketLauncherAbilityTemplate, FireRocketAbilityTemplate, FireRocketSparkAbilityTemplate, FireTacticalNukeAbilityTemplate;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
    FireRocketLauncherAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocketLauncher');
    FireRocketAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket');
    FireRocketSparkAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket_Spark');
	FireTacticalNukeAbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireTacticalNuke');
    X2AbilityMultiTarget_Radius(FireRocketLauncherAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
    X2AbilityMultiTarget_Radius(FireRocketAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
    X2AbilityMultiTarget_Radius(FireRocketSparkAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
	X2AbilityMultiTarget_Radius(FireTacticalNukeAbilityTemplate.AbilityMultiTargetStyle).AddAbilityBonusRadius('VolatileMix', 1.0);
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
//}