class X2Item_BioAlloyPlating extends X2Item config(BDData);

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Items.AddItem(CreateBioAlloyPlating());
	}

	return Items;
}

static function X2DataTemplate CreateBioAlloyPlating()
{
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'BioAlloyPlating');
	Template.ItemCat = 'plating';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Nano_Fiber_Sark";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Tier = 1;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.Abilities.AddItem('Alloy_Plating_Ability');
	Template.Abilities.AddItem('BioImmunities');

	return Template;
}