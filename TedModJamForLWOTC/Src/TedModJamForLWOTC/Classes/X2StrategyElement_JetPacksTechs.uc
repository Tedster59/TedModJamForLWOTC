class X2StrategyElement_JetPacksTechs extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCJetPacks'))
    {
      Techs.AddItem(CreateJetBoosters_MK1_Tech_LWProjectTemplate());
	  Techs.AddItem(CreateJetBoosters_MK2_Tech_LWProjectTemplate());
    }

    return Techs;
}	

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateJetBoosters_MK1_Tech_LWProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'JetBoosters_MK1_Tech_LW');
	Template.SortingTier =3;
	Template.strImage = "img:///JetPacks_UI.Jetpack_ProvingGrounds";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMec');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventMec');
	Resources.ItemTemplateName='CorpseAdventMec';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('IRI_JetBoosters_MK1');

	return Template;
}

static function X2DataTemplate CreateJetBoosters_MK2_Tech_LWProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'JetBoosters_MK2_Tech_LW');
	Template.SortingTier =3;
	Template.strImage = "img:///JetPacks_UI.Jetpack_eleirum_Proving_grounds";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMec');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventMec');
	Resources.ItemTemplateName='CorpseAdventMec';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('IRI_JetBoosters_MK2');

	return Template;
}