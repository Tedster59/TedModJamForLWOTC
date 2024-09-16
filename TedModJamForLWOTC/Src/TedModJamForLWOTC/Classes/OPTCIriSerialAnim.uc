class OPTCIriSerialAnim extends X2DownloadableContentInfo config(CanHaveGunRaiseAnimation);

var config name IriSerialAnimAbility;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate         Template;
    local X2AbilityTemplateManager  AbilityTemplateManager;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate(default.IriSerialAnimAbility);

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish.
        //  (in this case, add new conditions to restrict who can get the new animation based on class and/or character template)
		Template.AbilityShooterConditions.AddItem(new class'X2Condition_GRA_ClassRestriction');
		Template.AbilityShooterConditions.AddItem(new class'X2Condition_GRA_CharacterRestriction');
    }
}