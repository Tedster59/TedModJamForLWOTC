class X2StrategyElement_PurgePriestsTechs extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PurgePriests'))
	{
	Techs.AddItem(CreateTechTemplate_AutopsyAdventPurgePriest());
	Techs.AddItem(CreateTechTemplate_AutopsyAdventExaltedPurgeBishop());

	Techs.AddItem(CreatePurgePlatingProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreatePurgePlatingProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'PurgePlatingProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('CarapacePlatingProject');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventExaltedPurgeBishop');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventExaltedPurgeBishop');
	Resources.ItemTemplateName='CorpseAdventExaltedPurgeBishop';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('PurgePlating');

	return Template;
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdventPurgePriest()
{

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdventPurgePriest');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.IC_Priest";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	
	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdventPurgePriest');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdventPurgePriest';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdventPurgePriest';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdventExaltedPurgeBishop()
{

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdventExaltedPurgeBishop');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.IC_Priest";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	
	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdventExaltedPurgeBishop');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdventExaltedPurgeBishop';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdventExaltedPurgeBishop';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}