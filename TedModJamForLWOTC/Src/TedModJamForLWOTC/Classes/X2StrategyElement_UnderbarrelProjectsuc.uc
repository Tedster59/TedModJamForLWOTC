class X2StrategyElement_UnderbarrelProjectsuc extends X2StrategyElement_DefaultTechs;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Techs;
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCUnderbarrelAttachments'))
    {
	Techs.AddItem(CreateUnderbarrelShotgunProjectTemplate());
	Techs.AddItem(CreateUnderbarrelGrenadeLauncherProjectTemplate());
	Techs.AddItem(CreateUnderbarrelFlamethrowerProjectTemplate());
	}
	return Techs;
}

static function X2DataTemplate CreateUnderbarrelShotgunProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;
	
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'UnderbarrelShotgunProject');
	Template.SortingTier = 6;
	Template.strImage = "img:///Underbarrel.UI.Underbarrel";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 15);	
	
	Template.Requirements.RequiredItems.AddItem('UBS_Conv');
	Template.Requirements.RequiredTechs.AddItem('ModularWeapons');
	
	Resources.ItemTemplateName = 'UBS_Conv';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateUnderbarrelGrenadeLauncherProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;
	
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'UnderbarrelGrenadeLauncherProject');
	Template.SortingTier = 6;
	Template.strImage = "img:///Underbarrel.UI.Underbarrel";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 15);	
	
	Template.Requirements.RequiredItems.AddItem('UBGL_Conv');
	Template.Requirements.RequiredTechs.AddItem('ModularWeapons');
	
	Resources.ItemTemplateName = 'UBGL_Conv';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateUnderbarrelFlamethrowerProjectTemplate()
{
	local X2TechTemplate Template;
	local ArtifactCost Resources;
	
	`CREATE_X2TEMPLATE(class'X2TechTemplate', Template, 'UnderbarrelFlamethrowerProject');
	Template.SortingTier = 6;
	Template.strImage = "img:///Underbarrel.UI.Underbarrel";
	Template.bProvingGround = true;
	Template.PointsToComplete = StafferXDays(1, 15);	
	
	Template.Requirements.RequiredItems.AddItem('UBFlame_Conv');
	Template.Requirements.RequiredTechs.AddItem('ModularWeapons');
	
	Resources.ItemTemplateName = 'UBFlame_Conv';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'EleriumCore';
	Resources.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Resources);

	return Template;
}