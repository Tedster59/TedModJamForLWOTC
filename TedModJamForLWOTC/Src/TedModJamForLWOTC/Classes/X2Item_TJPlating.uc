class X2Item_TJPlating extends X2Item config(TJPlating);

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

    Items.AddItem(CreateCerebralPlating());
	Items.AddItem(CreateReflexPlating());
	Items.AddItem(CreateFrostPlating());
	Items.AddItem(CreateChameleonPlating());

	return Items;
}

static function X2DataTemplate CreateCerebralPlating()
{
	local X2EquipmentTemplate Template; 

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'CerebralPlating');
	Template.ItemCat = 'plating';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_TJ_Plating.XCOM2_Inv_Cerebral_Plating";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Tier = 2;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.Abilities.AddItem('Cerebral_Plating_Ability');

	return Template;
}

static function X2DataTemplate CreateReflexPlating()
{
	local X2EquipmentTemplate Template; 

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'ReflexPlating');
	Template.ItemCat = 'plating';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_TJ_Plating.XCOM2_Inv_Reflex_Plating";
	Template.EquipSound = "StrategyUI_Vest_Equip";
	
	Template.Tier = 2;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.Abilities.AddItem('Reflex_Plating_Ability');
	Template.Abilities.AddItem('ReflexPlatingBonus_LW');

	return Template;
}

static function X2DataTemplate CreateFrostPlating()
{
	local X2EquipmentTemplate Template; 

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'FrostPlating');
	Template.ItemCat = 'plating';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_TJ_Plating.XCOM2_Inv_Frost_Plating";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Tier = 2;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.Abilities.AddItem('Frost_Plating_Ability');
	Template.Abilities.AddItem('FrostPlatingBonus_LW');

	return Template;
}

static function X2DataTemplate CreateChameleonPlating()
{
	local X2EquipmentTemplate Template; 

	`CREATE_X2TEMPLATE(class'X2EquipmentTemplate', Template, 'ChameleonPlating');
	Template.ItemCat = 'plating';
	Template.InventorySlot = eInvSlot_Utility;
	Template.strImage = "img:///UILibrary_LWOTC.InventoryArt.Inv_Tarantula_Suit_512";
	Template.EquipSound = "StrategyUI_Vest_Equip";

	Template.Tier = 2;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;

	Template.Abilities.AddItem('Chameleon_Plating_Ability');
	Template.Abilities.AddItem('ChameleonPlatingBonus_LW');

	return Template;
}