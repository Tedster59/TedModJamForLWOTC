class X2Condition_GRA_ClassRestriction extends X2Condition config(CanHaveGunRaiseAnimation);

var config array<name> DisallowedClasses;

//    This condition fails if the unit is of a particular class (which can be configured)

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
    local XComGameState_Unit UnitState;
    
    UnitState = XComGameState_Unit(kTarget);
    
    if (UnitState != none)
    {
        if (IsClassDisallowed(UnitState))
        {
            return 'AA_UnitIsWrongType';
        }
        return 'AA_Success'; 
    }
    return 'AA_NotAUnit';
}

function bool CanEverBeValid(XComGameState_Unit SourceUnit, bool bStrategyCheck)
{
    return !IsClassDisallowed(SourceUnit);
}

static private function bool IsClassDisallowed(const XComGameState_Unit UnitState)
{
    return default.DisallowedClasses.Find(UnitState.GetSoldierClassTemplateName()) != INDEX_NONE;    
}