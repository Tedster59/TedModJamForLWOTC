// The purpose of this is to add a one-turn cooldown to Shield Bash for the SPARK version of the Ballistic Shield.
// This is to prevent using Overdrive or similar abilities to get a bunch of 2-action stuns in one turn.

class X2AbilityCooldown_ShieldBash extends X2AbilityCooldown config (Shields);

var config int SPARKSHIELDBASHCOOLDOWN;
 
simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
    iNumTurns = 0; // Humanoid soldiers
 
    if (XComGameState_Unit(AffectState).HasAbilityFromAnySource('MecTrooperImmunities')) // MEC Troopers
    {
        iNumTurns = default.SPARKSHIELDBASHCOOLDOWN;
    }

	if (XComGameState_Unit(AffectState).HasAbilityFromAnySource('Overdrive')) // SPARKs
    {
        iNumTurns = default.SPARKSHIELDBASHCOOLDOWN;
    }
 
    //return the calculated number
    return iNumTurns;
}