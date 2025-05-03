// This adds the NotItsOwnTurn condition to Close Combat Specialist (LWOTC edition) and to the Biozerker's Bladestorm-like attack
// Also changes the Threat Assessment effect on Aid Protocol to work with primary pistol classes

class OPTC_CCS extends X2DownloadableContentInfo config(Game);

var config array<name> PrimaryPistolClasses;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('CloseCombatSpecialistAttack'));
	AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('ZerkerPuntAttack'));
	AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('WardenBladestormAttack'));
	AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('ABBCannonCloseCombatSpecialist'));
	AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('ABBPistolCloseCombatSpecialist'));
	AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('DP_CQCSupremacyAttack'));
	AdjustCCSAbility(AbilityTemplateManager.FindAbilityTemplate('DP_CQCSupremacyAttackSecondary'));
	//AdjustAidProtocolAbility(AbilityTemplateManager.FindAbilityTemplate('AidProtocol'));
	AdjustShadowstepAbility(AbilityTemplateManager.FindAbilityTemplate('Shadowstep'));
}
 
static function AdjustCCSAbility(X2AbilityTemplate Template)
{
	local X2Condition_NotItsOwnTurn		NotItsOwnTurnCondition;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        NotItsOwnTurnCondition = new class'X2Condition_NotItsOwnTurn';
		Template.AbilityShooterConditions.AddItem(NotItsOwnTurnCondition);
    }
}

static function AdjustAidProtocolAbility(X2AbilityTemplate Template)
{
	local X2Effect_ThreatAssessment             CoveringFireEffect;
	local X2Condition_AbilityProperty           AbilityCondition;
	local X2Condition_UnitProperty              UnitCondition;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		CoveringFireEffect = new class'X2Effect_ThreatAssessment';
		CoveringFireEffect.EffectName = 'PistolThreatAssessment';
		CoveringFireEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnBegin);
		CoveringFireEffect.AbilityToActivate = 'PistolReturnFire';
		CoveringFireEffect.ImmediateActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
		AbilityCondition = new class'X2Condition_AbilityProperty';
		AbilityCondition.OwnerHasSoldierAbilities.AddItem('ThreatAssessment');
		CoveringFireEffect.TargetConditions.AddItem(AbilityCondition);
		UnitCondition = new class'X2Condition_UnitProperty';
		UnitCondition.ExcludeHostileToSource = true;
		UnitCondition.ExcludeFriendlyToSource = false;
		UnitCondition.RequireSoldierClasses = default.PrimaryPistolClasses;
		CoveringFireEffect.TargetConditions.AddItem(UnitCondition);
		Template.AddTargetEffect(CoveringFireEffect);
    }
}

static function AdjustShadowstepAbility(X2AbilityTemplate Template)
{
	local X2Effect_CannotTargetShadowstep	PersistentEffect;
    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		PersistentEffect = new class'X2Effect_CannotTargetShadowstep';
		PersistentEffect.BuildPersistentEffect(1, true, false);
		//PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
		Template.AddTargetEffect(PersistentEffect);
    }
}