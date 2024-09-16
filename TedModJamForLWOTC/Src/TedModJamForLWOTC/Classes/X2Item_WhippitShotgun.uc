class X2Item_WhippitShotgun extends X2Item config(WhippitShotgun);

var config WeaponDamageValue WhippitShotgun_BASEDAMAGE;

var config int WhippitShotgun_AIM;
var config int WhippitShotgun_CRITCHANCE;
var config int WhippitShotgun_ICLIPSIZE;
var config int WhippitShotgun_ISOUNDRANGE;
var config int WhippitShotgun_IENVIRONMENTDAMAGE;
var config int WhippitShotgun_UPGRADESLOTS;
var config array<int> WhippitShotgun_RANGE;
var config int WhippitShotgun_MAXRANGE;

var config int WhippitShotgun_PierceUI;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTC_SpartsSawedSA'))
    {
	Templates.AddItem(CreateTemplate_WhippitShotgun());
	}

	return Templates;
}

static function X2DataTemplate CreateTemplate_WhippitShotgun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'WhippitShotgun');
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///SawedOffSA.Image.Shotgun";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = 0;

	Template.RangeAccuracy = default.WhippitShotgun_RANGE;
	Template.iRange = default.WhippitShotgun_MAXRANGE;
	Template.BaseDamage = default.WhippitShotgun_BASEDAMAGE;
	Template.Aim = default.WhippitShotgun_AIM;
	Template.CritChance = default.WhippitShotgun_CRITCHANCE;
	Template.iClipSize = 1; // This is so it can't be used for Faceoff or Fan Fire. It still has infinite ammo.
	Template.iSoundRange = default.WhippitShotgun_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.WhippitShotgun_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 0;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "SawedOffSA.GameData.WP_SawedOff_CV";

	Template.iPhysicsImpulse = 5;
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PierceLabel, eStat_ArmorPiercing, -default.WhippitShotgun_PierceUI, true);
	
	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}