class OPTC_SawedOffOverwatch extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;

    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustSawedOffOverwatchAbility(AbilityTemplateManager.FindAbilityTemplate('NoneShallPass_LW'));
}
 
static function AdjustSawedOffOverwatchAbility(X2AbilityTemplate Template)
{
	local X2Condition_NotItsOwnTurn					NotItsOwnTurnCondition;
	local X2AbilityTrigger_Event						Trigger;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
		Trigger = new class'X2AbilityTrigger_Event';
		Trigger.EventObserverClass = class'X2TacticalGameRuleset_AttackObserver';
		Trigger.MethodName = 'InterruptGameState';
		Template.AbilityTriggers.AddItem(Trigger);

		NotItsOwnTurnCondition = new class'X2Condition_NotItsOwnTurn';
		Template.AbilityShooterConditions.AddItem(NotItsOwnTurnCondition);
    }
}