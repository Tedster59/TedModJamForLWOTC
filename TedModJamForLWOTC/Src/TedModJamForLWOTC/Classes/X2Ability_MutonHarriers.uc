class X2Ability_MutonHarriers extends X2ability config(MutonHarrier);

var config float HARRIER_ROCKET_DAMAGE_RADIUS;

var config int HARRIER_ROCKET_DMG_PER_TICK;
var config int HARRIER_ROCKET_SPREAD_PER_TICK;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(MutonHarrier_RussianRoulette());
	Templates.AddItem(RippleRounds());
	Templates.AddItem(CreateHarrierRocketMJAbility());

	return Templates;
}

static function X2AbilityTemplate MutonHarrier_RussianRoulette()
{
	local X2AbilityTemplate             Template;
	local X2Effect_RussianRoulette	    PersistentEffect;
	local X2Effect_Persistent						RussianRouletteTargetEffect;
	local X2Condition_UnitEffectsWithAbilitySource	RussianRouletteTargetCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MutonHarrier_RussianRoulette');

	Template.IconImage = "img:///KetarosPkg_Abilities.UIPerk_bullets3";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bIsPassive = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentEffect = new class'X2Effect_RussianRoulette';
	PersistentEffect.BuildPersistentEffect(1, true, false);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(PersistentEffect);

	RussianRouletteTargetEffect = new class'X2Effect_Persistent';
	RussianRouletteTargetEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
	RussianRouletteTargetEffect.EffectName = 'RussianRouletteTarget';
	RussianRouletteTargetEffect.bApplyOnMiss = true; //Only one chance, even if you miss (prevents making multiple attempts on one target)
	Template.AddTargetEffect(RussianRouletteTargetEffect);
	
	RussianRouletteTargetCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	RussianRouletteTargetCondition.AddExcludeEffect('RussianRouletteTarget', 'AA_DuplicateEffectIgnored');
	Template.AbilityTargetConditions.AddItem(RussianRouletteTargetCondition);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Note: no visualization on purpose!

	Template.bCrossClassEligible = false;

	return Template;
}

static function X2AbilityTemplate RippleRounds()
{
	local X2AbilityTemplate             Template;
	local X2Effect_PsiRipple		     Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RippleRounds');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'X2Effect_PsiRipple';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2DataTemplate CreateHarrierRocketMJAbility()
{
	local X2AbilityTemplate                         Template;
	local X2AbilityCost_Ammo                        AmmoCost;
	local X2AbilityCost_ActionPoints                ActionPointCost;
	local X2Effect_ApplyWeaponDamage                WeaponEffect;
	local X2AbilityMultiTarget_Radius               RadiusMultiTarget;
	local X2AbilityCooldown_LocalAndGlobal          Cooldown;
	local X2AbilityToHitCalc_StandardAim            StandardAim;
	local X2Effect_ApplyFireToWorld                 FireToWorldEffect;
	local X2Effect_Burning                          BurningEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HarrierRocketMJ');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_fanfire";
	// This action is considered 'hostile' and can be interrupted!
	Template.DisplayTargetHitChance = true;
	Template.Hostility = eHostility_Offensive;

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.bUseAmmoAsChargesForHUD = false;

	// Cooldown on the ability
	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 0;
	Cooldown.NumGlobalTurns = 0;
	Template.AbilityCooldown = Cooldown;

	AmmoCost = new class'X2AbilityCost_Ammo';	
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bIgnoreCoverBonus = true;
	Template.AbilityToHitCalc = StandardAim;

	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";
	
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityTargetStyle = default.SimpleSingleTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = default.HARRIER_ROCKET_DAMAGE_RADIUS;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	FireToWorldEffect = new class'X2Effect_ApplyFireToWorld';
	FireToWorldEffect.bUseFireChanceLevel = true;
	FireToWorldEffect.FireChance_Level1 = 0;
	FireToWorldEffect.FireChance_Level2 = 0.2;
	FireToWorldEffect.FireChance_Level3 = 0.1;
	FireToWorldEffect.bCheckForLOSFromTargetLocation = true; //false; The flamethrower does its own LOS filtering
	Template.AddMultiTargetEffect(FireToWorldEffect);

	BurningEffect = class'X2StatusEffects'.static.CreateBurningStatusEffect(default.HARRIER_ROCKET_DMG_PER_TICK, default.HARRIER_ROCKET_SPREAD_PER_TICK);
	Template.AddMultiTargetEffect(BurningEffect);

	WeaponEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddMultiTargetEffect(WeaponEffect);
	Template.AddTargetEffect(WeaponEffect);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.CustomFireAnim = 'FF_FireRocketA';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.GrenadeLostSpawnIncreasePerUse;
//BEGIN AUTOGENERATED CODE: Template Overrides 'MicroMissiles'
	Template.bFrameEvenWhenUnitIsHidden = true;
//END AUTOGENERATED CODE: Template Overrides 'MicroMissiles'

	return Template;
}