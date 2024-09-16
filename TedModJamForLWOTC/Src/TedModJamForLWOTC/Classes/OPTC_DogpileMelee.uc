// This should make the Dogpile ability no longer consume/require action points.
// Cooldown of 1 added to make sure it only triggers once per turn (under normal circumstances).

class OPTC_DogpileMelee extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    AdjustDogpileMeleeAbility(AbilityTemplateManager.FindAbilityTemplate('MZDogpileMeleeSlash'));
}
 
static function AdjustDogpileMeleeAbility(X2AbilityTemplate Template)
{
	local X2AbilityCooldown					Cooldown;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		Template.AbilityCosts.Length = 0;

		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = 1;
		Template.AbilityCooldown = Cooldown;
    }
}