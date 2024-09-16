class X2StrategyElement_CorrosiveRoundsProject extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTC_CorrosiveRounds'))
    {
      Techs.AddItem(CreateCorrosiveRoundsProjectTemplate());
    }

    return Techs;
}	

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateCorrosiveRoundsProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'CorrosiveRoundsProject');
	Template.SortingTier =3;
	Template.strImage = "img:///UILibrary_StrategyImages.ResearchTech.TECH_Experimental_Ammo";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyBioMec');
	
	Template.Requirements.RequiredItems.AddItem('CorpseBioMec');
	Resources.ItemTemplateName='CorpseBioMec';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('CorrosiveRounds');

	return Template;
}