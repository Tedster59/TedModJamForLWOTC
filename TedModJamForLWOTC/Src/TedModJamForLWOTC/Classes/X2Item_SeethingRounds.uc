class X2Item_SeethingRounds extends X2Item config (AshFlameViper);

var config int ASHFLAMEVIPER_SEETHINGROUNDS_DMGMOD;
var config int ASHFLAMEVIPER_SEETHINGROUNDS_FIREDMGMOD;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WotC_AshlynneFlameViper'))
    {
	Items.AddItem(CreateAmmoTemplate_SeethingRounds('SeethingRounds'));
	}
	Items.AddItem(CreateAmmoTemplate_HollowPointRounds('HollowPointRounds'));
	return Items;
}

static function X2DataTemplate CreateAmmoTemplate_SeethingRounds(name TemplateName)
{
	local X2AmmoTemplate Template;
	local WeaponDamageValue DamageValue;
	local WeaponDamageValue FireDamageValue;
	local ArtifactCost Resources;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, TemplateName);
	Template.strImage = "img:///AshlynneMod_FlameViper_StrategyImages.X2InventoryIcons.Inv_Inferno_Rounds";
	Template.EquipSound = "StrategyUI_Ammo_Equip";
	Template.ModClipSize = 0;
	
	Template.TradingPostValue = 5;
	
	Template.CanBeBuilt = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;

	Template.Abilities.AddItem('Ability_AshInfernoRounds');
	Template.Abilities.AddItem('SeethingRoundsPierce');

	DamageValue.Damage = default.ASHFLAMEVIPER_SEETHINGROUNDS_DMGMOD;
    DamageValue.DamageType = 'Projectile_BeamXCom';
    Template.AddAmmoDamageModifier(none, DamageValue);

	FireDamageValue.Damage = default.ASHFLAMEVIPER_SEETHINGROUNDS_FIREDMGMOD;
	FireDamageValue.DamageType = 'Fire';
	Template.AddAmmoDamageModifier(none, FireDamageValue);
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DamageBonusLabel, , default.ASHFLAMEVIPER_SEETHINGROUNDS_DMGMOD);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PierceLabel, eStat_ArmorPiercing, 1);
	
	//FX Reference
	Template.GameArchetype = "Ammo_Incendiary.PJ_Incendiary";

	//Requirements
	Template.Requirements.RequiredTechs.AddItem('Autopsy_AshFlameViper');

	//Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 25;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'Corpse_AshFlameViper';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}

static function X2DataTemplate CreateAmmoTemplate_HollowPointRounds(name TemplateName)
{
	local X2AmmoTemplate Template;
	local WeaponDamageValue DamageValue;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, TemplateName);
	Template.strImage = "img:///NelVlesis_Overrides.Items.highqualityround";
	Template.EquipSound = "StrategyUI_Ammo_Equip";
	Template.ModClipSize = 0;

	Template.Abilities.AddItem('HollowPointRoundsPierce');

	DamageValue.Damage = 1;
    DamageValue.DamageType = 'Projectile_Conventional';
    Template.AddAmmoDamageModifier(none, DamageValue);
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DamageBonusLabel, , 1);
	
	//FX Reference
	Template.GameArchetype = "Ammo_AP.PJ_AP";

	return Template;
}