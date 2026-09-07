class X2Item_AdvWarlockWeapons extends X2Item config(AdvWarlock);

var config WeaponDamageValue ADVWARLOCK_XCOM_VORTEXBOMB_BASEDAMAGE;

var config int ADVWARLOCK_VORTEXBOMB_RANGE;
var config int ADVWARLOCK_VORTEXBOMB_RADIUS;
var config int ADVWARLOCK_VORTEXBOMB_ISOUNDRANGE;
var config int ADVWARLOCK_VORTEXBOMB_IENVIRONMENTDAMAGE;
var config int ADVWARLOCK_VORTEXBOMB_TRADINGPOSTVALUE;
var config int ADVWARLOCK_VORTEXBOMB_STUNCHANCE;
var config int ADVWARLOCK_VORTEXBOMB_STUNDURATION;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(CreateVortexBomb());

	return Templates;
}

static function X2DataTemplate CreateVortexBomb()
{
	local X2GrenadeTemplate				Template;
	local X2Effect_ApplyWeaponDamage	WeaponDamageEffect;
	//local ArtifactCost					Artifacts, Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'Weapon_AshXcomVortexBomb');

	Template.strImage = "img:///UILibrary_TJ_Grenades.Inv_Xcom_VortexGrenadeMK2";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.GameArchetype = "WP_Vortex_Grenade.WP_Vortex_Grenade";

	//Icons
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_aliengrenade");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_aliengrenade");

	Template.BaseDamage = default.ADVWARLOCK_XCOM_VORTEXBOMB_BASEDAMAGE;
	Template.iRange = default.ADVWARLOCK_VORTEXBOMB_RANGE;
	Template.iRadius = default.ADVWARLOCK_VORTEXBOMB_RADIUS;
	Template.iSoundRange = default.ADVWARLOCK_VORTEXBOMB_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ADVWARLOCK_VORTEXBOMB_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.ADVWARLOCK_VORTEXBOMB_TRADINGPOSTVALUE;
	Template.iClipSize = 1;
	Template.Tier = 4;
	Template.DamageTypeTemplateName = 'Psi';
	Template.fKnockbackDamageAmount = 2;
	Template.iPhysicsImpulse = 20;
	Template.PointsToComplete = 0;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');
	
	//Weapon Damage	Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);

	//Stun Effect
	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2,default.ADVWARLOCK_VORTEXBOMB_STUNCHANCE,true));

	//Add all Thrown Effects to Launched Effects
	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRangeLabel, , default.ADVWARLOCK_VORTEXBOMB_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.GrenadeRadiusLabel, , default.ADVWARLOCK_VORTEXBOMB_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , default.ADVWARLOCK_VORTEXBOMB_STUNCHANCE, , , "%");
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.ADVWARLOCK_XCOM_VORTEXBOMB_BASEDAMAGE.Shred);

	return Template;
}