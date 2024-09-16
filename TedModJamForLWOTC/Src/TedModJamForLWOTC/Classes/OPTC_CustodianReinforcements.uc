class OPTC_CustodianReinforcements extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2CharacterTemplateManager        CharacterTemplateManager;

    //  Get the Character Template Manager.
    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    NoATT(CharacterTemplateManager.FindCharacterTemplate('AdventCustodian'));
	NoATT(CharacterTemplateManager.FindCharacterTemplate('Mk2_Custodian'));
	NoATT(CharacterTemplateManager.FindCharacterTemplate('AdventCustodianMaster'));
	NoATT(CharacterTemplateManager.FindCharacterTemplate('ExaltedCustodian'));
	NoATT(CharacterTemplateManager.FindCharacterTemplate('ExaltedCustodian_Grandmaster'));
}

static function NoATT (X2CharacterTemplate CharTemplate)
{
    if (CharTemplate != none)
    {
        //  Modify template as you wish.
		CharTemplate.bAllowSpawnFromATT = false;
    }
}
