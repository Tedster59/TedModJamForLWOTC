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
	local bool									OverrideNormalBehavior, DoNotOverrideNormalBehavior;

	// Prepare return values to make it easier for us to read the code. Thanks Iridar!
	OverrideNormalBehavior = CheckGameState != none;
	DoNotOverrideNormalBehavior = CheckGameState == none;

	WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());

	// If DisabledReason is not blank, then this template has already been disabled by another mod, ignore.
	if (DisabledReason != "")
		return DoNotOverrideNormalBehavior;

	// If the template is normally allowed for this class, ignore
	//class can use this weapon natively, no need for us to enable it
	if(UnitState.GetSoldierClassTemplate().IsWeaponAllowedByClass(WeaponTemplate))
	{
		return DoNotOverrideNormalBehavior;
	}

	foreach default.ABILITY_WEAPON_UNLOCKS(AbilityUnlock)
	{
		if (UnitState.HasAbilityFromAnySource(AbilityUnlock.ABILITY_NAME))
		{
			if (WeaponTemplate.WeaponCat == AbilityUnlock.WEAPON_CATEGORY)
			{
				DisabledReason = "";

				// Unit has an ability enabling this weapon template, allow
				if (UnitState.GetItemInSlot(Slot, CheckGameState) == none)
				{
					bCanAddItem = 1;
				}

				return OverrideNormalBehavior;
			}
		}
	}

	return DoNotOverrideNormalBehavior;
}
