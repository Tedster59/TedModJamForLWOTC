class X2Ability_Underbarrels extends X2Ability config(Underbarrel);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Create_ExtraCharges_UBFlameSecondary());
	Templates.AddItem(UnderbarrelShotgunCompensator());

	return Templates;
}

static function X2AbilityTemplate Create_ExtraCharges_UBFlameSecondary()
{
	local X2AbilityTemplate         Template;
	local X2Effect_GrantCharges		Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ExtraCharges_UBFlameSecondary');

	Template.IconImage = "img:///Underbarrel.UI.UB_Attachment";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bHideOnClassUnlock = true;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'X2Effect_GrantCharges';
	Effect.AbilityNames.AddItem('Fire_UBFlame_Conv');
	Effect.AbilityNames.AddItem('Fire_UBFlame_Mag');
	Effect.AbilityNames.AddItem('Fire_UBFlame_Beam');
	Effect.NumCharges = class'X2Item_Underbarrels'.default.UBGL_EXTRA_FLAMETHROWER_USES_PER_SECONDARY;
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate UnderbarrelShotgunCompensator()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('UnderbarrelShotgunCompensator', "img:///KetarosPkg_Abilities.UIPerk_hipfire",, 'eAbilitySource_Perk');

	return Template;
}