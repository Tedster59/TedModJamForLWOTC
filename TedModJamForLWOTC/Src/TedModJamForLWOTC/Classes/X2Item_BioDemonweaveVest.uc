class X2Item_BioDemonweaveVest extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Items.AddItem(BioDemonweave());
	}

	return Items;
}

static function X2DataTemplate BioDemonweave()
{
	local X2EquipmentTemplate Template;
	local ArtifactCost Resources;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'BioDemonweave');
	Template.ItemCat = 'defense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Hellweave";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Abilities.AddItem('BioDamageControl');
	Template.Abilities.AddItem('Demonweave');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_BioDemonweaveVest'.default.DEMONWEAVE_HEALTH_BONUS);

	Template.CanBeBuilt = true;
	Template.TradingPostValue = 15;
	Template.Tier = 2;

	Template.bShouldCreateDifficultyVariants = true;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyChryssalid');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 65;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'CorpseChryssalid';
	Artifacts.Quantity = 2;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}