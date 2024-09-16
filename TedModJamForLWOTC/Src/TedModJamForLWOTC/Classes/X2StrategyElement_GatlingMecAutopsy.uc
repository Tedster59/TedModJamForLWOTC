class X2StrategyElement_GatlingMecAutopsy extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('GatlingMec'))
	{
	Techs.AddItem(CreateTechTemplate_AutopsyGatlingMec());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateTechTemplate_AutopsyGatlingMec()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyGatlingMec');
	Template.PointsToComplete = 2500;
	Template.strImage = "img:///UILibrary_StrategyImages.ScienceIcons.IC_AutopsyMEC";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyDrone');
	Template.Requirements.RequiredItems.AddItem('CorpseGatlingMec');

	// Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseGatlingMec';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	// Cost
	Artifacts.ItemTemplateName = 'CorpseGatlingMec';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}