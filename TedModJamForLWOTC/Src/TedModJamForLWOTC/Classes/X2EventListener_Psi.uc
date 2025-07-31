// This file is also being hijacked for will/under-infil related things

class X2EventListener_Psi Extends X2EventListener config(TedPsiOverhaul);

var config int MaxPsiRank;
var config int NumKillsPerPostRank;
var config int NumPsiAbilitiesPerRank;
var config bool bAlwaysRankUp;
var config array<float> InfiltrationRNFMods;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTrainingListeners());
	Templates.AddItem(CreateRNFListeners());

	return Templates;
}

static function CHEventListenerTemplate CreateTrainingListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'TedJamPsiSoldierTraining');
	Template.AddCHEvent('PsiProjectCompleted', OnPsiProjectCompleted, ELD_Immediate);
	Template.AddCHEvent('CustomPsiRankupCondition', LWCustomPsiRankUpCondition, ELD_Immediate);
	Template.RegisterInStrategy = true;

	return Template;
}


static function CHEventListenerTemplate CreateRNFListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'TedJamReinforcementListeners');
	Template.AddCHEvent('GetReinforcementValue', GetInfilReinforcementValue, ELD_Immediate);
	Template.AddCHEvent('PlayerTurnEnded', RollForPerTurnWillLossUnderinfil, ELD_OnStateSubmitted, 90);

	Template.RegisterInStrategy = false;
	Template.RegisterInTactical = True;

	return Template;

}


static function EventListenerReturn OnPsiProjectCompleted(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;
	local X2SoldierClassTemplate SoldierClassTemplate;
	local XComGameState NewGameState;
	local SCATProgression PsiAbility;
	local array<SCATProgression> PsiAbilityDeck;
	local int NumRanks, iRank, iBranch, idx;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
	{
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(Tuple.Data[0].o);
	if (UnitState == none || UnitState.GetRank() != 1)
	{
		return ELR_NoInterrupt;
	}

	SoldierClassTemplate = UnitState.GetSoldierClassTemplate();
	if (SoldierClassTemplate == none)
	{
		return ELR_NoInterrupt;
	}

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Update Psi Ability deck for unit");

	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectId));

		UnitState.PsiAbilities.Length = 0;

	NumRanks = SoldierClassTemplate.GetMaxConfiguredRank();

	for (iRank = 0; iRank < NumRanks; iRank++)
	{
		`Log("Psi class ability length at rank" @iRank @":" @ SoldierClassTemplate.SoldierRanks[iRank].AbilitySlots.Length,,'TedLog');
		// This assumes Psi Ops have pistol row!
		for (iBranch = 0; iBranch < SoldierClassTemplate.SoldierRanks[iRank].AbilitySlots.Length; iBranch++)
		{
			// Config to exclude XCOM/pistol rows
			if(iBranch >= default.NumPsiAbilitiesPerRank)
				continue;
			PsiAbility.iRank = iRank;
			PsiAbility.iBranch = iBranch;
			if(SoldierClassTemplate.SoldierRanks[iRank].AbilitySlots[iBranch].AbilityType.AbilityName != '') // Added none-check
			{
				PsiAbilityDeck.AddItem(PsiAbility);
			}
		}
	}

	while (PsiAbilityDeck.Length > 0)
	{
		// Choose an ability randomly from the deck
		idx = `SYNC_RAND_STATIC(PsiAbilityDeck.Length);
		PsiAbility = PsiAbilityDeck[idx];
		UnitState.PsiAbilities.AddItem(PsiAbility);
		PsiAbilityDeck.Remove(idx, 1);
	}

	`GAMERULES.SubmitGameState(NewGameState);

}

// Implements post progression for psi ops
static function EventListenerReturn LWCustomPsiRankUpCondition(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;
	local int NumKills, PostProgressionRank;

	Tuple = XComLWTuple(EventData);
	if(Tuple == none || Tuple.Id != 'CustomPsiRankupCondition')
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if(UnitState == none)
	{
		`REDSCREEN("OnCheckForPsiPromotion event triggered with invalid event source.");
		return ELR_NoInterrupt;
	}

	if(default.bAlwaysRankUp)
	{
		Tuple.Data[0].b = true;
		Tuple.Data[1].b = true;
		return ELR_NoInterrupt;
	}

	if(!UnitState.bRankedUp)
	{
		NumKills = UnitState.GetTotalNumKills();

		if (UnitState.GetSoldierRank() < UnitState.GetSoldierClassTemplate().GetMaxConfiguredRank())
		{
			// Let LWOTC promotions handle it from there.
			return ELR_NoInterrupt;
		}
		else
		{
			PostProgressionRank = UnitState.m_SoldierProgressionAbilties.Length - UnitState.GetSoldierClassTemplate().GetMaxConfiguredRank();

			`Log("Psi Post Progression Rank:"@PostProgressionRank,,'TedLog');
			if (NumKills >= (class'X2ExperienceConfig'.static.GetRequiredKills(UnitState.GetSoldierRank() + 1) + default.NumKillsPerPostRank * PostProgressionRank)
				&& UnitState.GetSoldierRank() <= default.MaxPsiRank
				&& UnitState.GetStatus() != eStatus_PsiTesting
				&& !UnitState.IsPsiTraining()
				&& !UnitState.IsPsiAbilityTraining()
				&& UnitState.IsAlive()
				&& !UnitState.bCaptured)
			{
				Tuple.Data[0].b = true;
				Tuple.Data[1].b = true;
				return ELR_NoInterrupt;
			}
			else
			{
				Tuple.Data[0].b = true;
				Tuple.Data[1].b = false;
				return ELR_NoInterrupt;
			}
		}
	}

	return ELR_NoInterrupt;
}

static function EventListenerReturn GetInfilReinforcementValue(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{

	local XComLWTuple Tuple;
	local XComGameState_MissionSite MissionState;
	local XComGameState_WorldRegion Region;
	local XComLWTValue Value;
	local int AlertDiff, BaseAlert;

	Tuple = XComLWTuple(EventData);
	if(Tuple == none || Tuple.Id != 'CustomPsiRankupCondition')
		return ELR_NoInterrupt;


	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(`XCOMHQ.MissionRef.ObjectID));

	if(MissionState == none)
	{
		return ELR_NoInterrupt;
	}

	if(!`LWSQUADMGR.static.IsValidInfiltrationMission(`XCOMHQ.MissionRef))
	{
		return ELR_NoInterrupt;
	}

	Region = MissionState.GetWorldRegion();

	BaseAlert = class'XComGameState_LWAlienActivityManager'.static.GetMissionAlertLevel(MissionState);

	// Min of 0, max of 0% infil value which is like 12 I think?
	AlertDiff = min(0, MissionState.SelectedMissionData.AlertLevel - BaseAlert);

	if(AlertDiff > 0)
	{
		AlertDiff = clamp(AlertDiff, 1, default.InfiltrationRNFMods.Length-1);
		Value.kind = XComLWTVFloat;
		Value.f = default.InfiltrationRNFMods[AlertDiff];

		Tuple.Data.AddItem(Value);
	}

	return ELR_NoInterrupt;
}



static protected function EventListenerReturn RollForPerTurnWillLossUnderinfil(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameStateHistory History;
	local XComGameState_Player PlayerState;
	local XComGameState_HeadquartersXCom XComHQ;
	local StateObjectReference SquadRef;
	local XComGameState_Unit SquadUnit;
	local XComGameState_LWPersistentSquad Squad;
	local XComGameState_LWSquadManager SquadMgr;
	local WillEventRollData WillRollData;
	local float WillRollCapValue, WillDeltaPercent;
	local int WillDelta;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class' XComGameState_HeadquartersXCom'));
	PlayerState = XComGameState_Player(EventData);

	SquadMgr = `LWSQUADMGR;

	Squad = SquadMgr.GetSquadOnMission(XComHQ.MissionRef);

	WillRollData.WillLossChance = 1;
	WillRollData.FlatWillLossChance = true;
	WillRollData.WillLossStat =  WillEventRollStat_None;
	WillRollData.MinimumWillLoss = 1;


	// We only want to lose Will every n turns, so skip other turns
	if (PlayerState.GetTeam() != eTeam_XCom)
		return ELR_NoInterrupt;

	if(!SquadMgr.IsValidInfiltrationMission(XComHQ.MissionRef))
	{
		return ELR_NoInterrupt;
	}

	// remove will faster if we're underinfiltrated
	if(Squad.CurrentInfiltration < 1.0)
	{

		if(Squad.CurrentInfiltration >= 0.85 && PlayerState.PlayerTurnCount % 4 != 0)
		{
			return ELR_NoInterrupt;
		}

		if(Squad.CurrentInfiltration < 0.85 && Squad.CurrentInfiltration > 0.5 && PlayerState.PlayerTurnCount % 3 != 0)
		{
			return ELR_NoInterrupt;
		}

		if(Squad.CurrentInfiltration < 0.5 && Squad.CurrentInfiltration > 0.3 && PlayerState.PlayerTurnCount % 2 != 0)
		{
			return ELR_NoInterrupt;
		}

		WillRollCapValue = Lerp(1.0, 0.4, Squad.CurrentInfiltration);

		WillRollData.MaxWillPercentageLostPerMission = WillRollCapValue;

		// Remove Will from all squad members
		foreach XComHQ.Squad(SquadRef)
		{
			SquadUnit = XComGameState_Unit(History.GetGameStateForObjectID(SquadRef.ObjectID));

			// Unit should lose Will this turn, so do it
			DecreaseWill(WillRollData, SquadUnit);

			WillDelta = SquadUnit.GetMaxStat(eStat_Will) - SquadUnit.GetCurrentStat(eStat_Will);

			WillDeltaPercent = float(WillDelta) / SquadUnit.GetMaxStat(eStat_Will);
			if( WillDeltaPercent >= 0.4 && PlayerState.PlayerTurnCount % 2 != 0)
			{
				DecreaseWill(WillRollData, SquadUnit);
			}
		}
	}

	return ELR_NoInterrupt;
}

static function DecreaseWill(WillEventRollData WillRollData, XComGameState_Unit SquadUnit)
{
	local XComGameStateContext_WillRoll WillRollContext;

	if (class'XComGameStateContext_WillRoll'.static.ShouldPerformWillRoll(WillRollData, SquadUnit))
	{
		WillRollContext = class'XComGameStateContext_WillRoll'.static.CreateWillRollContext(SquadUnit, 'PlayerTurnEnd',, false);
		WillRollContext.DoWillRoll(WillRollData);
		WillRollContext.Submit();
	}

	return;
}
