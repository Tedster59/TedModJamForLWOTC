class X2Item_ExaltedCustodianGrandmasterRifle extends X2Item Config(Custodian_Xcom_Items);

var config WeaponDamageValue PERMAFROSTRIFLE_BASEDAMAGE;
var config int PERMAFROSTRIFLE_AIM;
var config int PERMAFROSTRIFLE_CRITCHANCE;
var config int PERMAFROSTRIFLE_ICLIPSIZE;
var config int PERMAFROSTRIFLE_ISOUNDRANGE;
var config int PERMAFROSTRIFLE_IENVIRONMENTDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CustodianPack'))
    {
	Templates.AddItem(CreateTemplate_PermafrostRifle());
	}

	return Templates;
}

static function X2DataTemplate CreateTemplate_PermafrostRifle()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'PermafrostRifle');
	Template.WeaponPanelImage = "_BeamRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 0;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = default.PERMAFROSTRIFLE_BASEDAMAGE;
	Template.Aim = default.PERMAFROSTRIFLE_AIM;
	Template.CritChance = default.PERMAFROSTRIFLE_CRITCHANCE;
	Template.iClipSize = default.PERMAFROSTRIFLE_ICLIPSIZE;
	Template.iSoundRange = default.PERMAFROSTRIFLE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PERMAFROSTRIFLE_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 0;

	Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('MZShiver');
	Template.Abilities.AddItem('MZRunningOnEmpty');
	
	Template.GameArchetype = "WoTC_Exalted_Custodians_Rifle.Archetypes.WP_Exalted_Rifle";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}