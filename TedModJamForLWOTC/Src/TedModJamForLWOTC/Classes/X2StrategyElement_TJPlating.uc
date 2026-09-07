class X2StrategyElement_TJPlating extends X2StrategyElement_DefaultTechs config(GameData);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	Techs.AddItem(CreateCerebralPlatingProjectTemplate());
	Techs.AddItem(CreateReflexPlatingProjectTemplate());
	Techs.AddItem(CreateFrostPlatingProjectTemplate());
	Techs.AddItem(CreateChameleonPlatingProjectTemplate());

	return Techs;
}

static function X2DataTemplate CreateCerebralPlatingProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'CerebralPlatingProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AlienEncryption');
	
	Template.Requirements.RequiredItems.AddItem('CorpseCyberus');
	Resources.ItemTemplateName='CorpseCyberus';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = GiveRandomItemReward;
	Template.ItemRewards.AddItem('CerebralPlating');

	return Template;
}

static function X2DataTemplate CreateReflexPlatingProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ReflexPlatingProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventStunLancer');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdventStunLancer');
	Resources.ItemTemplateName='CorpseAdventStunLancer';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = GiveRandomItemReward;
	Template.ItemRewards.AddItem('ReflexPlating');

	return Template;
}

static function X2DataTemplate CreateFrostPlatingProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'FrostPlatingProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('MZBitterFrostProtocolTech');
	
	Template.Requirements.RequiredItems.AddItem('MZFD_Cryolite');
	Resources.ItemTemplateName='MZFD_Cryolite';
	Resources.Quantity = 2;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = GiveRandomItemReward;
	Template.ItemRewards.AddItem('FrostPlating');

	return Template;
}

static function X2DataTemplate CreateChameleonPlatingProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ChameleonPlatingProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyFaceless');
	
	Template.Requirements.RequiredItems.AddItem('CorpseFaceless');
	Resources.ItemTemplateName='CorpseFaceless';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = GiveRandomItemReward;
	Template.ItemRewards.AddItem('ChameleonPlating');

	return Template;
}