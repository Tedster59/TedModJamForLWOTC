// The purpose of this is to add a one-turn cooldown to Scanning Protocol, but only for enemy units (Frost Technician right now).
// This way, they won't waste all of their charges in one turn.

class OPTC_ScanningProtocol extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustScanningProtocolAbility(AbilityTemplateManager.FindAbilityTemplate('ScanningProtocol'));
	AdjustTriggerGuardAbility(AbilityTemplateManager.FindAbilityTemplate('DP_BonusMeleeAim'));
}
 
static function AdjustScanningProtocolAbility(X2AbilityTemplate Template)
{
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  Remove the OLD cooldown!
        Template.AbilityCooldown = none;
 
        //  Add the new cooldown
        Template.AbilityCooldown = new class'X2AbilityCooldown_ScanningProtocol';
    }
}

static function AdjustTriggerGuardAbility(X2AbilityTemplate Template)
{
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
		// Add dummy passive for visibility in tactical
		Template.AdditionalAbilities.AddItem('TriggerGuardDummy');
    }
}