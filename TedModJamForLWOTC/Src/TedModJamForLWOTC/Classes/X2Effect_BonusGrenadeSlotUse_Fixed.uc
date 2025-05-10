//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_BonusGrenadeSlotUse
//  AUTHOR:  Amineri (Pavonis Interactive) / tweaked by Kiruka / Tedster
//  PURPOSE: General effect for granting extra uses of stuff
//--------------------------------------------------------------------------------------- 

class X2Effect_BonusGrenadeSlotUse_Fixed extends X2Effect_Persistent;

var int BonusUses;
var bool bDamagingGrenadesOnly;
var bool bNonDamagingGrenadesOnly;
var EInventorySlot SlotType;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameStateHistory		History;
	local XComGameState_Unit		UnitState; 
	local XComGameState_Item		ItemState, UpdatedItemState, ItemInnerIter;
	local X2WeaponTemplate			WeaponTemplate;
	local int						Idx, InnerIdx, BonusAmmo;

	History = `XCOMHISTORY;

	UnitState = XComGameState_Unit(kNewTargetState);
	if (UnitState == none)
		return;

	for (Idx = 0; Idx < UnitState.InventoryItems.Length; ++Idx)
	{
		ItemState = XComGameState_Item(History.GetGameStateForObjectID(UnitState.InventoryItems[Idx].ObjectID));
		if (ItemState != none && !ItemState.bMergedOut)
		{
			WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());
			if(X2GrenadeTemplate(WeaponTemplate) != none || WeaponTemplate.DataName == 'Battlescanner')
			{
				//`Log("Checking Weapon" @WeaponTemplate.DataName,,'TedLog');
				BonusAmmo = 0;
				if (WeaponTemplate != none)// && WeaponTemplate.bMergeAmmo)
				{
					//if (ItemState.InventorySlot == SlotType && ValidGrenadeType(ItemState, WeaponTemplate))
					if (ValidGrenadeType(ItemState, WeaponTemplate))
					{
						//`Log("Adding bonus use to" @WeaponTemplate.DataName,,'TedLog');
						BonusAmmo += BonusUses;
					}

					for (InnerIdx = 0; InnerIdx < UnitState.InventoryItems.Length; ++InnerIdx)
					{
						//`Log("Inner loop start",,'TedLog');
						if(InnerIdx == Idx)
						{
							//`Log("Skipping currently selected item",,'TedLog');
							// skip the currently selected item
							continue;
						}

						ItemInnerIter = XComGameState_Item(History.GetGameStateForObjectID(UnitState.InventoryItems[InnerIdx].ObjectID));
						`Log("Checking inner item" @ItemInnerIter.GetMyTemplateName(),,'TedLog');
						if (ItemInnerIter != none && ItemInnerIter.GetMyTemplate() == WeaponTemplate)
						{
							//if (ItemInnerIter.InventorySlot == SlotType && ValidGrenadeType(ItemInnerIter, WeaponTemplate))
							if (ValidGrenadeType(ItemInnerIter, WeaponTemplate))
							{
								//`Log("Adding bonus use to" @ItemInnerIter.GetMyTemplateName(),,'TedLog');
								BonusAmmo += BonusUses;
							}
						}
					}
				
				}
				if(BonusAmmo > 0)
				{
					UpdatedItemState = ItemState;
					`Log("Adding" @BonusAmmo@ "ammo to" @UpdatedItemState.GetMyTemplateName(),,'TedLog');
					UpdatedItemState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', ItemState.ObjectID));
					UpdatedItemState.Ammo += BonusAmmo;
				}
			}
		}
	}

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}

simulated function bool ValidGrenadeType(XComGameState_Item ItemState, X2WeaponTemplate WeaponTemplate)
{
	if(bDamagingGrenadesOnly)
	{
		if(WeaponTemplate.BaseDamage.Damage <= 0)
			return false;
	}
	if(bNonDamagingGrenadesOnly)
	{
		if(WeaponTemplate.BaseDamage.Damage > 0)
			return false;
	}
	return true;
}

defaultProperties
{
	bInfiniteDuration = true;
}