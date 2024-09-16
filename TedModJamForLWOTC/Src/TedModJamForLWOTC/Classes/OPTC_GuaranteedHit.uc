// This file's job is to make abilities that are not guaranteed hits, but SHOULD BE, now guaranteed hits.
// I don't know if there's an actual reason Firaxis didn't add bGuaranteedHit = true to grenades/mines, so it can be toggled off if it causes problems.

class OPTC_GuaranteedHit extends X2DownloadableContentInfo config(Game);

var config bool ENABLE_GRENADE_ACCURACY_FIX;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	if(default.ENABLE_GRENADE_ACCURACY_FIX)
	{
		MakeAbilityGuaranteedHitGrenade(AbilityTemplateManager.FindAbilityTemplate('ThrowGrenade'));
		MakeAbilityGuaranteedHitGrenade(AbilityTemplateManager.FindAbilityTemplate('LaunchGrenade'));
		MakeAbilityGuaranteedHitGrenade(AbilityTemplateManager.FindAbilityTemplate('GrenadeFuse'));
		MakeAbilityGuaranteedHitGrenade(AbilityTemplateManager.FindAbilityTemplate('MZThrowGrenadeTrap'));
		MakeAbilityGuaranteedHitMine(AbilityTemplateManager.FindAbilityTemplate('ProximityMineDetonation'));
		MakeAbilityGuaranteedHitMine(AbilityTemplateManager.FindAbilityTemplate('MZGrenadeTrapDetonate'));
	}
}
 
static function MakeAbilityGuaranteedHitGrenade(X2AbilityTemplate Template)
{
    local X2AbilityToHitCalc_StandardAim    ToHitCalc;
    
	if (Template != none)
    {
		ToHitCalc = new class'X2AbilityToHitCalc_StandardAim';
		ToHitCalc.bIndirectFire = true;
		ToHitCalc.bAllowCrit = false;
		ToHitCalc.bGuaranteedHit = true;
		Template.AbilityToHitCalc = ToHitCalc;
	}

}

static function MakeAbilityGuaranteedHitMine(X2AbilityTemplate Template)
{
    local X2AbilityToHitCalc_StandardAim			ToHit;
    
	if (Template != none)
    {
		ToHit = new class'X2AbilityToHitCalc_StandardAim';
		ToHit.bIndirectFire = true;
		ToHit.bGuaranteedHit = true;
		Template.AbilityToHitCalc = ToHit;
	}

}