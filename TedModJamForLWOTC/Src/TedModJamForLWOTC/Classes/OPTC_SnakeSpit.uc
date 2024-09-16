// This will make other "Spit" type abilities used by Viper variants have the same limitations that Poison Spit used by regular Vipers does in LWOTC.

class OPTC_SnakeSpit extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustSnakeSpitAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostSpit'));
	AdjustSnakeSpitAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFreezeSpit'));
	AdjustSnakeSpitAbility(AbilityTemplateManager.FindAbilityTemplate('Ability_AshFlameViperSpit'));
	AdjustSnakeSpitAbility(AbilityTemplateManager.FindAbilityTemplate('PoisonBlindSpit'));
}
 
static function AdjustSnakeSpitAbility(X2AbilityTemplate Template)
{
	local X2Condition_Visibility VisibilityCondition;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
		VisibilityCondition = new class'X2Condition_Visibility';
        VisibilityCondition.bVisibletoAnyAlly = true;
        VisibilityCondition.bAllowSquadsight = true;
        Template.AbilityTargetConditions.AddItem(VisibilityCondition);
        Template.AbilityMultiTargetConditions.AddItem(VisibilityCondition);
    }
}