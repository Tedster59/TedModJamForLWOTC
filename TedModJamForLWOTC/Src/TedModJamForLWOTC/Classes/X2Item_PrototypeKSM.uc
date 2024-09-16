// This creates a new Prototype Strike Module weapon for Spark Arsenal users.

class X2Item_PrototypeKSM extends X2Item config(KineticStrikeModule);

//var config int MELEE_DAMAGE_BONUS_FLAT;
//var config float MELEE_DAMAGE_BONUS_MULTIPLIER;
var config int KINETIC_STRIKE_ENVIRONMENTAL_DAMAGE;

var config WeaponDamageValue DAMAGE;
var config int IENVIRONMENTDAMAGE;
var config int AIM;
var config int CRITCHANCE;
var config int ICLIPSIZE;
var config int ISOUNDRANGE;
var config array<int> RANGE;

var config string IMAGE;
var config string GAME_ARCHETYPE;

var config int TYPICAL_ACTION_COST;
var config array<name> ABILITIES;

var config name ITEM_CATEGORY;
var config name WEAPON_CATEGORY;
var config int SORTING_TIER;
var config EInventorySlot INVENTORY_SLOT;
var config name WEAPON_TECH;
var config int NUM_UPGRADE_SLOTS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCMoreSparkWeapons'))
    {
	Templates.AddItem(CreateItem_PrototypeStrikeModule());
	}

	return Templates;
}

static function X2DataTemplate CreateItem_PrototypeStrikeModule()
{
	local X2WeaponTemplate Template;
	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'PrototypeStrikeModule');

	//Template.SetUIStatMarkup(class'XLocalizedData'.default.MeleeBonus,, Round(default.MELEE_DAMAGE_BONUS_MULTIPLIER * 100),,, "%");
	
	Template.WeaponPanelImage = "_ConventionalRifle";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	switch (default.WEAPON_TECH)
	{
		case 'conventional': 
			Template.EquipSound = "Conventional_Weapon_Equip";
			break;
		case 'magnetic':
			Template.EquipSound = "Magnetic_Weapon_Equip";
			break;
		case 'beam':
			Template.EquipSound = "Beam_Weapon_Equip";
			break;
	}

	Template.ItemCat = default.ITEM_CATEGORY;
	Template.WeaponCat = default.WEAPON_CATEGORY;
	Template.InventorySlot = default.INVENTORY_SLOT;
	Template.NumUpgradeSlots = default.NUM_UPGRADE_SLOTS;
	Template.Abilities = default.ABILITIES;
	
	Template.WeaponTech = default.WEAPON_TECH;
	
	Template.iTypicalActionCost = default.TYPICAL_ACTION_COST;
	
	Template.Tier = default.SORTING_TIER;

	Template.iRange = 0;
	Template.iRadius = 1;

	Template.RangeAccuracy = default.RANGE;
	Template.BaseDamage = default.DAMAGE;
	Template.Aim = default.AIM;
	Template.CritChance = default.CRITCHANCE;
	Template.iClipSize = default.ICLIPSIZE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	Template.iSoundRange = default.ISOUNDRANGE;
	Template.iEnvironmentDamage = default.IENVIRONMENTDAMAGE;
	
	//Template.iPhysicsImpulse = 5;
	//Template.fKnockbackDamageAmount = 5.0f;
	//Template.fKnockbackDamageRadius = 0.0f;
	
	Template.GameArchetype = default.GAME_ARCHETYPE;
	Template.strImage = default.IMAGE;
	
	//Template.AddDefaultAttachment('Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagA");

	Template.StartingItem = true;
	Template.bInfiniteItem = true;
	Template.CanBeBuilt = false;
	
	Template.PointsToComplete = 0;
	
	return Template;
}