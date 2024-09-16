// This is to add Area Suppression as a valid SuppressedCondition to abilities from other mods
// If you see abilities being able to be used while the unit is affected by Area Suppression that shouldn't be, tell me so that I can add them to this list.

class OPTC_X2Effect_AreaSuppression extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostMicroMissiles'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDBomberCCS'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDBomberCCSAttack'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('ZerkerPunt'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('ZerkerPuntAttack'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDHardlinerFreezeLauncher'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('ReflexSlash'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('ReflexSlashAttack'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDAndromedonFrostBlob'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket_Spark'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireRPG'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('TelekinesisShot'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('Beam_Sweep'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('Ability_AshFlameViperSpit'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('PoisonBlindSpit'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('AssassinBladestorm'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('AssassinBladestormAttack'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('CustodianRockets'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('ExaltedRockets'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MetionClusterRocket'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('MZCryoLauncher'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('SparkMZCryoLauncher'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('SoulMania'));
	AdjustAreaSuppressionEffectAbility(AbilityTemplateManager.FindAbilityTemplate('SoulManiaAttack'));
}
 
static function AdjustAreaSuppressionEffectAbility(X2AbilityTemplate Template)
{
	local X2Condition_UnitEffects	SuppressedCondition;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
		SuppressedCondition = new class'X2Condition_UnitEffects';
		SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
		SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression'.default.EffectName, 'AA_UnitIsSuppressed');
		Template.AbilityShooterConditions.AddItem(SuppressedCondition);
    }
}