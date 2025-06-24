// This is an Unreal Script

class X2AbilityCooldown_LocalAndGlobalPlayer extends X2AbilityCooldown_LocalAndGlobal;

simulated function ApplyCooldown(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
	local XComGameState_Unit kUnitState;
	local XComGameState_Player kPlayerState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	super.ApplyCooldown(kAbility, AffectState, AffectWeapon, NewGameState);

	kUnitState = XComGameState_Unit(AffectState);
	kPlayerState = XComGameState_Player(History.GetGameStateForObjectID(kUnitState.ControllingPlayer.ObjectID));

	if( (kPlayerState != none))
	{
		// This version DOES hit player abilities for anti-cheese purposes
		kPlayerState = XComGameState_Player(NewGameState.ModifyStateObject(kPlayerState.Class, kPlayerState.ObjectID));
		kPlayerState.SetCooldown(kAbility.GetMyTemplateName(), NumGlobalTurns);
	}
}