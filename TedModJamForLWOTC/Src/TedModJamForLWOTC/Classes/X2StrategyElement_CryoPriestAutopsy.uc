class X2StrategyElement_CryoPriestAutopsy extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CryoPriest') || class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('ABetterADVENTDLC'))
    {
	Techs.AddItem(CreateTechTemplate_AutopsyAdventCryoPriest());
	Techs.AddItem(CreateTechTemplate_AutopsyAdventCryoRocketeer());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdventCryoPriest()
{

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdventCryoPriest');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.IC_Priest";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	
	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdventCryoPriest');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdventCryoPriest';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdventCryoPriest';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdventCryoRocketeer()
{

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdventCryoRocketeer');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.IC_Priest";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	
	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdventCryoRocketeer');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdventCryoRocketeer';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdventCryoRocketeer';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}