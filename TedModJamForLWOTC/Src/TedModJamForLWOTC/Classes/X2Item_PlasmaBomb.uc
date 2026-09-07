class X2Item_PlasmaBomb extends X2Item config(GameData_WeaponData);

var config WeaponDamageValue ALIENBOMB_BASEDAMAGE;

var config int ALIENBOMB_ISOUNDRANGE;
var config int ALIENBOMB_IENVIRONMENTDAMAGE;
var config int ALIENBOMB_ISUPPLIES;
var config int ALIENBOMB_TRADINGPOSTVALUE;
var config int ALIENBOMB_IPOINTS;
var config int ALIENBOMB_ICLIPSIZE;
var config int ALIENBOMB_RANGE;
var config int ALIENBOMB_RADIUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Grenades;

	Grenades.AddItem(CreateAlienBomb());

	return Grenades;
}

static function X2DataTemplate CreateAlienBomb()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_Knockback KnockbackEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'AlienBomb');

	Template.strImage = "img:///UILibrary_TJ_Grenades.Inv_Xcom_PlasmaGrenadeMK2";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.iRange = default.ALIENBOMB_RANGE;
	Template.iRadius = default.ALIENBOMB_RADIUS;

	Template.BaseDamage = default.ALIENBOMB_BASEDAMAGE;
	Template.iSoundRange = default.ALIENBOMB_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ALIENBOMB_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.ALIENBOMB_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.ALIENBOMB_IPOINTS;
	Template.iClipSize = default.ALIENBOMB_ICLIPSIZE;
	Template.DamageTypeTemplateName = 'Explosion';
	Template.Tier = 2;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WP_Grenade_Alien.WP_Grenade_Alien_Soldier";

	Template.iPhysicsImpulse = 10;

	//Template.CreatorTemplateName = 'PlasmaGrenade'; // The schematic which creates this item
	//Template.BaseItem = 'FragGrenade'; // Which item this will be upgraded from

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.ThrownGrenadeEffects.AddItem(KnockbackEffect);
	Template.LaunchedGrenadeEffects.AddItem(KnockbackEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.ALIENBOMB_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.ALIENBOMB_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.ALIENBOMB_BASEDAMAGE.Shred);
	
	return Template;
}