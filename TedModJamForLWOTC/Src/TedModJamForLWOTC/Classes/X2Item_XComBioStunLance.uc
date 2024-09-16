class X2Item_XComBioStunLance extends X2Item config (BDData);

var config int GENERIC_MELEE_ACCURACY;
var config WeaponDamageValue XCOM_BIOSTUNLANCE_BASEDAMAGE;
var config name XCOM_BIOSTUNLANCE_CATEGORY;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	ModWeapons.AddItem(CreateTemplate_XComBioStunLance());
	}

	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_XComBioStunLance()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'XComBioStunLance');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = default.XCOM_BIOSTUNLANCE_CATEGORY;
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILIB_BioDivision.UI.UI_AdvStunBaton";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Adv_StunLancer.WP_StunLance";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.Aim = default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.BaseDamage = default.XCOM_BIOSTUNLANCE_BASEDAMAGE;
	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 0;
	Template.iIdealRange = 0;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('AssaultStun');

	return Template;
}