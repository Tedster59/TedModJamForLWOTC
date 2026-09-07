class X2Item_AssaultGrenades extends X2Item_DefaultGrenades config(AssaultTrooper);

var config WeaponDamageValue MAG_BOMB_BASEDAMAGE;

var config int MAG_BOMB_ISOUNDRANGE;
var config int MAG_BOMB_IENVIRONMENTDAMAGE;
var config int MAG_BOMB_TRADINGPOSTVALUE;
var config int MAG_BOMB_IPOINTS;
var config int MAG_BOMB_ICLIPSIZE;
var config int MAG_BOMB_RANGE;
var config int MAG_BOMB_RADIUS;
var config int MAG_BOMB_KNOCKBACK_DISTANCE;

var config int MAG_BOMB_SUPPLY_COST;
var config int MAG_BOMB_ALLOY_COST;
var config int MAG_BOMB_ELERIUM_COST;
var config int MAG_BOMB_CORE_COST;

var config WeaponDamageValue LASER_BOMB_BASEDAMAGE;

var config int LASER_BOMB_ISOUNDRANGE;
var config int LASER_BOMB_IENVIRONMENTDAMAGE;
var config int LASER_BOMB_TRADINGPOSTVALUE;
var config int LASER_BOMB_IPOINTS;
var config int LASER_BOMB_ICLIPSIZE;
var config int LASER_BOMB_RANGE;
var config int LASER_BOMB_RADIUS;

var config int LASER_BOMB_SUPPLY_COST;
var config int LASER_BOMB_ALLOY_COST;
var config int LASER_BOMB_ELERIUM_COST;
var config int LASER_BOMB_CORE_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Grenades;

	Grenades.AddItem(CreateMagBomb());
	Grenades.AddItem(CreateLaserBomb());

	return Grenades;
}

static function X2DataTemplate CreateMagBomb()
{
	local X2GrenadeTemplate                  Template;
	local X2Effect_ApplyWeaponDamage         WeaponDamageEffect;
	local X2Effect_Knockback                 KnockbackEffect;
	//local ArtifactCost                       Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'MagBomb');

	Template.strImage = "img:///UILibrary_TJ_Grenades.Inv_Xcom_MagGrenadeMK2"; //Texture2D'WoTC_Advent_Assault_Trooper_UI.Inv_Xcom_MagGrenade'
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///WoTC_Advent_Assault_Trooper_UI.UIPerk_grenade_Mag");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///WoTC_Advent_Assault_Trooper_UI.UIPerk_grenade_Mag"); //Texture2D'WoTC_Advent_Assault_Trooper_UI.UIPerk_grenade_Mag'

	Template.iRange = default.MAG_BOMB_RANGE;
	Template.iRadius = default.MAG_BOMB_RADIUS;
	//Template.fCoverage = 50;

	Template.BaseDamage = default.MAG_BOMB_BASEDAMAGE;
	Template.iSoundRange = default.MAG_BOMB_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.MAG_BOMB_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.MAG_BOMB_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.MAG_BOMB_IPOINTS;
	Template.iClipSize = default.MAG_BOMB_ICLIPSIZE;
	Template.Tier = 1;

	// Requirements
	//Template.Requirements.RequiredTechs.AddItem('AutopsyT1AssaultTrooper');

	//Cost
	//Resources.ItemTemplateName = 'Supplies';
	//Resources.Quantity = default.MAG_GRENADE_SUPPLY_COST;
	//Template.Cost.ResourceCosts.AddItem(Resources);

	//Resources.ItemTemplateName = 'AlienAlloy';
	//Resources.Quantity = default.MAG_GRENADE_ALLOY_COST;
	//Template.Cost.ResourceCosts.AddItem(Resources);

	//Resources.ItemTemplateName = 'EleriumDust';
 	//Resources.Quantity = default.MAG_GRENADE_ELERIUM_COST;
 	//Template.Cost.ResourceCosts.AddItem(Resources);

	//Resources.ItemTemplateName = 'EleriumCore';
	//Resources.Quantity = default.MAG_GRENADE_CORE_COST;
	//Template.Cost.ResourceCosts.AddItem(Resources);

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = default.MAG_BOMB_KNOCKBACK_DISTANCE;
	KnockbackEffect.bKnockbackDestroysNonFragile = true;
	KnockbackEffect.OnlyOnDeath = false;

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;

	Template.ThrownGrenadeEffects.AddItem(KnockbackEffect);
	Template.LaunchedGrenadeEffects.AddItem(KnockbackEffect);

	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WoTC_Advent_Assault_Trooper_Grenades.Archetypes.WP_Grenade_Mag_Xcom"; //XComWeapon'WoTC_Advent_Assault_Trooper_Grenades.Archetypes.WP_Grenade_Mag_Xcom'

	Template.iPhysicsImpulse = 10;
	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 10.0f;

	Template.CanBeBuilt = true;
	
	//Template.RewardDecks.AddItem('ExperimentalGrenadeRewards');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.MAG_BOMB_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.MAG_BOMB_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.MAG_BOMB_BASEDAMAGE.Shred);

	return Template;
}

static function X2DataTemplate CreateLaserBomb()
{
	local X2GrenadeTemplate                  Template;
	local X2Effect_ApplyWeaponDamage         WeaponDamageEffect;
	//local ArtifactCost                       Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'LaserBomb');

	Template.strImage = "img:///UILibrary_TJ_Grenades.Inv_Xcom_LaserGrenadeMK2"; //Texture2D'WoTC_Advent_Assault_Trooper_UI.Inv_Xcom_LaserGrenade'
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///WoTC_Advent_Assault_Trooper_UI.UIPerk_grenade_Laser");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///WoTC_Advent_Assault_Trooper_UI.UIPerk_grenade_Laser"); //Texture2D'WoTC_Advent_Assault_Trooper_UI.UIPerk_grenade_Laser'

	Template.iRange = default.LASER_BOMB_RANGE;
	Template.iRadius = default.LASER_BOMB_RADIUS;
	//Template.fCoverage = 50;

	Template.BaseDamage = default.LASER_BOMB_BASEDAMAGE;
	Template.iSoundRange = default.LASER_BOMB_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LASER_BOMB_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.LASER_BOMB_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.LASER_BOMB_IPOINTS;
	Template.iClipSize = default.LASER_BOMB_ICLIPSIZE;
	Template.Tier = 2;

	// Requirements
	//Template.Requirements.RequiredTechs.AddItem('AutopsyT2AssaultTrooper');

	//Cost
	//Resources.ItemTemplateName = 'Supplies';
	//Resources.Quantity = default.LASER_GRENADE_SUPPLY_COST;
	//Template.Cost.ResourceCosts.AddItem(Resources);

	//Resources.ItemTemplateName = 'AlienAlloy';
	//Resources.Quantity = default.LASER_GRENADE_ALLOY_COST;
	//Template.Cost.ResourceCosts.AddItem(Resources);

	//Resources.ItemTemplateName = 'EleriumDust';
 	//Resources.Quantity = default.LASER_GRENADE_ELERIUM_COST;
 	//Template.Cost.ResourceCosts.AddItem(Resources);

	//Resources.ItemTemplateName = 'EleriumCore';
	//Resources.Quantity = default.LASER_GRENADE_CORE_COST;
	//Template.Cost.ResourceCosts.AddItem(Resources);

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WoTC_Advent_Assault_Trooper_Grenades.Archetypes.WP_Grenade_Laser_Xcom"; //XComWeapon'WoTC_Advent_Assault_Trooper_Grenades.Archetypes.WP_Grenade_Laser_Xcom'

	Template.iPhysicsImpulse = 10;

	Template.CanBeBuilt = true;
	
	//Template.RewardDecks.AddItem('ExperimentalBOMBRewards');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.LASER_BOMB_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.LASER_BOMB_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.LASER_BOMB_BASEDAMAGE.Shred);

	return Template;
}