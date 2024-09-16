class X2StrategyElement_ConcussionGrenadeProject extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WotC_AshlynneMutonDestroyer'))
	{
	Techs.AddItem(CreateConcussionGrenadeProjectTemplate());
	}

	return Techs;
}

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateConcussionGrenadeProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'ConcussionGrenadeProject');
	Template.SortingTier =4;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('Autopsy_AshMutonDestroyer');
	
	Template.Requirements.RequiredItems.AddItem('Corpse_AshMutonDestroyer');
	
	Resources.ItemTemplateName = 'Corpse_AshMutonDestroyer';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('Weapon_AshConcussionGrenadeXCom');

	return Template;
}