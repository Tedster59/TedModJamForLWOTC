class X2EventListener_Psi Extends X2EventListener config(TedPsiOverhaul);

var config int MaxPsiRank;
var config int NumKillsPerPostRank;
var config int NumPsiAbilitiesPerRank;
var config bool bAlwaysRankUp;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTrainingListeners());

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
