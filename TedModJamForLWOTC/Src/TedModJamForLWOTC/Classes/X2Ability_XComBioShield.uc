class X2Ability_XComBioShield extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(BioShieldGuard());

	return Templates;
}

static function X2AbilityTemplate BioShieldGuard()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_ShieldGuard				CoverEffect;
	//local X2Effect_ShieldGuardTriggered		FlyoverEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BioShieldGuard');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_takecover";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = true;
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	
	CoverEffect = new class'X2Effect_ShieldGuard';
	CoverEffect.BuildPersistentEffect(1, true, true, false, eGameRule_PlayerTurnBegin);
	CoverEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	Template.AddShooterEffect(CoverEffect);

	//FlyoverEffect.BuildPersistentEffect(1, true, true, false, eGameRule_PlayerTurnBegin);
	//Template.AddTargetEffect(FlyoverEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}