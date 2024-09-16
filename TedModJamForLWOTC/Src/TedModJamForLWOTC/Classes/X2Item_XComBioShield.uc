class X2Item_XComBioShield extends X2Item config(BDData);

var config int GENERIC_MELEE_ACCURACY;
var config WeaponDamageValue XCOM_BIOSHIELD_BASEDAMAGE;
var config(Shields) int SHIELD_MOBILITY_PENALTY;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	Weapons.AddItem(XComBioShield());
	}

	return Weapons;
}

static function X2DataTemplate XComBioShield()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'XComBioShield');
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shield';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///WoTC_Shield_UI.Inv_Plated_Shield";
	Template.EquipSound = "StrategyUI_Heavy_Weapon_Equip";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_HeavyWeapon;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_BioShield.Archetype.WP_BioShield";
	
	Template.Aim = default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.BaseDamage = default.XCOM_BIOSHIELD_BASEDAMAGE;
	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 0;
	Template.iIdealRange = 0;

	Template.Abilities.AddItem('ShieldAnimSet');
	Template.Abilities.AddItem('BioShieldBash');
	Template.Abilities.AddItem('AdvBioShieldDeflect');
	// Template.Abilities.AddItem('BioShieldMobilityPenalty');
	Template.Abilities.AddItem('BallisticShield_MG');
	Template.Abilities.AddItem('ShieldWall');
	Template.Abilities.AddItem('BallisticShield_GenerateCover');
	Template.Abilities.AddItem('Taunt');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, default.SHIELD_MOBILITY_PENALTY);

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';
	
	return Template;
}