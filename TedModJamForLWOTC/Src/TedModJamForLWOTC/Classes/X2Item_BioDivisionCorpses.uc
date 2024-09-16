class X2Item_BioDivisionCorpses extends X2Item config(BDData);

var config int BIOTROOPER_CORPSE_TRADING_POST_VALUE;
var config int BIOOFFICER_CORPSE_TRADING_POST_VALUE;
var config int BIOBARRIERTROOPER_CORPSE_TRADING_POST_VALUE;
var config int BIOMEC_CORPSE_TRADING_POST_VALUE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Resources;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Resources.AddItem(CreateCorpseAdvBioTrooper());
	Resources.AddItem(CreateCorpseAdvBioOfficer());
	Resources.AddItem(CreateCorpseAdvBioBarrierTrooper());
	Resources.AddItem(CreateCorpseBioMec());
	}

	return Resources;
}

static function X2DataTemplate CreateCorpseAdvBioTrooper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdvBioTrooper');

	Template.strImage = "img:///UILIB_BioDivision.Corpses.Corpse_BioTrooper";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.BIOTROOPER_CORPSE_TRADING_POST_VALUE;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}

static function X2DataTemplate CreateCorpseAdvBioOfficer()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdvBioOfficer');

	Template.strImage = "img:///UILIB_BioDivision.Corpses.Corpse_BioCaptain";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.BIOOFFICER_CORPSE_TRADING_POST_VALUE;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}

static function X2DataTemplate CreateCorpseAdvBioBarrierTrooper()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseAdvBioBarrierTrooper');

	Template.strImage = "img:///UILIB_BioDivision.Corpses.Corpse_BioAssault";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.BIOBARRIERTROOPER_CORPSE_TRADING_POST_VALUE;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}

static function X2DataTemplate CreateCorpseBioMec()
{
	local X2ItemTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ItemTemplate', Template, 'CorpseBioMec');

	Template.strImage = "img:///UILIB_BioDivision.Corpses.Corpse_BioMech";
	Template.ItemCat = 'resource';
	Template.TradingPostValue = default.BIOMEC_CORPSE_TRADING_POST_VALUE;
	Template.MaxQuantity = 1;
	Template.LeavesExplosiveRemains = true;

	return Template;
}