class X2Condition_MetionBattlesuitEquipped extends X2Condition;

//var() EInventorySlot RelevantSlot;
//var() name ItemTemplateName;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
    local array<XComGameState_Item> SlotItems;
    local XComGameState_Item        ItemState;
    local XComGameState_Unit        SourceUnit;

    SourceUnit = XComGameState_Unit(kTarget);

    // this condition can only ever be valid if the source unit has an equipped a specific item before arriving in tactical
    SlotItems = SourceUnit.GetAllItemsInSlot(eInvSlot_Armor);
    foreach SlotItems(ItemState)
    {
        if (ItemState.GetMyTemplateName() == 'MetionBattleSuit')
            return 'AA_UnitIsImmune';
    }

    return 'AA_Success';
}