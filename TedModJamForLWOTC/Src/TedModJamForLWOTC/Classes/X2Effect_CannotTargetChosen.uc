class X2Effect_CannotTargetChosen extends X2Effect_Persistent config(Game);

var private config array<name> ABILITIES_NOT_ALLOWED_TO_HIT;

function bool CanAbilityHitUnit(name AbilityName)
{
	if (ABILITIES_NOT_ALLOWED_TO_HIT.Find(AbilityName) == INDEX_NONE)
	{
		return true;
	}
	return false;
}