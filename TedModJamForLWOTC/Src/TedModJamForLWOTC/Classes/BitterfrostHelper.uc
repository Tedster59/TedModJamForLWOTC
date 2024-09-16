class BitterfrostHelper extends object config(FrostDivision);

var config int Chill_Turns, BitterChill_Turns, BitterfrostFreeze_MinDuration, BitterfrostFreeze_MaxDuration;
var config float Chill_Mobility, Chill_Dodge, BitterChill_Mobility, BitterChill_Dodge;
var config string ChillParticle_Name;
var config name ChillSocket_Name, ChillSocketsArray_Name;
var localized string ChillEffectName, ChillEffectDesc, BitterChillEffectName, BitterChillEffectDesc;

static function ChillVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	if (EffectApplyResult != 'AA_Success')
		return;
	if (!ActionMetadata.StateObject_NewState.IsA('XComGameState_Unit'))
		return;

	class'X2StatusEffects'.static.AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.ChillEffectName, '', eColor_Bad, "img:///UILibrary_DLC2Images.UIPerk_freezingbreath");
	class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function BChillVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	if (EffectApplyResult != 'AA_Success')
		return;
	if (!ActionMetadata.StateObject_NewState.IsA('XComGameState_Unit'))
		return;

	class'X2StatusEffects'.static.AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.BitterChillEffectName, '', eColor_Bad, "img:///UILibrary_DLC2Images.UIPerk_freezingbreath");
	class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function X2Effect_PersistentStatChange ChillEffect()
{
	local X2Effect_PersistentStatChange	ChillEffect;

	ChillEffect = new class'X2Effect_PersistentStatChange';
	ChillEffect.BuildPersistentEffect(default.Chill_Turns, false, false, false, eGameRule_PlayerTurnEnd);
	ChillEffect.EffectName = 'MZChill';
	ChillEffect.DuplicateResponse = eDupe_Refresh;
	ChillEffect.bRemoveWhenTargetDies = true;
	ChillEffect.AddPersistentStatChange(eStat_Mobility, default.Chill_Mobility, MODOP_PostMultiplication);
	ChillEffect.AddPersistentStatChange(eStat_Dodge, default.Chill_Dodge, MODOP_PostMultiplication);
	ChillEffect.DamageTypes.AddItem('Frost');
	ChillEffect.SetDisplayInfo(ePerkBuff_Penalty, default.ChillEffectName , default.ChillEffectDesc, "img:///UILibrary_DLC2Images.PerkIcons.UIPerk_freezingbreath", true);
	ChillEffect.VisualizationFn = ChillVisualization;
	if (default.ChillParticle_Name != "")
	{
		ChillEffect.VFXTemplateName = default.ChillParticle_Name;
		ChillEffect.VFXSocket = default.ChillSocket_Name;
		ChillEffect.VFXSocketsArrayName = default.ChillSocketsArray_Name;
	}

	return ChillEffect;
}

static function X2Effect_PersistentStatChange BitterChillEffect(optional bool RequireChill = True)
{
	local X2Effect_PersistentStatChange		BitterChillEffect;
	local X2Condition_UnitEffects			ChillDegreeCondition;

	BitterChillEffect = new class'X2Effect_PersistentStatChange';
	BitterChillEffect.BuildPersistentEffect(default.BitterChill_Turns, false, false, false, eGameRule_PlayerTurnEnd);
	BitterChillEffect.EffectName = 'MZBitterChill';
	BitterChillEffect.DuplicateResponse = eDupe_Refresh;
	BitterChillEffect.bRemoveWhenTargetDies = true;
	BitterChillEffect.AddPersistentStatChange(eStat_Mobility, default.BitterChill_Mobility, MODOP_PostMultiplication);
	BitterChillEffect.AddPersistentStatChange(eStat_Dodge, default.BitterChill_Dodge, MODOP_PostMultiplication);
	BitterChillEffect.DamageTypes.AddItem('Frost');
	BitterChillEffect.SetDisplayInfo(ePerkBuff_Penalty, default.BitterChillEffectName , default.BitterChillEffectDesc, "img:///UILibrary_DLC2Images.PerkIcons.UIPerk_freezingbreath", true);
	BitterChillEffect.VisualizationFn = BChillVisualization;
	if ( RequireChill )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		BitterChillEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}

	return BitterChillEffect;
}

static function X2Effect_DLC_Day60Freeze FreezeEffect(optional bool bHasChillReq=true)
{
	local X2Condition_UnitEffects			ChillDegreeCondition;
	local X2Effect_DLC_Day60Freeze			FreezeEffect;

	FreezeEffect = class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeEffect(default.BitterfrostFreeze_MinDuration, default.BitterfrostFreeze_MaxDuration);
	FreezeEffect.bApplyRulerModifiers = true;
	if ( bHasChillReq )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		FreezeEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}

	return FreezeEffect;
}

static function X2Effect FreezeCleanse(optional bool bHasChillReq=true)
{
	local X2Condition_UnitEffects			ChillDegreeCondition;
	local X2Effect							RemoveEffects; 

	RemoveEffects=class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeRemoveEffects();
	if ( bHasChillReq )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		RemoveEffects.TargetConditions.AddItem(ChillDegreeCondition);
	}

	return RemoveEffects;
}

static function X2Effect UnChillEffect()
{
	local X2Effect_RemoveEffectsByDamageType	RemoveEffects;

	RemoveEffects = new class'X2Effect_RemoveEffectsByDamageType';
	RemoveEffects.DamageTypesToRemove[0] = 'frost';

	return RemoveEffects;
}

static function AddBitterfrostToMultiTarget(out X2AbilityTemplate Template)
{
	Template.AddMultiTargetEffect(FreezeCleanse());
	Template.AddMultiTargetEffect(FreezeEffect());
	Template.AddMultiTargetEffect(BitterChillEffect());
	Template.AddMultiTargetEffect(ChillEffect());
}

static function AddBitterfrostToTarget(out X2AbilityTemplate Template)
{
	Template.AddTargetEffect(FreezeCleanse());
	Template.AddTargetEffect(FreezeEffect());
	Template.AddTargetEffect(BitterChillEffect());
	Template.AddTargetEffect(ChillEffect());
}

static function AddBitterfrostToWeaponEffects(out X2WeaponTemplate Template, optional bool bAlwaysFreeze=false)
{
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;
	local X2Condition_UnitEffects			ChillDegreeCondition;

	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'MZ_FDImmediateApplyChillEffect';
	ImpairingAbilityEffect.AbilityName = 'MZ_FDImmediateApplyChill';
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = class'X2Ability_FrostDivisionChill'.static.ApplyChillAbilityEffectTriggeredVisualization;

	If ( !bAlwaysFreeze )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		ImpairingAbilityEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}

	Template.BonusWeaponEffects.AddItem(ImpairingAbilityEffect);
	Template.BonusWeaponEffects.AddItem(BitterChillEffect());
	Template.BonusWeaponEffects.AddItem(ChillEffect());

	Template.Abilities.AddItem('MZ_FDImmediateApplyChill');
}


static function AddColdPersona(out X2AbilityTemplate Template, bool bCanFreeze)
{
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;
	local X2Condition_UnitEffects			ChillDegreeCondition;
	local X2Condition_AbilityProperty		PersonaCondition;
	local X2Effect_PersistentStatChange		AChillEffect;
	local X2Effect_PersistentStatChange		BChillEffect;

	PersonaCondition = new class'X2Condition_AbilityProperty';
	PersonaCondition.OwnerHasSoldierAbilities.AddItem('ChosenFrostPersonality');

	if ( bCanFreeze )
	{
		ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
		ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
		ImpairingAbilityEffect.EffectName = 'MZ_FDImmediateApplyChillEffect';
		ImpairingAbilityEffect.AbilityName = 'MZ_FDImmediateApplyChill';
		ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
		ImpairingAbilityEffect.VisualizationFn = class'X2Ability_FrostDivisionChill'.static.ApplyChillAbilityEffectTriggeredVisualization;
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		ImpairingAbilityEffect.TargetConditions.AddItem(ChillDegreeCondition);

		if ( Template.AbilityMultiTargetEffects.Length > 0 )
		{
			Template.AddMultiTargetEffect(ImpairingAbilityEffect);
		}

		if ( Template.AbilityTargetEffects.Length > 0 )
		{
			Template.AddTargetEffect(ImpairingAbilityEffect);
		}
	}
	

	if ( Template.AbilityMultiTargetEffects.Length > 0 )
	{
		BChillEffect = BitterChillEffect();
		BChillEffect.TargetConditions.AddItem(PersonaCondition);
		Template.AddMultiTargetEffect(BChillEffect);

		AChillEffect = ChillEffect();
		AChillEffect.TargetConditions.AddItem(PersonaCondition);
		Template.AddMultiTargetEffect(AChillEffect);
	}

	if ( Template.AbilityTargetEffects.Length > 0 )
	{
		BChillEffect = BitterChillEffect();
		BChillEffect.TargetConditions.AddItem(PersonaCondition);
		Template.AddTargetEffect(BChillEffect);

		AChillEffect = ChillEffect();
		AChillEffect.TargetConditions.AddItem(PersonaCondition);
		Template.AddTargetEffect(AChillEffect);
	}
}