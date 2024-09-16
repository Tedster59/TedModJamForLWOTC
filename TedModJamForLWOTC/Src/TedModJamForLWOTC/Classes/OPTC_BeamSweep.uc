// The purpose of this is to prevent Beam Sweep (Muton Beleaguer Captains and playable Muton Beleaguers) from being used while burning or disoriented.

class OPTC_BeamSweep extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustBeamSweepAbility(AbilityTemplateManager.FindAbilityTemplate('Beam_Sweep'));
}
 
static function AdjustBeamSweepAbility(X2AbilityTemplate Template)
{
	local X2Condition_UnitEffects UnitEffects;
    //  Check if the Ability Template was successfully found by the manager.
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