// This will let Custodians use their melee attacks even while burning.
// This also applies to XCOM's relevant Custodian melee gear.

// This currently does nothing

class OPTC_CustodianMelee extends X2DownloadableContentInfo config(Game);
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustCustodianMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('DestroyerGauntlet'));
	AdjustCustodianMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('BreakerGauntlet'));
	AdjustCustodianMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('ExaltedGauntlet'));
	AdjustCustodianMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('HiddenShieldStrikeAttack'));
	AdjustCustodianMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('MetionGauntlet'));
	AdjustCustodianMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('XcomDestroyerGauntlet'));
}
 
static function AdjustCustodianMeleeAbility(X2AbilityTemplate Template)
{
	local X2Condition Condition;
    local X2Condition_UnitEffects UnitEffect;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		foreach Template.AbilityShooterConditions(Condition)
        {
            if (Condition != none)
            {
                UnitEffect = X2Condition_UnitEffects(Condition);
                if (UnitEffect != none)
                {
                    UnitEffect.RemoveExcludeEffect(class'X2StatusEffects'.default.BurningName);
                }
            }
        }
    }
}