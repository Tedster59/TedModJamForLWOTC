class X2Item_PurgePlating extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PurgePriests'))
	{
	Items.AddItem(CreatePurgePlating());
	}

	return Items;
}

static function X2DataTemplate CreatePurgePlating()
{
	local X2EquipmentTemplate Template;

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'PurgePlating');
	Template.ItemCat = 'plating';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Power_Armor512";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Tier = 1;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.Abilities.AddItem('Carapace_Plating_Ability');
	Template.Abilities.AddItem('FlameControl');
	Template.Abilities.AddItem('Brawler');
	Template.Abilities.AddItem('PurgeImmunitiesDummy');

	return Template;
}