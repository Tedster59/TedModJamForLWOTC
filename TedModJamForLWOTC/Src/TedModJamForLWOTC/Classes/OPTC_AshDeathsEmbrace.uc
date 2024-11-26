// This is an Unreal Script

class OPTFC_AshDeathsEmbrace extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustDeathsEmbrace(AbilityTemplateManager.FindAbilityTemplate('Ability_AshDeathsEmbraceM1'));
}
 
static function AdjustDeathsEmbrace(X2AbilityTemplate Template)
{
	local X2Condition_UnitStatCheck UnitStatCheckCondition;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		UnitStatCheckCondition = new class'X2Condition_UnitStatCheck';
		UnitStatCheckCondition.AddCheckStat(eStat_HP, 4, eCheck_LessThanOrEqual);
		Template.AbilityTargetConditions.AddItem(UnitStatCheckCondition);

		Template.AddShooterEffectExclusions();

	}
}