class OPTC_Puppeteer extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustHaywireAbility(AbilityTemplateManager.FindAbilityTemplate('HaywireProtocol'));
}

static function AdjustHaywireAbility(X2AbilityTemplate Template)
{
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		PuppeteerDoesNotConsume(Template);
    }
}

static function PuppeteerDoesNotConsume(X2AbilityTemplate Template)
{
    local X2AbilityCost Costs;
    local X2AbilityCost_ActionPoints    APCost;

    foreach Template.AbilityCosts( Costs ) 
    {
        if (X2AbilityCost_ActionPoints (Costs) != none )
        {
            APCost = X2AbilityCost_ActionPoints (Costs);
            APCost.DoNotConsumeAllSoldierAbilities.AddItem('ShadowOps_Puppeteer');
        }
    }
}