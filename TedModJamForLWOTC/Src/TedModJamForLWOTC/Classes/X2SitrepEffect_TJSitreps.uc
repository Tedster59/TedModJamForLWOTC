// This is an Unreal Script

class X2SitrepEffect_TJSitreps extends X2SitRep_DefaultSitRepEffects;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateCustodianEscortLoot());


	return Templates;
}

static function X2SitRepEffectTemplate CreateCustodianEscortLoot()
{
	local X2SitRepEffect_ModifyMissionMaps Template;

	`CREATE_X2TEMPLATE(class'X2SitRepEffect_ModifyMissionMaps', Template, 'CustodianEscortLoot');

	Template.AdditionalMissionMaps.AddItem("UMS_CustodianEscortLoot");

	return Template;
}