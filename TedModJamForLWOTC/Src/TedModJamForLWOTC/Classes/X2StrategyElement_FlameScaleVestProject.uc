class X2StrategyElement_FlameScaleVestProject extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WotC_AshlynneFlameViper'))
    {
	Techs.AddItem(CreateFlameScaleVestProjectTemplate());
	Techs.AddItem(CreateSeethingRoundsProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateFlameScaleVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'FlameScaleVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('Autopsy_AshFlameViper');
	
	Template.Requirements.RequiredItems.AddItem('Corpse_AshFlameViper');
	Resources.ItemTemplateName='Corpse_AshFlameViper';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('UtilityItem_AshFlameScaleVest');

	return Template;
}

static function X2DataTemplate CreateSeethingRoundsProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'SeethingRoundsProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('Autopsy_AshFlameViper');
	
	Template.Requirements.RequiredItems.AddItem('Corpse_AshFlameViper');
	Resources.ItemTemplateName='Corpse_AshFlameViper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('SeethingRounds');

	return Template;
}