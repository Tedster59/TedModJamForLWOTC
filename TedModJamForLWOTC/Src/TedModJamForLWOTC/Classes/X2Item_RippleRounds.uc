class X2Item_RippleRounds extends X2Item config (MutonHarrier);

var config int RIPPLEROUNDS_DMGMOD;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('MutonHarriers'))
    {
	Items.AddItem(CreateAmmoTemplate_RippleRounds('RippleRounds'));
	}
	return Items;
}

static function X2DataTemplate CreateAmmoTemplate_RippleRounds(name TemplateName)
{
	local X2AmmoTemplate Template;
	local WeaponDamageValue DamageValue;
	local ArtifactCost Resources;
	local ArtifactCost Artifacts;

	`CREATE_X2TEMPLATE(class'X2AmmoTemplate', Template, TemplateName);
	Template.strImage = "img:///UILibrary_MZAmmoMod.X2InventoryIcons.Inv_AntiViolet_Rounds";
	Template.Abilities.AddItem('RippleRounds');
	Template.EquipSound = "StrategyUI_Ammo_Equip";
	Template.ModClipSize = 0;
	
	Template.TradingPostValue = 5;
	
	Template.CanBeBuilt = true;
	Template.PointsToComplete = 0;
	Template.Tier = 1;

	DamageValue.Damage = default.RIPPLEROUNDS_DMGMOD;
    DamageValue.DamageType = 'Psi';
    Template.AddAmmoDamageModifier(none, DamageValue);
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DamageBonusLabel, , default.RIPPLEROUNDS_DMGMOD);

	Template.TargetEffects.AddItem(class'X2StatusEffects_RipplingRifle'.static.CreatePsiRippleStatusEffect(2, 0));
	
	//FX Reference
	Template.GameArchetype = "WP_Void_Rift.PJ_Void_Rift";

	//Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyGrenadeRemains');

	//Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 25;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Artifacts.ItemTemplateName = 'CorpseGrenadeRemains';
	Artifacts.Quantity = 1;
	Template.Cost.ArtifactCosts.AddItem(Artifacts);

	return Template;
}