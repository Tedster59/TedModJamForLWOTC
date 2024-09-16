class X2Item_CryoPriestCorpse extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CryoPriest') || class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('ABetterADVENTDLC'))
    {
	Resources.AddItem(CreateCorpseAdventCryoPriest());
	Resources.AddItem(CreateCorpseAdventCryoRocketeer());
	}

	return Resources;
}

static function X2DataTemplate CreateCorpseAdventCryoPriest()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdventCryoPriest');

	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Corpse_Advent_Priest";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 8;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}

static function X2DataTemplate CreateCorpseAdventCryoRocketeer()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdventCryoRocketeer');

	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Corpse_Advent_Priest";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 8;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}