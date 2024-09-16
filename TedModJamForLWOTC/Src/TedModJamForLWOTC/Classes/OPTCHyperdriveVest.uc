class OPTCHyperdriveVest extends X2DownloadableContentInfo config(HyperDriveVestIncompatibleClasses);

var config array<name> IncompatibleClasses;

static function bool UnitIsIncompatible(const XComGameState_Unit UnitState)
{
	return default.IncompatibleClasses.Find(UnitState.GetSoldierClassTemplateName()) != INDEX_NONE;
}

static function bool CanAddItemToInventory_CH_Improved(
    out int bCanAddItem,                   // out value for XComGameState_Unit
    const EInventorySlot Slot,             // Inventory Slot you're trying to equip the Item into
    const X2ItemTemplate ItemTemplate,     // Item Template of the Item you're trying to equip
    int Quantity, 
    XComGameState_Unit UnitState,          // Unit State of the Unit you're trying to equip the Item on
    optional XComGameState CheckGameState, 
    optional out string DisabledReason,    // out value for the UIArmory_Loadout
    optional XComGameState_Item ItemState) // Item State of the Item we're trying to equip
{
	local XGParamTag	LocTag;

	local bool OverrideNormalBehavior;
    local bool DoNotOverrideNormalBehavior;

    // Prepare return values to make it easier for us to read the code.
    OverrideNormalBehavior = CheckGameState != none;
    DoNotOverrideNormalBehavior = CheckGameState == none;

	if(DisabledReason != "")
    return DoNotOverrideNormalBehavior;

	// do the filtering only if trying to...
	if(UnitIsIncompatible(UnitState) &&	//	equip something on an exotic class
		Slot == eInvSlot_Utility || Slot == eInvSlot_Vest)	// into the utility or vest slot
	{
		if (ItemTemplate.DataName == 'XcomHyperDriveVest'|| ItemTemplate.DataName == 'Xcom_Flechette')
		{

			// if we're trying to equip one of these items
			// we build a message that will be shown to the player stating that this item is not available to the class
			LocTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
			LocTag.StrValue0 = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager().FindSoldierClassTemplate(UnitState.GetSoldierClassTemplateName()).DisplayName;
			DisabledReason = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(`XEXPAND.ExpandString(class'UIArmory_Loadout'.default.m_strNeedsSoldierClass));

			bCanAddItem = 0;

			return OverrideNormalBehavior; // and disallow equipping the item
		}

	}

	 // in all other cases don't do any filtering.
	return DoNotOverrideNormalBehavior;
}