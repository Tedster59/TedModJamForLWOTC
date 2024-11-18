class X2Item_MagTalon extends X2Item config(MagTalon);

var config WeaponDamageValue MAGTALON_BaseDamage;
var config array<int> MAGTALON_RANGE;
var config int MAGTALON_Aim;
var config int MAGTALON_CritChance;
var config int MAGTALON_iSoundRange;
var config int MAGTALON_iEnvironmentDamage;

var config WeaponDamageValue BEAMTALON_BaseDamage;
var config int BEAMTALON_Aim;
var config int BEAMTALON_CritChance;
var config int BEAMTALON_iSoundRange;
var config int BEAMTALON_iEnvironmentDamage;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('AdventDuelist_WoTC'))
    {
		Templates.AddItem(CreateTemplate_MagTalon());
		Templates.AddItem(CreateTemplate_BeamTalon());
	}

	return Templates;
}

static function X2DataTemplate CreateTemplate_MagTalon()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'MagTalon');
	Template.WeaponPanelImage = "_Pistol";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///AdventDuelist_Weapon.UI_AdventDuelist_Pistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 0;

	Template.RangeAccuracy = default.MAGTALON_RANGE;

	Template.BaseDamage = default.MAGTALON_BaseDamage;
	Template.Aim = default.MAGTALON_Aim;
	Template.CritChance = default.MAGTALON_CritChance;
	Template.iClipSize = 6;
	Template.iSoundRange = default.MAGTALON_iSoundRange;
	Template.iEnvironmentDamage = default.MAGTALON_iEnvironmentDamage;

	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('AnkleShot');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	Template.GameArchetype = "AdventDuelist_Weapon.Materials.WP_AdventDuelist_Pistol_Xcom";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_BeamTalon()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'BeamTalon');
	Template.WeaponPanelImage = "_Pistol";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///AdventDuelist_Weapon.UI_AdventDuelist_Pistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = 0;

	Template.RangeAccuracy = default.MAGTALON_RANGE;

	Template.BaseDamage = default.BEAMTALON_BaseDamage;
	Template.Aim = default.BEAMTALON_Aim;
	Template.CritChance = default.BEAMTALON_CritChance;
	Template.iClipSize = 6;
	Template.iSoundRange = default.BEAMTALON_iSoundRange;
	Template.iEnvironmentDamage = default.BEAMTALON_iEnvironmentDamage;

	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('AnkleShot');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	Template.GameArchetype = "AdventDuelist_Weapon.Materials.WP_AdventDuelist_Pistol_Xcom";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}