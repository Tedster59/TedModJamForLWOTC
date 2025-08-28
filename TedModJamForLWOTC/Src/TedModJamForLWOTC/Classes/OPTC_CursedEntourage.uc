//Updating the Cursed Trooper and Stun Lancer to match their ADVENT counterparts--stat and ability wise
//Adding OnPostEncounterCreation handling to replace regular troops with Cursed troops if a Sorcerer is present
class OPTC_CursedEntourage extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2CharacterTemplateManager CharMgr;
	local array<X2DataTemplate> TargetTemplates, DonorTemplates;
	local array<name> TargetNames, DonorNames;
	local int i;

	CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	TargetNames.AddItem('AshArmoredTrooperM1');
	TargetNames.AddItem('AshArmoredTrooperM2');
	TargetNames.AddItem('AshArmoredTrooperM3');
	TargetNames.AddItem('AshCursedStunLancerM1');
	TargetNames.AddItem('AshCursedStunLancerM2');
	TargetNames.AddItem('AshCursedStunLancerM3');
	DonorNames.AddItem('AdvTrooperM1');
	DonorNames.AddItem('AdvTrooperM2');
	DonorNames.AddItem('AdvTrooperM3');
	DonorNames.AddItem('AdvStunLancerM1');
	DonorNames.AddItem('AdvStunLancerM2');
	DonorNames.AddItem('AdvStunLancerM3');

	//Updating the Cursed units to match their regular counterparts
	for (i = 0; i < TargetNames.Length; i++)
	{
		CharMgr.FindDataTemplateAllDifficulties(TargetNames[i], TargetTemplates);
		CharMgr.FindDataTemplateAllDifficulties(DonorNames[i], DonorTemplates);
		CloneUnitAbilities(TargetTemplates, DonorTemplates);
	}
}

static function CloneUnitAbilities(array<X2DataTemplate> TargetTemplates, array<X2DataTemplate> DonorTemplates)
{
	local int i, j;
	local X2CharacterTemplate TargetTemplate, DonorTemplate;
	local name AbilityName;

	if (TargetTemplates.Length != 0 && DonorTemplates.Length != 0
		&& TargetTemplates.Length == DonorTemplates.Length) 
	{ 
		//Copying over any special abilities
		for (i = 0; i < TargetTemplates.Length; i++)
		{
			TargetTemplate = X2CharacterTemplate(TargetTemplates[i]);
			DonorTemplate = X2CharacterTemplate(DonorTemplates[i]);
			if (TargetTemplate != none && DonorTemplate != none)
			{
				for (j = 0; j < DonorTemplate.Abilities.Length; j++)
				{
					AbilityName = DonorTemplate.Abilities[j];
					if (TargetTemplate.Abilities.Find(AbilityName) == INDEX_NONE)
					{
						TargetTemplate.Abilities.AddItem(AbilityName);
					}
				}
			}
		}
	}
}

static function PostEncounterCreation(out name EncounterName, out PodSpawnInfo SpawnInfo, int ForceLevel, int AlertLevel, optional XComGameState_BaseObject SourceObject)
{
	local int i;
	local bool bFound;

	bFound = false;

	//Look for Sorcerers
	for (i = 0; i < SpawnInfo.SelectedCharacterTemplateNames.Length; i++)
	{
		if (InStr(SpawnInfo.SelectedCharacterTemplateNames[i], "AshAdvWarlock") != INDEX_NONE)
		{
			bFound = true;
			break;
		}
	}

	if (bFound)
	{
		if (i == 0)
		{
			//Sorcerer is the leader: give them a cursed posse
			ReplaceAllCorrespondingUnits(SpawnInfo);
		}
		else
		{
			//Sorcerer as a follower: swap basic advent units
			ReplaceBasicCorrespondingUnits(SpawnInfo);
		}
	}
}

static function ReplaceBasicCorrespondingUnits(out PodSpawnInfo SpawnInfo)
{
	local X2CharacterTemplateManager CharMgr;
	local int i;
	local name ReplacementName;
	local X2CharacterTemplate Template;

	CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	for (i = 0; i < SpawnInfo.SelectedCharacterTemplateNames.Length; i++)
	{
		switch(SpawnInfo.SelectedCharacterTemplateNames[i])
		{
			case 'AdvTrooperM1':
				ReplacementName = 'AshArmoredTrooperM1';
				break;
			case 'AdvTrooperM2':
				ReplacementName = 'AshArmoredTrooperM2';
				break;
			case 'AdvTrooperM3':
				ReplacementName = 'AshArmoredTrooperM3';
				break;
			case 'AdvStunLancerM1':
				ReplacementName = 'AshCursedStunLancerM1';
				break;
			case 'AdvStunLancerM2':
				ReplacementName = 'AshCursedStunLancerM2';
				break;
			case 'AdvStunLancerM3':
				ReplacementName = 'AshCursedStunLancerM3';
				break;
			default:
				ReplacementName = '';
				break;
		}

		if (ReplacementName != '')
		{
			Template = CharMgr.FindCharacterTemplate(ReplacementName);
			if (Template != none)
			{
				`log("Replaced unit" @ SpawnInfo.SelectedCharacterTemplateNames[i] @ "in pod with the corresponding cursed unit -" @ ReplacementName,,'TedLog');
				SpawnInfo.SelectedCharacterTemplateNames[i] = ReplacementName;
				SpawnInfo.SelectedCharacterTemplates[i] = Template;
			}
		}
	}
}

static function ReplaceAllCorrespondingUnits(out PodSpawnInfo SpawnInfo)
{
	local X2CharacterTemplateManager CharMgr;
	local int i;
	local name ReplacementName;
	local X2CharacterTemplate Template;

	CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	for (i = 0; i < SpawnInfo.SelectedCharacterTemplateNames.Length; i++)
	{
		switch(SpawnInfo.SelectedCharacterTemplateNames[i])
		{
			case 'AdvTrooperM1':
			case 'AdvBioTrooperM1':
			case 'AdvBioTrooperFakeM1':
			case 'FrostTrooper_M1':
				ReplacementName = 'AshArmoredTrooperM1';
				break;
			case 'AdvTrooperM2':
			case 'AdvBioTrooperM2':
			case 'AdvBioTrooperFakeM2':
			case 'FrostTrooper_M2':
			case 'FrostPuddingTrooper_M2':
				ReplacementName = 'AshArmoredTrooperM2';
				break;
			case 'AdvTrooperM3':
			case 'AdvBioTrooperM3':
			case 'AdvBioTrooperFakeM3':
			case 'FrostTrooper_M3':
			case 'FrostPuddingTrooper_M3':
				ReplacementName = 'AshArmoredTrooperM3';
				break;
			case 'AdvStunLancerM1':
			case 'FrostLancer_M1':
				ReplacementName = 'AshCursedStunLancerM1';
				break;
			case 'AdvStunLancerM2':
			case 'FrostLancer_M2':
				ReplacementName = 'AshCursedStunLancerM2';
				break;
			case 'AdvStunLancerM3':
			case 'FrostLancer_M3':
				ReplacementName = 'AshCursedStunLancerM3';
				break;
			default:
				ReplacementName = '';
				break;
		}

		if (ReplacementName != '')
		{
			Template = CharMgr.FindCharacterTemplate(ReplacementName);
			if (Template != none)
			{
				`log("Replaced unit" @ SpawnInfo.SelectedCharacterTemplateNames[i] @ "in pod with the corresponding cursed unit -" @ ReplacementName,,'TedLog');
				SpawnInfo.SelectedCharacterTemplateNames[i] = ReplacementName;
				SpawnInfo.SelectedCharacterTemplates[i] = Template;
			}
		}
	}
}