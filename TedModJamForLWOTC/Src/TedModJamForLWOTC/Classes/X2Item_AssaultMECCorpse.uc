class X2Item_AssaultMECCorpse extends X2Item config(GatlingMEC);

var config int GATLINGMEC_CORPSE_TRADING_POST_VALUE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('GatlingMec'))
	{
	Resources.AddItem(CreateCorpseGatlingMec());
	}

	return Resources;
}

static function X2DataTemplate CreateCorpseGatlingMec()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseGatlingMec');

	Template.strImage = "img:///UILibrary_StrategyImages.CorpseIcons.Corpse_MEC";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.GATLINGMEC_CORPSE_TRADING_POST_VALUE;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}