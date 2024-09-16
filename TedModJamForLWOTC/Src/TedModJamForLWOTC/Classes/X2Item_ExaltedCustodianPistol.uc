class X2Item_ExaltedCustodianPistol extends X2Item config(Custodian_Xcom_Items);

var config WeaponDamageValue OverseerPistol_BaseDamage;
var config array<int> OverseerPistol_RANGE;
var config int OverseerPistol_Aim;
var config int OverseerPistol_CritChance;
var config int OverseerPistol_iSoundRange;
var config int OverseerPistol_iEnvironmentDamage;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('CustodianPack'))
    {
	Templates.AddItem(OverseerPistol());
	}

	return Templates;
}

static function X2DataTemplate OverseerPistol()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'OverseerPistol');
	Template.WeaponPanelImage = "_Pistol";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///WoTC_CustodianPack_UI.AdventCustodianAutopistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 0;

	Template.RangeAccuracy = default.OverseerPistol_RANGE;

	Template.BaseDamage = default.OverseerPistol_BaseDamage;
	Template.Aim = default.OverseerPistol_Aim;
	Template.CritChance = default.OverseerPistol_CritChance;
	Template.iClipSize = 6;
	Template.iSoundRange = default.OverseerPistol_iSoundRange;
	Template.iEnvironmentDamage = default.OverseerPistol_iEnvironmentDamage;

	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('ShadowOps_CoupDeGrace');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	Template.GameArchetype = "WP_Pistol_MG.WP_Pistol_MG";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}