class X2Item_Underbarrels extends X2Item config(Underbarrel);

var config int UBGL_EXTRA_FLAMETHROWER_USES_PER_SECONDARY;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCUnderbarrelAttachments'))
    {
	Items.AddItem(Create_UBFlame_Ammo_Arsonist());
	}

	return Items;
}

static function X2DataTemplate Create_UBFlame_Ammo_Arsonist()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'UBFlame_Ammo_Arsonist');
	Template.ItemCat = 'utility';
	Template.WeaponCat = 'UBFlame_arsonist';
	Template.InventorySlot = eInvSlot_SecondaryWeapon;

	Template.strImage = "img:///Underbarrel.UI.Extra_UBFlame_Ammo";
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.Abilities.AddItem('ExtraCharges_UBFlameSecondary');

	Template.CanBeBuilt = true;
	Template.TradingPostValue = 0;
	Template.PointsToComplete = 0;
	Template.Tier = 0;

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('UnderbarrelWeapons');

	return Template;
}