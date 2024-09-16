class X2Item_PurgePriestCorpse extends X2Item;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PurgePriests'))
    {
	Resources.AddItem(CreateCorpseAdventPurgePriest());
	Resources.AddItem(CreateCorpseAdventExaltedPurgeBishop());
	}

	return Resources;
}

static function X2DataTemplate CreateCorpseAdventPurgePriest()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdventPurgePriest');

	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Corpse_Advent_Priest";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 8;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}

static function X2DataTemplate CreateCorpseAdventExaltedPurgeBishop()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdventExaltedPurgeBishop');

	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Corpse_Advent_Priest";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = 8;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}