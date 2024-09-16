class X2Condition_GRA_CharacterRestriction extends X2Condition config(CanHaveGunRaiseAnimation);

var config array<name> DisallowedCharacters;

//    This condition fails if the unit is of a particular class (which can be configured)

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
    local XComGameState_Unit UnitState;
    
    UnitState = XComGameState_Unit(kTarget);
    
    if (UnitState != none)
    {
        if (IsCharacterDisallowed(UnitState))
        {
            return 'AA_UnitIsWrongType';
        }
        return 'AA_Success'; 
    }
    return 'AA_NotAUnit';
}

function bool CanEverBeValid(XComGameState_Unit SourceUnit, bool bStrategyCheck)
{
    return !IsCharacterDisallowed(SourceUnit);
}

static private function bool IsCharacterDisallowed(const XComGameState_Unit UnitState)
{
    return default.DisallowedCharacters.Find(UnitState.GetMyTemplateName()) != INDEX_NONE;    
}