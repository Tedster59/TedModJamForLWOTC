class X2StrategyElement_JumpJetsTech extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('JetPackMk0'))
    {
      Techs.AddItem(CreateJetBoosters_MK0_Tech_LWProjectTemplate());
    }
	Techs.AddItem(DummyProjectTemplate());

    return Techs;
}	

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateJetBoosters_MK0_Tech_LWProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'JetBoosters_MK0_Tech_LW');
	Template.SortingTier =3;
	Template.strImage = "img:///JetPacks_UI.Jetpack_ProvingGrounds";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AutopsyCelatid');
	
	Template.Requirements.RequiredItems.AddItem('CorpseCelatid');
	Resources.ItemTemplateName='CorpseCelatid';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('JetBoosters_MK0');

	return Template;
}

static function X2DataTemplate DummyProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'DummyProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = false;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventTrooper');
	Resources.ItemTemplateName='CorpseAdventTrooper';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}