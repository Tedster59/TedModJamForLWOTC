// The purpose of this is to add a one-turn cooldown to Scanning Protocol, but only for enemy units (Frost Technician right now).
// This way, they won't waste all of their charges in one turn.

class X2AbilityCooldown_ScanningProtocol extends X2AbilityCooldown config (Game);

var config int iSCANNINGPROTOCOL_BASE_NUMBERTURNS;
 
simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
    //pull the default number from the config
    iNumTurns = default.iSCANNINGPROTOCOL_BASE_NUMBERTURNS;
 
    if (XComGameState_Unit(AffectState).HasAbilityFromAnySource('LiftOffAvenger')) // Only player controlled units should have this
    {
        iNumTurns = 0;
    }
 
    //return the calculated number
    return iNumTurns;
}