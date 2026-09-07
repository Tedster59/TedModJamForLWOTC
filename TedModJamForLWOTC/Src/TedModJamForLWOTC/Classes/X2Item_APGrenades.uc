class X2Item_APGrenades extends X2Item config(APGrenades);

var config bool UseNeedleGrenadesIcon;

var config bool APGRENADE_DESTROYSLOOT;
var config name APGRENADE_DAMAGETYPE;

var config WeaponDamageValue APGRENADE_MK3_BASEDAMAGE;

var config int APGRENADE_MK3_ISOUNDRANGE;
var config int APGRENADE_MK3_IENVIRONMENTDAMAGE;
var config int APGRENADE_MK3_TRADINGPOSTVALUE;
var config int APGRENADE_MK3_ICLIPSIZE;
var config int APGRENADE_MK3_RANGE;
var config int APGRENADE_MK3_RADIUS;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Grenades;

	Grenades.AddItem(CreateAPGrenade_Mk3());

	return Grenades;
}


static function X2DataTemplate CreateAPGrenade_MK3()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_Knockback KnockbackEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'RM_APGrenade_MK3');

	Template.strImage = "img:///UILibrary_TJ_Grenades.Inv_Xcom_AlloyGrenadeMK2";
	Template.EquipSound = "StrategyUI_Grenade_Equip";

	if (default.UseNeedleGrenadesIcon)
	{
		Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_LW_Overhaul.LW_AbilityNeedleGrenades");
		Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_LW_Overhaul.LW_AbilityNeedleGrenades");
	}

	Template.iRange = default.APGRENADE_MK3_RANGE;
	Template.iRadius = default.APGRENADE_MK3_RADIUS;

	Template.BaseDamage = default.APGRENADE_MK3_BASEDAMAGE;
	Template.iSoundRange = default.APGRENADE_MK3_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.APGRENADE_MK3_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.APGRENADE_MK3_TRADINGPOSTVALUE;
	Template.iClipSize = default.APGRENADE_MK3_ICLIPSIZE;
	Template.DamageTypeTemplateName = default.APGRENADE_DAMAGETYPE;
	Template.Tier = 2;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');
	
	Template.GameArchetype = "WP_Grenade_Alien.WP_Grenade_Alien_Soldier";

	Template.iPhysicsImpulse = 0;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = default.APGRENADE_DESTROYSLOOT;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);

	Template.OnThrowBarkSoundCue = 'ThrowGrenade';

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.ThrownGrenadeEffects.AddItem(KnockbackEffect);
	Template.LaunchedGrenadeEffects.AddItem(KnockbackEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.APGRENADE_MK3_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.APGRENADE_MK3_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.APGRENADE_MK3_BASEDAMAGE.Shred);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PierceLabel, eStat_ArmorPiercing, default.APGRENADE_MK3_BASEDAMAGE.Pierce);

	return Template;
}
