class X2Ability_WraithVest extends X2Ability config(ACData);

var config int ADVENT_WRAITH_VEST_HP_BONUS;
var config(LW_Overhaul) int TACTICAL_CRITDEF_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(AdventWraithVestBonusAbility_LW());
	Templates.AddItem(PsiCommandoFireImmunity());
	Templates.AddItem(PsiCommandoKineticPlatingPassive());
	Templates.AddItem(PurgeImmunitiesDummy());
	Templates.AddItem(TriggerGuardDummy());
	Templates.AddItem(CreateTacticalVestBonusAbility_LW());
	
	return Templates;
}

static function X2AbilityTemplate AdventWraithVestBonusAbility_LW()
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;
	local X2Effect_DamageImmunity           DamageImmunity;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AdventWraithVestBonus_LW');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	//Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	
	// Bonus to health stat Effect 2 HP 
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(2, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false, , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.ADVENT_WRAITH_VEST_HP_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	DamageImmunity = new class'X2Effect_DamageImmunity';
	DamageImmunity.ImmuneTypes.AddItem('Fire'); //Added fire immunity
	DamageImmunity.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.KnockbackDamageType);
	DamageImmunity.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);
	DamageImmunity.BuildPersistentEffect(1, true, false, false);
	DamageImmunity.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false, , Template.AbilitySourceName);
	Template.AddTargetEffect(DamageImmunity);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate PsiCommandoFireImmunity()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('PsiCommandoFireImmunity', "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate PsiCommandoKineticPlatingPassive()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('PsiCommandoKineticPlatingPassive', "img:///KetarosPkg_Abilities.UIPerk_skullshield",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate PurgeImmunitiesDummy()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('PurgeImmunitiesDummy', "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate TriggerGuardDummy()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('TriggerGuardDummy', "img:///WP_Akimbo.UIIcons.DP_MeleeAim",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate CreateTacticalVestBonusAbility_LW()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_Resilience				CritDefEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'TacticalVestBonus_MJ');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	CritDefEffect = new class'X2Effect_Resilience';
	CritDefEffect.CritDef_Bonus = default.TACTICAL_CRITDEF_BONUS;
	CritDefEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(CritDefEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}