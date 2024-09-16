// This gives the Chemthrower Suppression ability a cooldown
// No cooldown if the user has the MZIcethrower ability (which is only granted by the Cryolator and its upgraded versions)

class OPTC_ChemthrowerSuppression extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustChemthrowerSuppressionAbility(AbilityTemplateManager.FindAbilityTemplate('MZChemthrowerSuppression'));
}
 
static function AdjustChemthrowerSuppressionAbility(X2AbilityTemplate Template)
{
	local X2Condition_UnitProperty						ShooterCondition;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  Remove the OLD cooldown!
        Template.AbilityCooldown = none;
 
        //  Add the new cooldown
        Template.AbilityCooldown = new class'X2AbilityCooldown_ChemthrowerSuppression';

		ShooterCondition=new class'X2Condition_UnitProperty';
		ShooterCondition.ExcludeConcealed = true;
		Template.AbilityShooterConditions.AddItem(ShooterCondition);
    }
}