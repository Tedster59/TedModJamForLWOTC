class OPTC_FrostTech extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2CharacterTemplate         CharTemplate;
    local X2CharacterTemplateManager  CharacterTemplateManager;

    //  Get the Character Template Manager.
    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    //  Access a specific Character template by name.
    CharTemplate = CharacterTemplateManager.FindCharacterTemplate('FrostTech_M2');

    //  Check if the Character Template was successfully found by the manager.
    if (CharTemplate != none)
    {
        //  Modify template as you wish. 
        //  (in this case, prevent Frost Techs from spawning from ATTs)

		CharTemplate.bAllowSpawnFromATT = false;
    }

	//  Get the Character Template Manager.
    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    //  Access a specific Character template by name.
    CharTemplate = CharacterTemplateManager.FindCharacterTemplate('FrostTech_M3');

    //  Check if the Character Template was successfully found by the manager.
    if (CharTemplate != none)
    {
        //  Modify template as you wish. 
        //  (in this case, prevent Frost Techs from spawning from ATTs)

		CharTemplate.bAllowSpawnFromATT = false;
    }
}