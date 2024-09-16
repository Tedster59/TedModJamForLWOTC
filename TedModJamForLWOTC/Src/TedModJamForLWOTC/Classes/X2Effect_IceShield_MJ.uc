class X2Effect_IceShield_MJ extends X2Effect_ModifyStats config(FrostDivision);

var config float ResistDamageMod, ResistDamageBypassShieldMod, HealthReductionMult, HealthToShieldMult, BETA_HealthToShieldMult, ArmourReductionMult, ArmourToShieldMult, BETA_ArmourToShieldMult;
var config array<name> FireWeapons, FireDamageTypes;

simulated function AddSpecialStatChange(XComGameState_Effect NewEffectState, ECharStatType StatType, float StatAmount,optional EStatModOp InModOp=MODOP_Addition )
{
	local StatChange NewChange;
	
	NewChange.StatType = StatType;
	NewChange.StatAmount = StatAmount;
	NewChange.ModOp = InModOp;

	NewEffectState.StatChanges.AddItem(NewChange);
}

function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	local XComGameState_Unit	Target;
	local array<name> AppliedDamageTypes;
	local name DamageType;
	local X2Effect_ApplyWeaponDamage ApplyDamageEffect;

	Target = XComGameState_Unit(TargetDamageable);
	if ( Target == none || Target.IsBurning() || CurrentDamage <= 1) { return 0; } // ||

	//need to do some checks for fire damage, which would negate shield DR
	if (FireWeapons.Find(AbilityState.GetSourceWeapon().GetMyTemplateName()) != INDEX_NONE || FireWeapons.Find(AbilityState.GetSourceAmmo().GetMyTemplateName()) != INDEX_NONE)
	{
		return 0;
	}

	ApplyDamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
	if (ApplyDamageEffect != none)
	{
		ApplyDamageEffect.GetEffectDamageTypes(NewGameState, AppliedData, AppliedDamageTypes);
		foreach AppliedDamageTypes(DamageType)
		{
			if (FireDamageTypes.Find(DamageType) != INDEX_NONE)
			{
				return 0;
			}
		}
	}

	if ( WeaponDamageEffect.bBypassShields == true )
	{
		return -Min(Round(CurrentDamage * ResistDamageBypassShieldMod), Target.GetCurrentStat(eStat_ShieldHP));
	}
	else
	{
		return -Min(Round(CurrentDamage * ResistDamageMod), Target.GetCurrentStat(eStat_ShieldHP));
	}
}

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TargetUnit;
	local int ShieldAmount;

	TargetUnit = XComGameState_Unit(kNewTargetState);

	if (`SecondWaveEnabled('BetaStrike') )
	{
		ShieldAmount = Round(TargetUnit.GetBaseStat(eStat_HP) * BETA_HealthToShieldMult + TargetUnit.GetBaseStat(eStat_ArmorMitigation) * BETA_ArmourToShieldMult);
	}
	else
	{
		ShieldAmount = Round(TargetUnit.GetBaseStat(eStat_HP) * HealthToShieldMult + TargetUnit.GetBaseStat(eStat_ArmorMitigation) * ArmourToShieldMult);
	}

	AddSpecialStatChange(NewEffectState, eStat_ShieldHP, ShieldAmount, MODOP_Addition);
	AddSpecialStatChange(NewEffectState, eStat_HP, HealthReductionMult, MODOP_Multiplication);
	AddSpecialStatChange(NewEffectState, eStat_ArmorMitigation, ArmourReductionMult, MODOP_Multiplication);


	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}

function bool ProvidesDamageImmunity(XComGameState_Effect EffectState, name DamageType)
{
	return DamageType == 'Frost';
}

defaultproperties
{
	EffectName = "MZ_FDIceShield_MJ"
	DuplicateResponse = eDupe_Ignore
}