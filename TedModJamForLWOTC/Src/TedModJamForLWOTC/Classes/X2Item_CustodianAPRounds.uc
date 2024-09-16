class X2Item_CustodianAPRounds extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CustodianPack'))
    {
	Items.AddItem(CustodianAPRounds());
	}

	return Items;
}

static function X2AmmoTemplate CustodianAPRounds()
{
	local X2AmmoTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, 'CustodianAPRounds');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Ap_Rounds";
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('CustodianAPRoundsAbility');
	Template.Tier = 70;
	Template.EquipSound = "StrategyUI_Ammo_Equip";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PierceLabel, eStat_ArmorPiercing, class'X2Ability_CustodianAPRounds'.default.CUSTODIAN_APROUNDS_PIERCE);

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 65;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;
		
	//FX Reference
	Template.GameArchetype = "Ammo_AP.PJ_AP";
	
	return Template;
}