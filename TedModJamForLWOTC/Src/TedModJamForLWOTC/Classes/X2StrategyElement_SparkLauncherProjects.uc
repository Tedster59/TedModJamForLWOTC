class X2StrategyElement_SparkLauncherProjects extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('SPARKLaunchersRedux'))
    {
	Techs.AddItem(CreateAdaptedLauncherProjectTemplate());
	Techs.AddItem(CreateArcherLauncherProjectTemplate());
	Techs.AddItem(CreateSmokeLauncherProjectTemplate());
	Techs.AddItem(CreateSupportLauncherProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateAdaptedLauncherProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdaptedLauncherProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('MechanizedWarfare');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMec');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RM_SPARKLauncher_CV_paired');

	return Template;
}

static function X2DataTemplate CreateArcherLauncherProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ArcherLauncherProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AdvancedGrenades');
	Template.Requirements.RequiredTechs.AddItem('AdaptedLauncherProject');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RM_SPARKLauncher_MG_paired');

	return Template;
}

static function X2DataTemplate CreateSmokeLauncherProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SmokeLauncherProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('MechanizedWarfare');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventMec');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RM_SupportLauncher_CV_paired');

	return Template;
}

static function X2DataTemplate CreateSupportLauncherProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SupportLauncherProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AdvancedGrenades');
	Template.Requirements.RequiredTechs.AddItem('SmokeLauncherProject');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RM_SupportLauncher_MG_paired');

	return Template;
}