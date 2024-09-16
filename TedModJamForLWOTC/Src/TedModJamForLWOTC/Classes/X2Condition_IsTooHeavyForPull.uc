class X2Condition_IsTooHeavyForPull extends X2Condition config(Game);

var config array<name> CannotPullUnitsWithTheseAbilities;
 
event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
    local XComGameState_Unit TargetUnit;
    local name AbilityName;

    TargetUnit = XComGameState_Unit(kTarget);

    `LOG("Call Meets Condition Called, with target" @TargetUnit.GetMyTemplateName(),,'LOOKHERE');

    foreach default.CannotPullUnitsWithTheseAbilities(AbilityName)
    {
        `LOG("Cannot Pull Units With These Abilities to check :" @AbilityName,,'LOOKHERE');
        if (TargetUnit.HasAbilityFromAnySource(AbilityName))
        {
            `LOG("Target Unit Had Ability",,'LOOKHERE');
            return 'AA_UnitIsTooLarge';
        }
    }

    `LOG("Target Unit DID NOT have Ability ... OR ... NO Abilites in the config",,'LOOKHERE');
    return 'AA_Success';
}