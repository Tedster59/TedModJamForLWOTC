class GrantWeaponWithAbility extends X2DownloadableContentInfo config(GrantWeaponWithAbility);

// ***********************************************************
// **** All credit for this file's code goes to shiremct. ****
// ***********************************************************

// Adding this to Mod Jam to reduce the number of dependencies and user steps.

// Setup Structs
struct ABILITY_WEAPON_UNLOCK
{
	var name											ABILITY_NAME;
	var name											WEAPON_CATEGORY;
};

var config array<ABILITY_WEAPON_UNLOCK>					ABILITY_WEAPON_UNLOCKS;

// Setup hooks allowing additional weapons to be equipped from abilities
static function bool CanAddItemToInventory_CH_Improved(out int bCanAddItem, const EInventorySlot Slot, const X2ItemTemplate ItemTemplate, int Quantity, XComGameState_Unit UnitState, optional XComGameState CheckGameState, optional out string DisabledReason, optional XComGameState_Item ItemState)
{
	local X2WeaponTemplate						WeaponTemplate;
	local ABILITY_WEAPON_UNLOCK					AbilityUnlock;

	WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());
	if(CheckGameState == none)
	{
		// If DisabledReason is not blank, then this template has already been disabled by another mod, ignore.
		if (DisabledReason != "")
			return true;

		// If the template is normally allowed for this class, ignore
		if (UnitState.GetSoldierClassTemplate().IsWeaponAllowedByClass(WeaponTemplate))
			return true;

		foreach default.ABILITY_WEAPON_UNLOCKS(AbilityUnlock)
		{
			if (UnitState.HasSoldierAbility(AbilityUnlock.ABILITY_NAME))
			{
				if (WeaponTemplate.WeaponCat == AbilityUnlock.WEAPON_CATEGORY)
				{
					// Unit has an ability enabling this weapon template, allow
					DisabledReason = "";
					return false;
		}	}	}
		return true;
	}
	return CanAddItemToInventory(bCanAddItem, Slot, ItemTemplate, Quantity, UnitState, CheckGameState);	
}

static private function bool CanAddItemToInventory(out int bCanAddItem, const EInventorySlot Slot, const X2ItemTemplate ItemTemplate, int Quantity, XComGameState_Unit UnitState, XComGameState CheckGameState)
{
	local X2WeaponTemplate						WeaponTemplate;
	local ABILITY_WEAPON_UNLOCK					AbilityUnlock;

	bCanAddItem = 0;
	WeaponTemplate = X2WeaponTemplate(ItemTemplate);
	
	// If the template is normally allowed for this class, ignore
	if (UnitState.GetSoldierClassTemplate().IsWeaponAllowedByClass(WeaponTemplate))
		return false;

	foreach default.ABILITY_WEAPON_UNLOCKS(AbilityUnlock)
	{
		if (UnitState.HasSoldierAbility(AbilityUnlock.ABILITY_NAME))
		{
			if (WeaponTemplate.WeaponCat == AbilityUnlock.WEAPON_CATEGORY)
			{
				// Unit has an ability enabling this weapon template, allow
				bCanAddItem = 1;
				break;
	}	}	}
	return bCanAddItem > 0;
}