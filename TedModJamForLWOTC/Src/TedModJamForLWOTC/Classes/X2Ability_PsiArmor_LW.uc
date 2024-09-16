class X2Ability_PsiArmor_LW extends X2Ability
	dependson(XComGameStateContext_Ability) config(PsiArmorLW);

	var config int PSI_SUIT_HP_BONUS;
	var config int PSI_SUIT_ARMOR_BONUS;
	var config int PSI_SUIT_MOBILITY_BONUS;
	var config int PSI_SUIT_DEFENSE_BONUS;
	var config int PSI_SUIT_PSIOFFENSE_BONUS;

	var config int UnmovableSovereignCooldown;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(PsiArmorBonusStats_LW());
	Templates.AddItem(UnmovableSovereign());

	return Templates;
}

static function X2AbilityTemplate PsiArmorBonusStats_LW()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'PsiArmorBonusStats_LW');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.PSI_SUIT_HP_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.PSI_SUIT_ARMOR_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorChance, 100);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.PSI_SUIT_MOBILITY_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Defense, default.PSI_SUIT_DEFENSE_BONUS);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_PsiOffense, default.PSI_SUIT_PSIOFFENSE_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate UnmovableSovereign()
{
	local X2AbilityTemplate Template;
	local X2AbilityCooldown                     Cooldown;
	local X2AbilityCost_ActionPoints        AbilityActionPointCost;
	local X2Effect_GrantActionPoints ActionPointEffect;
	local X2Effect_PersistentStatChange		StatEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'UnmovableSovereign');

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.CustomFireAnim = 'HL_SignalNegative';
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///KetarosPkg_Abilities.UIPerk_skullking";

	AbilityActionPointCost = new class'X2AbilityCost_ActionPoints';
	AbilityActionPointCost.iNumPoints = 2;
	AbilityActionPointCost.bConsumeAllPoints = false;
	AbilityActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(AbilityActionPointCost);

	// Grants the non-movement action points
	ActionPointEffect = new class'X2Effect_GrantActionPoints';
	ActionPointEffect.NumActionPoints = 1;
	ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.RunAndGunActionPoint;
	Template.AddTargetEffect(ActionPointEffect);

	StatEffect = new class'X2Effect_PersistentStatChange';
	StatEffect.EffectName = 'UnmovableSovereignMovePenalty';
	StatEffect.DuplicateResponse = eDupe_Refresh;
	StatEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	StatEffect.AddPersistentStatChange(eStat_Mobility, 0.0, MODOP_Multiplication);
	Template.AddShooterEffect(StatEffect);
	
	// Cannot be used while burning, etc.
	Template.AddShooterEffectExclusions();

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.UnmovableSovereignCooldown;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityTargetStyle = default.SelfTarget;	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Show a flyover when activated
	Template.bShowActivation = true;

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

    return Template;
}