class X2Item_BioCyaneaSuit extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Items.AddItem(CreateBioCyaneaSuit());
	}

	return Items;
}

static function X2DataTemplate CreateBioCyaneaSuit()
{
	local X2EquipmentTemplate Template; 

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'BioCyaneaSuit');
	Template.ItemCat = 'defense';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Tarantula_Suit_512";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Abilities.AddItem('BioBeastImmunities');

	Template.Tier = 2;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	//EFFECT IS CAPTURED IN INFILTRATION CODE

	return Template;
}