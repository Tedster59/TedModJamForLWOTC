class X2Item_XComPurgeGun extends X2Item Config(PurgePriestXComItems);

var config WeaponDamageValue XCOMPURGEGUN_BASEDAMAGE;
var config array<int> XCOMPURGEGUN_RANGEACCURACY;
var config int XCOMPURGEGUN_AIM;
var config int XCOMPURGEGUN_CRITCHANCE;
var config int XCOMPURGEGUN_ICLIPSIZE;
var config int XCOMPURGEGUN_ISOUNDRANGE;
var config int XCOMPURGEGUN_IENVIRONMENTDAMAGE;

var config WeaponDamageValue XCOMEXALTEDPURGEGUN_BASEDAMAGE;
var config array<int> XCOMEXALTEDPURGEGUN_RANGEACCURACY;
var config int XCOMEXALTEDPURGEGUN_AIM;
var config int XCOMEXALTEDPURGEGUN_CRITCHANCE;
var config int XCOMEXALTEDPURGEGUN_ICLIPSIZE;
var config int XCOMEXALTEDPURGEGUN_ISOUNDRANGE;
var config int XCOMEXALTEDPURGEGUN_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PurgePriests'))
    {
	Templates.AddItem(CreateTemplate_XComPurgeGun());
	Templates.AddItem(CreateTemplate_XComExaltedPurgeGun());
	}

	return Templates;
}

static function X2DataTemplate CreateTemplate_XComPurgeGun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'XComPurgeGun');
	Template.WeaponPanelImage = "_BeamRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///WoTC_PurgePriest_UI.MagneticPurgeGun";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 0;

	Template.RangeAccuracy = default.XCOMPURGEGUN_RANGEACCURACY;
	Template.BaseDamage = default.XCOMPURGEGUN_BASEDAMAGE;
	Template.Aim = default.XCOMPURGEGUN_AIM;
	Template.CritChance = default.XCOMPURGEGUN_CRITCHANCE;
	Template.iClipSize = default.XCOMPURGEGUN_ICLIPSIZE;
	Template.iSoundRange = default.XCOMPURGEGUN_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.XCOMPURGEGUN_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 0;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('F_ThousandsToGo');
	
	Template.GameArchetype = "WP_SniperRifle_MG.WP_SniperRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_XComExaltedPurgeGun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'XComExaltedPurgeGun');
	Template.WeaponPanelImage = "_BeamRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///WoTC_PurgePriest_UI.AdventPlasmaPurgeGun";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 0;

	Template.RangeAccuracy = default.XCOMEXALTEDPURGEGUN_RANGEACCURACY;
	Template.BaseDamage = default.XCOMEXALTEDPURGEGUN_BASEDAMAGE;
	Template.Aim = default.XCOMEXALTEDPURGEGUN_AIM;
	Template.CritChance = default.XCOMEXALTEDPURGEGUN_CRITCHANCE;
	Template.iClipSize = default.XCOMEXALTEDPURGEGUN_ICLIPSIZE;
	Template.iSoundRange = default.XCOMEXALTEDPURGEGUN_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.XCOMEXALTEDPURGEGUN_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 0;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('F_ThousandsToGo');
	
	Template.GameArchetype = "WP_SniperRifle_MG.WP_SniperRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}