class X2StrategyElement_AdditionalVestTypesProjects extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('MZVestMod'))
    {
	Techs.AddItem(CreateMZScabWeaveProjectTemplate());
	Techs.AddItem(CreateMZBubbleWeaveProjectTemplate());
	Techs.AddItem(CreateMZRepairWeaveProjectTemplate());
	Techs.AddItem(CreateMZMindWeaveProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateMZScabWeaveProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MZScabWeaveProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyCelatid');
	
	Template.Requirements.RequiredItems.AddItem('CorpseCelatid');
	Resources.ItemTemplateName='CorpseCelatid';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZScabWeave');

	return Template;
}

static function X2DataTemplate CreateMZBubbleWeaveProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MZBubbleWeaveProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdvBioBarrierTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdvBioBarrierTrooper');
	Resources.ItemTemplateName='CorpseAdvBioBarrierTrooper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZBubbleWeave');

	return Template;
}

static function X2DataTemplate CreateMZRepairWeaveProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MZRepairWeaveProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyExaltedCustodianGrandmaster');
	
	Template.Requirements.RequiredItems.AddItem('CorpseExaltedCustodianGrandmaster');
	Resources.ItemTemplateName='CorpseExaltedCustodianGrandmaster';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZRepairWeave');

	return Template;
}

static function X2DataTemplate CreateMZMindWeaveProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'MZMindWeaveProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('Autopsy_AshAdvWarlock');
	
	Template.Requirements.RequiredItems.AddItem('Corpse_AshAdvWarlock');
	Resources.ItemTemplateName='Corpse_AshAdvWarlock';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('MZMindWeave');

	return Template;
}