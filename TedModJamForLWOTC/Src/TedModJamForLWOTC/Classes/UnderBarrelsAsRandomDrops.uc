class UnderBarrelsAsRandomDrops extends X2DownloadableContentInfo config(Underbarrel);

var config bool UnderbarrelsDropInTimedLoot;
var config array<LootTable> UnderbarrelsModJamLootEntry;

static event OnPostTemplatesCreated()
{
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCUnderbarrelAttachments'))
    {
		if (default.UnderbarrelsDropInTimedLoot)
		{
			PatchWeaponUpgrades();
		}
	}
}

static function PatchWeaponUpgrades()
{
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCUnderbarrelAttachments'))
    {
		if (default.UnderbarrelsDropInTimedLoot)
		{
			AddLootTables();
		}
	}
}

static function AddLootTables()
{
	local X2LootTableManager	LootManager;
	local LootTable				LootBag;
	local LootTableEntry		Entry;
	
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCUnderbarrelAttachments'))
    {
	
		LootManager = X2LootTableManager(class'Engine'.static.FindClassDefaultObject("X2LootTableManager"));

		Foreach default.UnderbarrelsModJamLootEntry(LootBag)
		{
			if ( LootManager.default.LootTables.Find('TableName', LootBag.TableName) != INDEX_NONE )
			{
				foreach LootBag.Loots(Entry)
				{
					class'X2LootTableManager'.static.AddEntryStatic(LootBag.TableName, Entry, true);
				}
			}	
		}
	}
}