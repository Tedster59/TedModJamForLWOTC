class X2StrategyElement_CustodianPackTechs extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CustodianPack'))
    {
	Techs.AddItem(CreateCustodianAPRoundsProjectTemplate());
	Techs.AddItem(CreateDestroyerGauntletProjectTemplate());
	Techs.AddItem(CreateHyperdriveVestProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateCustodianAPRoundsProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'CustodianAPRoundsProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyCustodianMaster');
	
	Template.Requirements.RequiredItems.AddItem('CorpseCustodianMaster');
	Resources.ItemTemplateName='CorpseCustodianMaster';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('CustodianAPRounds');

	return Template;
}

static function X2DataTemplate CreateDestroyerGauntletProjectTemplate()
{
	local X2TechTemplate Template;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'DestroyerGauntletProject');
	Template.SortingTier = 5;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 30);

	Template.Requirements.RequiredTechs.AddItem('AutopsyCustodianMaster');

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('XcomDestroyerGauntlet');

	return Template;
}

static function X2DataTemplate CreateHyperdriveVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'HyperdriveVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyCustodianMk2');
	
	Template.Requirements.RequiredItems.AddItem('CorpseCustodianMk2');
	Resources.ItemTemplateName='CorpseCustodianMk2';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('HyperdriveVest');

	return Template;
}