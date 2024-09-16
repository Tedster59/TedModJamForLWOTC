// This will make Frost Mark Target unable to be used while burning/disoriented.

class OPTC_FrostMarkTarget extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustFrostMarkTargetAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDMarkTarget'));
}
 
static function AdjustFrostMarkTargetAbility(X2AbilityTemplate Template)
{
    local X2Condition_UnitEffects UnitEffects;
    
	if (Template != none)
    {
    UnitEffects = new class'X2Condition_UnitEffects';
    UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName, 'AA_UnitIsDisoriented');
    UnitEffects.AddExcludeEffect(class'X2StatusEffects'.default.BurningName, 'AA_UnitIsBurning');
    UnitEffects.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_CarryingUnit');
    UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BoundName, 'AA_UnitIsBound');            
    UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.ConfusedName, 'AA_UnitIsConfused');
    UnitEffects.AddExcludeEffect(class'X2Effect_PersistentVoidConduit'.default.EffectName, 'AA_UnitIsBound');
    UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_UnitIsStunned');
    UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DazedName, 'AA_UnitIsStunned');
    UnitEffects.AddExcludeEffect('Freeze', 'AA_UnitIsFrozen');

    Template.AbilityShooterConditions.AddItem(UnitEffects);
	}

}