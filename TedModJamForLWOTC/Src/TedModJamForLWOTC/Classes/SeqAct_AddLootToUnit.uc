// This is an Unreal Script

class SeqAct_AddLootToUnit extends SequenceAction;

var int MinAlloys, MaxAlloys, MinElerium, MaxElerium, MinDatapads, MaxDatapads, MinDataCaches, MaxDataCaches;
var int AlloyChance, EleriumChance, DatapadChance, DataCacheChance;


event activated()
{
	local XComGameState			NewGameState;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local SeqVar_GameStateList List;
	local StateObjectReference StateRef;
	
	`Log("SeqAct_AddLootToUnit ModifyKismetGameState activated",,'TedLog');
	History = `XCOMHISTORY;
	
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("SeqAct_AwardLoot");
	foreach LinkedVariables(class'SeqVar_GameStateList', List, "Game State List")
	{

		foreach List.GameStates( StateRef )
		{
			UnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(StateRef.ObjectID));

			if(UnitState == none)
			{
				`Log("SeqAct_AddLootToUnit: Unit not found in NewGameState, checking History",,'TedLog');
				UnitState = XComGameState_Unit(History.GetGameStateForObjectID(StateRef.ObjectID));
			}

			`Log("SeqAct_AddLootToUnit linked variables: unit:" @UnitState.GetFullName(),,'TedLog');

			if(UnitState != none)
			{
				UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
				RollForLoot(UnitState, NewGameState);
			}
		}
	}

	if (NewGameState.GetNumGameStateObjects() > 0)
		`TACTICALRULES.SubmitGameState(NewGameState);
	else
		History.CleanupPendingGameState(NewGameState);

}

function RollForLoot(out XComGameState_Unit TargetUnit, XComGameState NewGameState)
{
	local X2ItemTemplate ItemTemplate;
	local X2ItemTemplateManager ItemMgr;
	local int Alloys, Elerium, Datapads, DataCaches;
	local int idx;

	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	`Log("RollForLoot called with unit" @TargetUnit.GetFullName(),,'TedLog');

	`Log(MinAlloys @MaxAlloys @MinElerium @MaxElerium @ MinDatapads @MaxDatapads @MinDataCaches @MaxDataCaches,,'TedLog');
	`Log(AlloyChance @EleriumChance @DatapadChance @DataCacheChance,,'TedLog');

	if(TargetUnit != none)
	{
		// Roll the loot values
		if(`SYNC_RAND(100) < AlloyChance)
			Alloys = MinAlloys + `SYNC_RAND_STATIC(MaxAlloys-MinAlloys+1);
		
		if(`SYNC_RAND(100) < EleriumChance)
			Elerium = MinElerium + `SYNC_RAND_STATIC(MaxElerium-MinElerium+1);

		if(`SYNC_RAND(100) < DatapadChance)
			Datapads = MinDatapads + `SYNC_RAND_STATIC(MaxDatapads-MinDatapads+1);

		if(`SYNC_RAND(100) < DataCacheChance)
			DataCaches = MinDataCaches + `SYNC_RAND_STATIC(MaxDataCaches-MinDataCaches+1);

		// Add the loot to the unit if rolled
		if(Alloys > 0)
		{
			ItemTemplate = ItemMgr.FindItemTemplate('AlienAlloy');
			if(ItemTemplate != none)
			{
				for (idx = 0; idx < Alloys; idx++)
				{
					TargetUnit.PendingLoot.LootToBeCreated.AddItem(ItemTemplate.DataName);
				}
				`Log("Adding" @Alloys@ "Alloys to unit.",,'TedLog');
			}
		}

		if(Elerium > 0)
		{
			ItemTemplate = ItemMgr.FindItemTemplate('EleriumDust');
			if(ItemTemplate != none)
			{
				for (idx = 0; idx < Alloys; idx++)
				{
					TargetUnit.PendingLoot.LootToBeCreated.AddItem(ItemTemplate.DataName);
				}
				`Log("Adding" @Elerium@ "EleriumDust to unit.",,'TedLog');
			}
		}

		if(Datapads > 0)
		{
			ItemTemplate = ItemMgr.FindItemTemplate('AdventDatapad');
			if(ItemTemplate != none)
			{
				for (idx = 0; idx < Alloys; idx++)
				{
					TargetUnit.PendingLoot.LootToBeCreated.AddItem(ItemTemplate.DataName);
				}
				`Log("Adding" @Datapads@ "Advent Datapads to unit.",,'TedLog');
			}
		}

		if(DataCaches > 0)
		{
			ItemTemplate = ItemMgr.FindItemTemplate('AlienDatapad');
			if(ItemTemplate != none)
			{
				for (idx = 0; idx < Alloys; idx++)
				{
					TargetUnit.PendingLoot.LootToBeCreated.AddItem(ItemTemplate.DataName);
				}
			}
			`Log("Adding" @DataCaches@ "Alien Data Caches to unit.",,'TedLog');
		}

	}
}

defaultproperties
{
	ObjCategory="Loot"
	ObjName="Add Loot to Units"

	bConvertedForReplaySystem=true
	bCanBeUsedForGameplaySequence=true
	bAutoActivateOutputLinks=true

	VariableLinks.Empty
	VariableLinks(0)=(ExpectedType=class'SeqVar_GameStateList',LinkDesc="Game State List",MinVars=1,MaxVars=1)
	MinAlloys=8
	MaxAlloys=16
	AlloyChance=100
	MinElerium=5
	MaxElerium=10
	EleriumChance=100
	MinDatapads=2
	MaxDatapads=4
	DatapadChance=25
	MinDataCaches=1
	MaxDataCaches=2
	DataCacheChance=15
}
