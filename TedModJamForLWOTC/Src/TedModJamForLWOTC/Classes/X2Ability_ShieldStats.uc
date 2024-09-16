class X2Ability_ShieldStats extends X2Ability config (Shields);

var config int ShieldStatsMJ_CV_ARMOR;
var config int ShieldStatsMJ_CV_DODGE;

var config int ShieldStatsMJ_MG_ARMOR;
var config int ShieldStatsMJ_MG_DODGE;

var config int ShieldStatsMJ_BM_ARMOR;
var config int ShieldStatsMJ_BM_DODGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
    
	Templates.AddItem(ShieldStatsMJ_CV());
	Templates.AddItem(ShieldStatsMJ_MG());
	Templates.AddItem(ShieldStatsMJ_BM());

	return Templates;
}

static function X2AbilityTemplate ShieldStatsMJ_CV()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PersistentStatChange         PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ShieldStatsMJ_CV');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilityWilltoSurvive";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.ShieldStatsMJ_CV_ARMOR);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.ShieldStatsMJ_CV_DODGE);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, default.ShieldStatsMJ_CV_ARMOR);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DodgeLabel, eStat_Dodge, default.ShieldStatsMJ_CV_DODGE);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate ShieldStatsMJ_MG()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PersistentStatChange         PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ShieldStatsMJ_MG');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilityWilltoSurvive";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.ShieldStatsMJ_MG_ARMOR);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.ShieldStatsMJ_MG_DODGE);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, default.ShieldStatsMJ_MG_ARMOR);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DodgeLabel, eStat_Dodge, default.ShieldStatsMJ_MG_DODGE);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

static function X2AbilityTemplate ShieldStatsMJ_BM()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PersistentStatChange         PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ShieldStatsMJ_BM');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilityWilltoSurvive";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.ShieldStatsMJ_BM_ARMOR);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.ShieldStatsMJ_BM_DODGE);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, default.ShieldStatsMJ_BM_ARMOR);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DodgeLabel, eStat_Dodge, default.ShieldStatsMJ_BM_DODGE);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}