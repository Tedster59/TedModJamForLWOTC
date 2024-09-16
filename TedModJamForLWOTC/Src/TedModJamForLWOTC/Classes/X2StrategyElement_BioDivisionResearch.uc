class X2StrategyElement_BioDivisionResearch extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Techs.AddItem(CreateTechTemplate_AutopsyAdvBioTrooper());
	Techs.AddItem(CreateTechTemplate_AutopsyAdvBioOfficer());
	Techs.AddItem(CreateTechTemplate_AutopsyAdvBioBarrierTrooper());
	Techs.AddItem(CreateTechTemplate_AutopsyBioMec());

	Techs.AddItem(CreateNeurotoxinGrenadeProjectTemplate());
	Techs.AddItem(CreateNeurotoxinBombProjectTemplate());
	Techs.AddItem(CreateBioAlloyPlatingProjectTemplate());
	Techs.AddItem(CreateBioRocketLauncherProjectTemplate());
	Techs.AddItem(CreateBioBlasterLauncherProjectTemplate());
	Techs.AddItem(CreateBioDemonweaveProjectTemplate());
	Techs.AddItem(CreateBioCyaneaSuitProjectTemplate());
	Techs.AddItem(CreateBioViperScaleVestProjectTemplate());
	Techs.AddItem(CreateAdvancedBioViperScaleVestProjectTemplate());
	Techs.AddItem(CreateBioNanoscaleVestProjectTemplate());
	Techs.AddItem(CreateRadRoundsProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdvBioTrooper()
{
	//This template is the ADVENT BIO TROOPER Autopsy Laboratory research project

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdvBioTrooper');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioTrooper";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	
	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdvBioTrooper');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdvBioTrooper';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdvBioTrooper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdvBioOfficer()
{
	//This template is the ADVENT BIO OFFICER Autopsy Laboratory research project

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdvBioOfficer');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioCaptain";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	
	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdvBioOfficer');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdvBioOfficer';
	Artifacts.Quantity = 5;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdvBioOfficer';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTechTemplate_AutopsyAdvBioBarrierTrooper()
{
	//This template is the ADVENT BIO BARRIER TROOPER Autopsy Laboratory research project

	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyAdvBioBarrierTrooper');
	Template.PointsToComplete = 2000;
	Template.strImage = "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioAssault";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	Template.Requirements.RequiredTechs.AddItem('AlienBiotech');
	Template.Requirements.RequiredItems.AddItem('CorpseAdvBioBarrierTrooper');

	//Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseAdvBioBarrierTrooper';
	Artifacts.Quantity = 5;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	//Cost
	Artifacts.ItemTemplateName = 'CorpseAdvBioBarrierTrooper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateTechTemplate_AutopsyBioMec()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AutopsyBioMec');
	Template.PointsToComplete = 2500;
	Template.strImage = "img:///UILIB_BioDivision.Autopsies.IC_AutopsyBioMech";
	Template.bAutopsy = true;
	Template.bCheckForceInstant = true;
	Template.SortingTier = 2;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyDrone');
	Template.Requirements.RequiredItems.AddItem('CorpseBioMec');

	// Instant Requirements. Will become the Cost if the tech is forced to Instant.
	Artifacts.ItemTemplateName = 'CorpseBioMec';
	Artifacts.Quantity = 10;
	Template.InstantRequirements.RequiredItemQuantities.AddItem(Artifacts);

	// Cost
	Artifacts.ItemTemplateName = 'CorpseBioMec';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateNeurotoxinGrenadeProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'NeurotoxinGrenadeProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdvBioOfficer');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('NeurotoxinGrenade');

	return Template;
}

static function X2DataTemplate CreateNeurotoxinBombProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'NeurotoxinBombProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AdvancedGrenades');
	Template.Requirements.RequiredTechs.AddItem('NeurotoxinGrenadeProject');
	
	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('NeurotoxinBomb');

	return Template;
}

static function X2DataTemplate CreateBioAlloyPlatingProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioAlloyPlatingProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdvBioTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdvBioTrooper');
	Resources.ItemTemplateName='CorpseAdvBioTrooper';
	Resources.Quantity = 3;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('BioAlloyPlating');

	return Template;
}

static function X2DataTemplate CreateBioRocketLauncherProjectTemplate()
{
	local X2TechTemplate Template;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioRocketLauncherProject');
	Template.SortingTier = 5;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('AutopsyAdvBioRocketTrooper');
	Template.Requirements.RequiredTechs.AddItem('PlasmaGrenade');
	Template.Requirements.RequiredTechs.AddItem('EXOSuit');

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('Weapon_BioRocket');

	return Template;
}

static function X2DataTemplate CreateBioBlasterLauncherProjectTemplate()
{
	local X2TechTemplate Template;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioBlasterLauncherProject');
	Template.SortingTier = 5;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Heavy_Weapons_Project";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 30);

	Template.Requirements.RequiredTechs.AddItem('AutopsyBioMec');
	Template.Requirements.RequiredTechs.AddItem('HeavyPlasma');
	Template.Requirements.RequiredTechs.AddItem('WARSuit');

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('BioBlasterLauncherXCom');

	return Template;
}

static function X2DataTemplate CreateBioDemonweaveProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioDemonweaveProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyBioZerker');
	
	Template.Requirements.RequiredItems.AddItem('CorpseBioZerker');
	Resources.ItemTemplateName='CorpseBioZerker';
	Resources.Quantity = 3;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('BioDemonweave');

	return Template;
}

static function X2DataTemplate CreateBioCyaneaSuitProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioCyaneaSuitProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyBioFaceless');
	
	Template.Requirements.RequiredItems.AddItem('CorpseBioFaceless');
	Resources.ItemTemplateName='CorpseBioFaceless';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('BioCyaneaSuit');

	return Template;
}

static function X2DataTemplate CreateBioViperScaleVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioViperScaleVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyBioViper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseBioViper');
	Resources.ItemTemplateName='CorpseBioViper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('BioViperScaleVest');

	return Template;
}

static function X2DataTemplate CreateAdvancedBioViperScaleVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'AdvancedBioViperScaleVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyEliteBioViper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseEliteBioViper');
	Resources.ItemTemplateName='CorpseBioViper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('AdvancedBioViperScaleVest');

	return Template;
}

static function X2DataTemplate CreateBioNanoscaleVestProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BioNanoscaleVestProject');
	Template.SortingTier = 2;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_ExperimentalArmor";
	Template.bProvingGround = true;
	Template.bArmor = true;
	Template.PointsToComplete = StafferXDays(1, 15);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdvBioAssaultTrooper');
	
	Template.Requirements.RequiredItems.AddItem('CorpseAdvBioAssaultTrooper');
	Resources.ItemTemplateName='CorpseAdvBioAssaultTrooper';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('BioNanoscaleVest');

	return Template;
}

static function X2DataTemplate CreateRadRoundsProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'RadRoundsProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyBioZerker');
	
	Template.Requirements.RequiredItems.AddItem('BioCanister');
	Resources.ItemTemplateName='BioCanister';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('RadRounds');

	return Template;
}