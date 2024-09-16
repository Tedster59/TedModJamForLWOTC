// This gives the Chemthrower Suppression ability a cooldown
// No cooldown if the user has the MZIcethrower ability (which is only granted by the Cryolator and its upgraded versions)

class X2AbilityCooldown_ChemthrowerSuppression extends X2AbilityCooldown config (Game);

var config int iCHEMTHROWERSUPPRESSION_BASE_NUMBERTURNS;
 
simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
    //pull the default number from the config
    iNumTurns = default.iCHEMTHROWERSUPPRESSION_BASE_NUMBERTURNS;
 
    if (XComGameState_Unit(AffectState).HasAbilityFromAnySource('MZIcethrower'))
    {
        iNumTurns = 0;
    }
 
    //return the calculated number
    return iNumTurns;
}