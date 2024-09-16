class X2Item_BioMecSubArmor extends X2Item config(BDData);

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Items.AddItem(CreateBioMecSubArmor());
	}

	return Items;
}

static function X2DataTemplate CreateBioMecSubArmor()
{
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'BioMecSubArmor');
	Template.ItemCat = 'defense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_DLC3Images.Inv_Spark_Plated_A";
	Template.EquipSound = "StrategyUI_Armor_Equip_Plated_Spark";

	Template.Tier = 1;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_BioMecSubArmor'.default.BIO_MEC_SUB_ARMOR_HP_BONUS);

	Template.Abilities.AddItem('BioMecSubArmorBonus');
	Template.Abilities.AddItem('BioMecImmunities');

	return Template;
}