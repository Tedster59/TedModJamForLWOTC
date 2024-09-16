class X2StrategyElement_BlackFlameGrenadeProject extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('MutonHarriers'))
    {
      Techs.AddItem(CreateBlackFlameGrenadeProject());
    }

    return Techs;
}	

static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}

static function X2DataTemplate CreateBlackFlameGrenadeProject()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'BlackFlameGrenadeProject');
	Template.SortingTier =3;
	Template.strImage = "img:///WoTC_Muton_Harrier_UI.Proving_Grounds_Black_Flame_Grenade";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 20);

	Template.Requirements.RequiredTechs.AddItem('HybridMaterials');
	Template.Requirements.RequiredTechs.AddItem('AutopsyGrenadeRemains');
	
	Template.Requirements.RequiredItems.AddItem('CorpseGrenadeRemains');
	Resources.ItemTemplateName='CorpseGrenadeRemains';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName='AlienAlloy';
	Resources.Quantity = 1;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
	Template.ItemRewards.AddItem('Xcom_BlackFlame_Grenade');

	return Template;
}