// Tedster - add some additional checks for impaired, also add a cap per turn

class X2Effect_DeflectEx_Updated extends X2Effect_Persistent;

var bool NoMelee, OnlyMelee, NoReactionFire, OnlyPrimaryTarget;
var int DeflectChance; //Mr. Nice: If not set by the ability template, then automatically deflects
var int MaxDeflectsPerTurn;

function bool ChangeHitResultForTarget(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, bool bIsPrimaryTarget, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
	local int Chance, RandRoll;
	local X2AbilityToHitCalc_StandardAim AttackToHit;
	local UnitValue UV;
	`log("THIS SHIT ISNT WORKING!!!!!!!!!!!!!!!!!!!");

	//	don't change a natural miss
	if(class'XComGameStateContext_Ability'.static.IsHitResultMiss(CurrentResult))
		return false;

	if(!TargetUnit.IsAbleToAct() || TargetUnit.IsImpaired())
		return false;

	TargetUnit.GetUnitValue('BioShieldDeflectValue', UV);

	if(UV.fValue >= MaxDeflectsPerTurn)
		return false;
	
	// Primary Target Check
	if(!bIsPrimaryTarget && OnlyPrimaryTarget)
		return false;

	//	respond to reaction fire?
	if(NoReactionFire)
	{
		AttackToHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if(AttackToHit != none && AttackToHit.bReactionFire)
			return false;
	}

	// respond to (non)melee?
	If(AbilityState.IsMeleeAbility())
	{
		if(!OnlyMelee && NoMelee)
			return false;
	}
	else
	{
		if(OnlyMelee)
			return false;
	}

	`log("X2Effect_DeflectEx::ChangeHitResultForTarget");

	Chance = GetDeflectChance(EffectState, Attacker, TargetUnit, AbilityState, bIsPrimaryTarget);
	if(Chance == 0)
	{
		NewHitResult = eHit_Deflect;
		return true;
	}

	RandRoll = `SYNC_RAND(100);
	if(RandRoll < Chance) //Mr. Nice: Get it right Firaxis!!!
	{
		`log("Deflect chance was" @ Chance @ "rolled" @ RandRoll @ "- success!");
		NewHitResult = eHit_Deflect;

		TargetUnit.SetUnitFloatValue('BioShieldDeflectValue', UV.fValue + 1, eCleanup_BeginTurn);
		return true;
	}
	`log("Deflect chance was" @ Chance @ "rolled" @ RandRoll @ "- failed.");

	return false;
}

function int GetDeflectChance(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, bool bIsPrimaryTarget)
{
	return DeflectChance;
}

DefaultProperties
{
	NoMelee = false
	OnlyMelee = false //Note: Only Melee overrides NoMelee
	NoReactionFire = false
	OnlyPrimaryTarget = true //could also be called NoAoE in practice
	
	// Usual defaults, unique name and no dupes
	DuplicateResponse = eDupe_Ignore
	EffectName = "DeflectEx"
}