class X2StrategyElement_PsiArmorTech extends X2StrategyElement;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Techs;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('EUPsiArmor'))
    {
	Techs.AddItem(CreatePsiArmorTechLWTemplate());
	}

	return Techs;
}

//---------------------------------------------------------------------------------------
// Helper function for calculating project time
static function int StafferXDays(int iNumScientists, int iNumDays)
{
	return (iNumScientists * 5) * (24 * iNumDays); // Scientists at base skill level
}


// #######################################################################################
// -------------------- ARMOR TECHS ------------------------------------------------------
// #######################################################################################

static function X2DataTemplate CreatePsiArmorTechLWTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Artifacts;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'PsiArmorTech_LW');
	Template.PointsToComplete = StafferXDays(1, 7);
	Template.SortingTier = 1;
	Template.strImage = "img:///PsiArmor.UILib.TEC_PsiArmor";

	Template.bArmor = true;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlatedArmor');
	Template.Requirements.RequiredTechs.AddItem('Psionics');
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPriest');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 75;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
	Resources.Quantity = 15;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumDust';
	Resources.Quantity = 10;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'EleriumCore';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}