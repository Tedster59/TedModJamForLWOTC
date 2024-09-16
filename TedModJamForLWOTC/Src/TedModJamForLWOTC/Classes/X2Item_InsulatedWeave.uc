class X2Item_InsulatedWeave extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('FrostDivision') && class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('MZVestMod'))
	{
	Items.AddItem(InsulatedWeave());
	Items.AddItem(CreateThermalSubArmor());
	}

	return Items;
}

static function X2DataTemplate InsulatedWeave()
{
	local X2EquipmentTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'InsulatedWeave');
	Template.ItemCat = 'defense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage =  "img:///UILibrary_MZVestMod.Armory_AM_RegenWeave_R";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Abilities.AddItem('InsulatedWeaveStats');

	Template.CanBeBuilt = true;
	Template.TradingPostValue = 3;
	Template.Tier = 2;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}

static function X2DataTemplate CreateThermalSubArmor()
{
	local X2EquipmentTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'ThermalSubArmor');
	Template.ItemCat = 'defense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_DLC3Images.Inv_Spark_Plated_B";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated_Spark";

	Template.Abilities.AddItem('InsulatedWeaveStats');
	//Template.Abilities.AddItem('Ceramic_Plating_Ability');

	Template.CanBeBuilt = true;
	Template.TradingPostValue = 3;
	Template.Tier = 2;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 5;
	Template.Cost.ResourceCosts.AddItem(Resources);

	return Template;
}