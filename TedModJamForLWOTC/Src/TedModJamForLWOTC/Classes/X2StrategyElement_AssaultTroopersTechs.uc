class X2StrategyElement_AssaultTroopersTechs extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AssTroopers'))
	{
	Techs.AddItem(CreateLeadVestProjectTemplate());
	Techs.AddItem(CreateLeadHazmatVestProjectTemplate());
	Techs.AddItem(CreateRadiationRoundsProjectTemplate());
	Techs.AddItem(CreateMagneticGrenadeProjectTemplate());
	Techs.AddItem(CreateLaserGrenadeProjectTemplate());
	Techs.AddItem(CreateRadiationGrenadeProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateLeadVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'LeadVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyT2AssaultTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseT2AssaultTrooper');
	Resources.ItemTemplateName='CorpseT2AssaultTrooper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('LeadVest');

	return Template;
}

static function X2DataTemplate CreateLeadHazmatVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'LeadHazmatVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyT3AssaultTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseT3AssaultTrooper');
	Resources.ItemTemplateName='CorpseT3AssaultTrooper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('LeadHazmatVest');

	return Template;
}

static function X2DataTemplate CreateRadiationRoundsProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'RadiationRoundsProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyT3AssaultTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseT3AssaultTrooper');
	Resources.ItemTemplateName='CorpseT3AssaultTrooper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RadiationRounds');

	return Template;
}

static function X2DataTemplate CreateMagneticGrenadeProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MagneticGrenadeProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyT1AssaultTrooper');
	
	Resources.ItemTemplateName = 'CorpseT1AssaultTrooper';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MagGrenade');

	return Template;
}

static function X2DataTemplate CreateLaserGrenadeProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'LaserGrenadeProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyT2AssaultTrooper');
	
	Resources.ItemTemplateName = 'CorpseT2AssaultTrooper';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('LaserGrenade');

	return Template;
}

static function X2DataTemplate CreateRadiationGrenadeProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'RadiationGrenadeProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyCaptnAssaultTrooper');
	
	Resources.ItemTemplateName = 'CorpseCaptnAssaultTrooper';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RadGrenade');

	return Template;
}