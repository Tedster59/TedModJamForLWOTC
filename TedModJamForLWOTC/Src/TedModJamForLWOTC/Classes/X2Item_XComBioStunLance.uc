class X2Item_XComBioStunLance extends X2Item config (BDData);

var localized string strDisorientChanceLabel;

var config int GENERIC_MELEE_ACCURACY;
var config WeaponDamageValue XCOM_BIOSTUNLANCE_BASEDAMAGE;
var config int XCOM_BIOSTUNLANCE_AIM;
var config int XCOM_BIOSTUNLANCE_CRITCHANCE;
var config int XCOM_BIOSTUNLANCE_ICLIPSIZE;
var config int XCOM_BIOSTUNLANCE_ISOUNDRANGE;
var config int XCOM_BIOSTUNLANCE_IENVIRONMENTDAMAGE;
var config int XCOM_BIOSTUNLANCE_ISUPPLIES;
var config int XCOM_BIOSTUNLANCE_TRADINGPOSTVALUE;
var config int XCOM_BIOSTUNLANCE_IPOINTS;
var config int XCOM_BIOSTUNLANCE_STUNCHANCE;
var config int XCOM_BIOSTUNLANCE_DISORIENTCHANCE;

var config WeaponDamageValue XCOM_BIOSTUNLANCE_MG_BASEDAMAGE;
var config int XCOM_BIOSTUNLANCE_MG_AIM;
var config int XCOM_BIOSTUNLANCE_MG_CRITCHANCE;
var config int XCOM_BIOSTUNLANCE_MG_ICLIPSIZE;
var config int XCOM_BIOSTUNLANCE_MG_ISOUNDRANGE;
var config int XCOM_BIOSTUNLANCE_MG_IENVIRONMENTDAMAGE;
var config int XCOM_BIOSTUNLANCE_MG_ISUPPLIES;
var config int XCOM_BIOSTUNLANCE_MG_TRADINGPOSTVALUE;
var config int XCOM_BIOSTUNLANCE_MG_IPOINTS;
var config int XCOM_BIOSTUNLANCE_MG_STUNCHANCE;
var config int XCOM_BIOSTUNLANCE_MG_DISORIENTCHANCE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
	{
	ModWeapons.AddItem(CreateTemplate_XComBioStunLance());
	ModWeapons.AddItem(CreateTemplate_XComBioStunLance_MG());
	}

	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_XComBioStunLance()
{
	local X2WeaponTemplate Template;
	local X2Effect_Persistent DisorientEffect;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'XComBioStunLance');
	
	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = 'beam';
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILIB_BioDivision.UI.UI_AdvStunBaton";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 2;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = default.XCOM_BIOSTUNLANCE_BASEDAMAGE;
	Template.Aim = default.XCOM_BIOSTUNLANCE_AIM;
	Template.CritChance = default.XCOM_BIOSTUNLANCE_CRITCHANCE;
	Template.iClipSize = default.XCOM_BIOSTUNLANCE_ICLIPSIZE;
	Template.iSoundRange = default.XCOM_BIOSTUNLANCE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.XCOM_BIOSTUNLANCE_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	
	 DisorientEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
     DisorientEffect.ApplyChance = default.XCOM_BIOSTUNLANCE_DISORIENTCHANCE;
     Template.BonusWeaponEffects.AddItem(DisorientEffect);
     Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, default.XCOM_BIOSTUNLANCE_STUNCHANCE, false));
     Template.SetUIStatMarkup(default.strDisorientChanceLabel, , default.XCOM_BIOSTUNLANCE_DISORIENTCHANCE, , , "%");
     Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , default.XCOM_BIOSTUNLANCE_STUNCHANCE, , , "%");

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Adv_StunLancer.WP_StunLance";
	
	//Template.CreatorTemplateName = 'CombatKnife_MG_Schematic'; // The schematic which creates this item
	//Template.BaseItem = 'CombatKnife_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.Abilities.AddItem('TJ_Stunlance');

	return Template;
}

static function X2DataTemplate CreateTemplate_XComBioStunLance_MG()
{
	local X2WeaponTemplate Template;
	local X2Effect_Persistent DisorientEffect;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'XComBioStunLance_MG');

	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = 'magnetic';
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILIB_BioDivision.UI.UI_AdvStunBaton";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = 2;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = default.XCOM_BIOSTUNLANCE_MG_BASEDAMAGE;
	Template.Aim = default.XCOM_BIOSTUNLANCE_MG_AIM;
	Template.CritChance = default.XCOM_BIOSTUNLANCE_MG_CRITCHANCE;
	Template.iClipSize = default.XCOM_BIOSTUNLANCE_MG_ICLIPSIZE;
	Template.iSoundRange = default.XCOM_BIOSTUNLANCE_MG_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.XCOM_BIOSTUNLANCE_MG_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	
	 DisorientEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
     DisorientEffect.ApplyChance = default.XCOM_BIOSTUNLANCE_MG_DISORIENTCHANCE;
     Template.BonusWeaponEffects.AddItem(DisorientEffect);
     Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, default.XCOM_BIOSTUNLANCE_MG_STUNCHANCE, false));
     Template.SetUIStatMarkup(default.strDisorientChanceLabel, , default.XCOM_BIOSTUNLANCE_MG_DISORIENTCHANCE, , , "%");
     Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , default.XCOM_BIOSTUNLANCE_MG_STUNCHANCE, , , "%");

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Adv_StunLancer.WP_StunLance";
	
	//Template.CreatorTemplateName = 'CombatKnife_MG_Schematic'; // The schematic which creates this item
	//Template.BaseItem = 'CombatKnife_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.Abilities.AddItem('TJ_Stunlance');

	return Template;
}
