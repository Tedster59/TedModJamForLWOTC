class X2StrategyElement_BitterfrostProtocolProjects extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('MZFrostRounds'))
	{
	Techs.AddItem(CreateBitterfrostRoundsProjectTemplate());
	Techs.AddItem(CreateBitterfrostGrenadeProjectTemplate());
	Techs.AddItem(CreateBitterfrostBombProjectTemplate());
	Techs.AddItem(CreateCryoLauncherProjectTemplate());
	Techs.AddItem(CreateCryoLauncherMk2ProjectTemplate());
	Techs.AddItem(CreateFrostweaveProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateBitterfrostRoundsProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BitterfrostRoundsProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventCryoRocketeer');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventCryoRocketeer');
	Resources.ItemTemplateName='CorpseAdventCryoRocketeer';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZFrostRounds');

	return Template;
}

static function X2DataTemplate CreateBitterfrostGrenadeProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BitterfrostGrenadeProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventCryoPriest');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZBitterFrostGrenade');

	return Template;
}

static function X2DataTemplate CreateBitterfrostBombProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BitterfrostBombProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AdvancedGrenades');
	Template.Requirements.RequiredTechs.AddItem('BitterfrostGrenadeProject');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZBitterFrostBomb');

	return Template;
}

static function X2DataTemplate CreateCryoLauncherProjectTemplate()
{
	local X2TechTemplate Template;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'CryoLauncherProject');
	Template.SortingTier = 5;
	Template.strImage = "img:///MZ_BitterFrost_StratImages.Inv_CryoLauncher";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventCryoRocketeer');
	Template.Requirements.RequiredTechs.AddItem('EXOSuit');

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZCryoLauncher');

	return Template;
}

static function X2DataTemplate CreateCryoLauncherMk2ProjectTemplate()
{
	local X2TechTemplate Template;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'CryoLauncherMk2Project');
	Template.SortingTier = 5;
	Template.strImage = "img:///MZ_BitterFrost_StratImages.Inv_CryoLauncher2";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('CryoLauncherProject');
	Template.Requirements.RequiredTechs.AddItem('PlasmaGrenade');
	Template.Requirements.RequiredTechs.AddItem('WARSuit');

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZCryoLauncherMk2');

	return Template;
}

static function X2DataTemplate CreateFrostweaveProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'FrostweaveProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventCryoPriest');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventCryoPriest');
	Resources.ItemTemplateName='CorpseAdventCryoPriest';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZIceVest');

	return Template;
}