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
		Template.BuildVisualizationFn = Airstrike_BuildVisualizationFixed;
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

// Courtesy of robojumper
static simulated function Airstrike_BuildVisualizationFixed(XComGameState VisualizeGameState)
{
        local XComGameStateHistory History;
        local XComGameStateContext_Ability Context;
        local StateObjectReference InteractingUnitRef;

        local XComGameState_Ability AbilityState;
        local X2AbilityTemplate AbilityTemplate;
        
        local VisualizationActionMetadata EmptyTrack;
        local VisualizationActionMetadata BuildTrack;
        local X2Action_PlayAnimation PlayAnimation;
        local X2VisualizerInterface TargetVisualizerInterface;
        local int i, j;

        local XComGameState_EnvironmentDamage DamageEventStateObject;
		local XComGameState_WorldEffectTileData WorldDataUpdate;
		local XComGameState_InteractiveObject InteractiveObject;
        

        History = class'XComGameStateHistory'.static.GetGameStateHistory();

        Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());

        AbilityState = XComGameState_Ability(VisualizeGameState.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID));
        AbilityTemplate = AbilityState.GetMyTemplate();
        
        //Configure the visualization track for the shooter
        //****************************************************************************************

        //****************************************************************************************
        InteractingUnitRef = Context.InputContext.SourceObject;
        BuildTrack = EmptyTrack;
        BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
        BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
        BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

        // Exit Cover
        class'X2Action_ExitCover'.static.AddToVisualizationTree(BuildTrack, Context);

        // Play the firing action (requires CustomFireAnim)
        PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(BuildTrack, Context));
        PlayAnimation.Params.AnimName = AbilityTemplate.CustomFireAnim;

        // Air strike:
        // is a part of the shooter track, because who else would be the track actor?
        // this action will notify all the targets that the projectile hit
        class'X2Action_Airstrike'.static.AddToVisualizationTree(BuildTrack, Context);

        // enter cover
        class'X2Action_EnterCover'.static.AddToVisualizationTree(BuildTrack, Context);


        //****************************************************************************************

        //****************************************************************************************
        //Configure the visualization track for the targets
        //****************************************************************************************
        for( i = 0; i < Context.InputContext.MultiTargets.Length; ++i )
        {
                InteractingUnitRef = Context.InputContext.MultiTargets[i];
                BuildTrack = EmptyTrack;
                BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
                BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
                BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

                class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree( BuildTrack, Context );

                for( j = 0; j < Context.ResultContext.MultiTargetEffectResults[i].Effects.Length; ++j )
                {
                        Context.ResultContext.MultiTargetEffectResults[i].Effects[j].AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j]);
                }

                TargetVisualizerInterface = X2VisualizerInterface(BuildTrack.VisualizeActor);
                if( TargetVisualizerInterface != none )
                {
                        //Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
                        TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildTrack);
                }
        }
        //****************************************************************************************

        //****************************************************************************************
        //Configure the visualization track for the targets
        //****************************************************************************************
        // add visualization of environment damage
        foreach VisualizeGameState.IterateByClassType( class'XComGameState_EnvironmentDamage', DamageEventStateObject )
        {
                BuildTrack = EmptyTrack;
                BuildTrack.StateObject_OldState = DamageEventStateObject;
                BuildTrack.StateObject_NewState = DamageEventStateObject;
                BuildTrack.VisualizeActor = class'XComGameStateHistory'.static.GetGameStateHistory().GetVisualizer(DamageEventStateObject.ObjectID);
                class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(BuildTrack, Context);
                class'X2Action_ApplyWeaponDamageToTerrain'.static.AddToVisualizationTree(BuildTrack, Context);
        }
        //****************************************************************************************

	// From Merist- world effect vis
	foreach VisualizeGameState.IterateByClassType(class'XComGameState_WorldEffectTileData', WorldDataUpdate)
    {
        BuildTrack = EmptyTrack;
        BuildTrack.VisualizeActor = none;
        BuildTrack.StateObject_NewState = WorldDataUpdate;
        BuildTrack.StateObject_OldState = WorldDataUpdate;

        // Wait until signaled by the shooter that the projectiles are hitting
        class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(BuildTrack, Context);

        for(i = 0; i < AbilityTemplate.AbilityMultiTargetEffects.Length; ++i)
        {
            AbilityTemplate.AbilityMultiTargetEffects[i].AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, 'AA_Success');
        }

    }
    // ****************************************************************************************

    // Process any interactions with interactive objects
    foreach VisualizeGameState.IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObject)
    {
        // Add any doors that need to listen for notification
        if (InteractiveObject.IsDoor() && InteractiveObject.HasDestroyAnim() && InteractiveObject.InteractionCount % 2 != 0 ) // Is this a closed door?
        {
            BuildTrack = EmptyTrack;
            // Don't necessarily have a previous state, so just use the one we know about
            BuildTrack.StateObject_OldState = InteractiveObject;
            BuildTrack.StateObject_NewState = InteractiveObject;
            BuildTrack.VisualizeActor = History.GetVisualizer(InteractiveObject.ObjectID);
            class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(BuildTrack, Context);
            class'X2Action_BreakInteractActor'.static.AddToVisualizationTree(BuildTrack, Context);
        }
    }
}
