class OPTCAirdrop extends X2DownloadableContentInfo config(Game);

var config name AirdropAbility;
var config array<name> Blacklist;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate         Template;
    local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2Condition_UnitProperty			TargetProperty;
	local X2AbilityTrigger					Trigger;
	local X2AbilityTrigger_EventListener	EventTrigger;
	local int i;

    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate(default.AirdropAbility);

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish.
		Template.AbilityTargetConditions.length = 0;  //reset
        //  (in this case, make the Airdrop ability able to target robots and aliens)
		TargetProperty = new class'X2Condition_UnitProperty';

	    for (i = 0 ; i < default.Blacklist.length ; i++)
        {
        TargetProperty.ExcludeSoldierClasses.AddItem(default.Blacklist[i]);
        }

        TargetProperty.ExcludeDead = true;
		TargetProperty.ExcludeHostileToSource = true;
		TargetProperty.ExcludeFriendlyToSource = false;
		TargetProperty.TreatMindControlledSquadmateAsHostile = true;
		TargetProperty.RequireSquadmates = true;
        TargetProperty.ExcludeRobotic = false;
		TargetProperty.ExcludeAlien = false;
		Template.AbilityTargetConditions.AddItem(TargetProperty);
    }

	// Add Containment Field here too:

	Template = AbilityTemplateManager.FindAbilityTemplate('MZGremlinStasis');

	if (Template != none)
    {
		TargetProperty = new class'X2Condition_UnitProperty';
		TargetProperty.ExcludeFriendlyToSource = false;
		TargetProperty.ExcludeLargeUnits = true;

		Template.AbilityTargetConditions.AddItem(TargetProperty);

	}

	Template = AbilityTemplateManager.FindAbilityTemplate('MZHostageProtocol');

	if (Template != none)
    {
		TargetProperty = new class'X2Condition_UnitProperty';
		TargetProperty.ExcludeLargeUnits = true;

		Template.AbilityTargetConditions.AddItem(TargetProperty);

	}

	// Airstrike here too, because why not.

	Template = AbilityTemplateManager.FindAbilityTemplate('ShadowOps_Airstrike');

	if (Template != none)
    {
		Template.CustomFireAnim = 'HL_SignalPositive';
	}

	// Multitasking, since gremlin stuff here too.

	Template = AbilityTemplateManager.FindAbilityTemplate('Multitasking');

	if (Template != none)
	{
		foreach Template.AbilityTriggers (Trigger)
		{
			EventTrigger = X2AbilityTrigger_EventListener(Trigger);

			if (EventTrigger != none)
			{
				EventTrigger.ListenerData.EventFn = AbilityTriggerEventListener_Multitasking;
			}
		}
	}
}


static function EventListenerReturn AbilityTriggerEventListener_Multitasking(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
    local XComGameStateContext_Ability  AbilityContext;
    local XComGameState_Ability         AbilityState;

    AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
    AbilityState = XComGameState_Ability(CallbackData);

    if (AbilityContext.InputContext.PrimaryTarget.ObjectID != AbilityContext.InputContext.SourceObject.ObjectID)
        return AbilityState.AbilityTriggerEventListener_Self(EventData, EventSource, GameState, EventID, CallbackData);

    return ELR_NoInterrupt;
}