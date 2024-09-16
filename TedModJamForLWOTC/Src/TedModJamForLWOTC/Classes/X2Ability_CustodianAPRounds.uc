class X2Ability_CustodianAPRounds extends X2Ability config(Custodian_Xcom_Items);

var config int CUSTODIAN_APROUNDS_PIERCE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(CustodianAPRoundsAbility());
	
	return Templates;
}

static function X2AbilityTemplate CustodianAPRoundsAbility()
{
	local X2AbilityTemplate             Template;
	local X2Effect_CustodianAPRounds    Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'CustodianAPRoundsAbility');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.bDisplayInUITacticalText = false;

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'X2Effect_CustodianAPRounds';
	Effect.BuildPersistentEffect(1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Effect.Pierce = default.CUSTODIAN_APROUNDS_PIERCE;
	Template.AddShooterEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}