class X2Ability_TJPlating extends X2Ability config(TJPlating);

var config int CEREBRAL_PLATING_HP;
var config int REFLEX_PLATING_HP;
var config int FROST_PLATING_HP;
var config int CHAMELEON_PLATING_HP;
var config int CHAMELEON_PLATING_DODGE_BONUS;

var config int REFLEX_PLATING_DEFENSE;
var config int REFLEX_PLATING_DODGE;

var localized string AblativeHPLabel;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateAblativeHPAbility('Cerebral_Plating_Ability', default.CEREBRAL_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Reflex_Plating_Ability', default.REFLEX_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Frost_Plating_Ability', default.FROST_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Chameleon_Plating_Ability', default.CHAMELEON_PLATING_HP));

	Templates.AddItem(ReflexPlatingBonus_LW());
	Templates.AddItem(FrostPlatingBonus_LW());
	Templates.AddItem(ChameleonPlatingBonus_LW());

	return Templates;

}

static function X2AbilityTemplate CreateAblativeHPAbility(name TemplateName, int AblativeHPAmt)
{
	local X2AbilityTemplate                 Template;
	local X2Effect_PersistentStatChange		AblativeHP;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bShowActivation=false;
	Template.bDisplayInUITacticalText = false;
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	AblativeHP = new class'X2Effect_PersistentStatChange';
	AblativeHP.BuildPersistentEffect(1, true, false, false);
	AblativeHP.AddPersistentStatChange(eStat_ShieldHP, AblativeHPAmt);
	Template.AddTargetEffect(AblativeHP);
	Template.SetUIStatMarkup(default.AblativeHPLabel, eStat_ShieldHP, AblativeHPAmt);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

static function X2AbilityTemplate ReflexPlatingBonus_LW()
{
    local X2AbilityTemplate         Template;
    local X2Effect_MovingTarget_LW  Effect;

    `CREATE_X2ABILITY_TEMPLATE(Template, 'ReflexPlatingBonus_LW');

    Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_lightningreflexes";
    Template.AbilitySourceName = 'eAbilitySource_Item';
    Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
    Template.Hostility = eHostility_Neutral;
    Template.bIsPassive = true;
    Template.bUniqueSource = false;

    Template.bCrossClassEligible = false;

    Template.AbilityToHitCalc = default.DeadEye;
    Template.AbilityTargetStyle = default.SelfTarget;
    Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

    Effect = new class'X2Effect_MovingTarget_LW';
    Effect.EffectName = 'ReflexPlatingBonus_LW';
    Effect.MT_DEFENSE = default.REFLEX_PLATING_DEFENSE;
    Effect.MT_DODGE = default.REFLEX_PLATING_DODGE;
    Effect.DuplicateResponse = eDupe_Allow;
    Effect.BuildPersistentEffect(1, true, false);
    Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
    Template.AddTargetEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

    return Template;
}

static function X2AbilityTemplate FrostPlatingBonus_LW()
{
	local X2AbilityTemplate Template;
	local X2Effect_DamageImmunity DamageImmunity;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'FrostPlatingBonus_LW');

	Template.bDontDisplayInAbilitySummary = true;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.IconImage = "img:///UILibrary_DLC2Images.UIPerk_freezingbreath";
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	// Build the immunities
	DamageImmunity = new class'X2Effect_DamageImmunity';
	DamageImmunity.BuildPersistentEffect(1, true, false, true);
	DamageImmunity.ImmuneTypes.AddItem('Frost');
	DamageImmunity.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, , , Template.AbilitySourceName);
	DamageImmunity.EffectName = 'FrostPlatingBonusDamageImmunityEffect';
	Template.AddTargetEffect(DamageImmunity);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate ChameleonPlatingBonus_LW()
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ChameleonPlatingBonus_LW');
	Template.IconImage = "img:///UILibrary_SODragoon.UIPerk_inspiration";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	
	// Bonus to health stat Effect
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, , , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.CHAMELEON_PLATING_DODGE_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}