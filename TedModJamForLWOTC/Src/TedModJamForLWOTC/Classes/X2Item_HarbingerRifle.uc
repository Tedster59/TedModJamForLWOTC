class X2Item_HarbingerRifle extends X2Item Config(HarbingerRifle);

var config WeaponDamageValue HARBINGERRIFLE_BASEDAMAGE;
var config int HARBINGERRIFLE_AIM;
var config int HARBINGERRIFLE_CRITCHANCE;
var config int HARBINGERRIFLE_ICLIPSIZE;
var config int HARBINGERRIFLE_ISOUNDRANGE;
var config int HARBINGERRIFLE_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AdventSniper_WoTC'))
    {
	Templates.AddItem(CreateTemplate_HarbingerRifle());
	}

	return Templates;
}

static function X2DataTemplate CreateTemplate_HarbingerRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'HarbingerRifle');
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_CONVENTIONAL_RANGE;
	Template.BaseDamage = default.HARBINGERRIFLE_BASEDAMAGE;
	Template.Aim = default.HARBINGERRIFLE_AIM;
	Template.CritChance = default.HARBINGERRIFLE_CRITCHANCE;
	Template.iClipSize = default.HARBINGERRIFLE_ICLIPSIZE;
	Template.iSoundRange = default.HARBINGERRIFLE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.HARBINGERRIFLE_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 0;
	Template.iTypicalActionCost = 1;

	Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	Template.GameArchetype = "Advent_Sniper_Rifle_WPN.WP_AdventSniperRifle_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}