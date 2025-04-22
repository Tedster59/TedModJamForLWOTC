// This is an Unreal Script

class OPTC_RenewalProtocol extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated ()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	local X2AbilityTemplate AbilityTemplate;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('ShadowOps_RestorationProtocol');

	if(AbilityTemplate != NONE)
	{
		AbilityTemplate.BuildVisualizationFn = GremlinSingleTargetWithRevive_BuildVisualization;
	}
}


static simulated function GremlinSingleTargetWithRevive_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local X2AbilityTemplate             AbilityTemplate, ThreatTemplate;
	local StateObjectReference          InteractingUnitRef;
	local XComGameState_Item			GremlinItem;
	local XComGameState_Unit			TargetUnitState;
	local XComGameState_Unit			AttachedUnitState;
	local XComGameState_Unit			OldTargetState, UnitState;
	local XComGameState_Unit			GremlinUnitState, ActivatingUnitState;
	local array<PathPoint> Path;
	local TTile                         TargetTile;
	local TTile							StartTile;

	local VisualizationActionMetadata        EmptyTrack;
	local VisualizationActionMetadata        ActionMetadata;
	local X2Action_WaitForAbilityEffect DelayAction;
	local X2Action_AbilityPerkStart		PerkStartAction;
	local X2Action_CameraLookAt			CameraAction;

	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local int EffectIndex;
	local PathingInputData              PathData;
	local PathingResultData				ResultData;
	local X2Action_PlayAnimation		PlayAnimation;

	local X2VisualizerInterface TargetVisualizerInterface;
	local string FlyOverText, FlyOverIcon;
	local X2AbilityTag AbilityTag;

	local X2Action_CameraLookAt			TargetCameraAction;
	local Actor TargetVisualizer;

	local X2Action_Knockback KnockBackAction;	
	local XComGameStateVisualizationMgr VisualizationMgr;
	local XGUnit Unit;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);

	TargetUnitState = XComGameState_Unit( VisualizeGameState.GetGameStateForObjectID( Context.InputContext.PrimaryTarget.ObjectID ) );

	GremlinItem = XComGameState_Item( History.GetGameStateForObjectID( Context.InputContext.ItemObject.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 ) );
	GremlinUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.CosmeticUnitRef.ObjectID ) );
	AttachedUnitState = XComGameState_Unit( History.GetGameStateForObjectID( GremlinItem.AttachedUnitRef.ObjectID ) );
	ActivatingUnitState = XComGameState_Unit( History.GetGameStateForObjectID( Context.InputContext.SourceObject.ObjectID) );

	if( GremlinUnitState == none )
	{
		`RedScreen("Attempting GremlinSingleTarget_BuildVisualization with a GremlinUnitState of none");
		return;
	}
	
	//Configure the visualization track for the shooter
	//****************************************************************************************

	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.SourceObject;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID( InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1 );
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID( InteractingUnitRef.ObjectID );
	ActionMetadata.VisualizeActor = History.GetVisualizer( InteractingUnitRef.ObjectID );

	CameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	CameraAction.LookAtActor = ActionMetadata.VisualizeActor;
	CameraAction.BlockUntilActorOnScreen = true;

	class'X2Action_IntrusionProtocolSoldier'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	if (AbilityTemplate.ActivationSpeech != '')
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.ActivationSpeech, eColor_Good);
	}

	// make sure he waits for the gremlin to come back, so that the cinescript camera doesn't pop until then
	X2Action_WaitForAbilityEffect(class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded)).SetCustomTimeOutSeconds(30);

	//Configure the visualization track for the gremlin
	//****************************************************************************************

	InteractingUnitRef = GremlinUnitState.GetReference( );

	ActionMetadata = EmptyTrack;
	History.GetCurrentAndPreviousGameStatesForObjectID(GremlinUnitState.ObjectID, ActionMetadata.StateObject_OldState, ActionMetadata.StateObject_NewState, , VisualizeGameState.HistoryIndex);
	ActionMetadata.VisualizeActor = GremlinUnitState.GetVisualizer();
	TargetVisualizer = History.GetVisualizer(Context.InputContext.PrimaryTarget.ObjectID);

	class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

	if (AttachedUnitState.TileLocation != TargetUnitState.TileLocation)
	{
		// Given the target location, we want to generate the movement data.  

		//Handle tall units.
		TargetTile = TargetUnitState.GetDesiredTileForAttachedCosmeticUnit();
		StartTile = AttachedUnitState.GetDesiredTileForAttachedCosmeticUnit();

		class'X2PathSolver'.static.BuildPath(GremlinUnitState, StartTile, TargetTile, PathData.MovementTiles);
		class'X2PathSolver'.static.GetPathPointsFromPath( GremlinUnitState, PathData.MovementTiles, Path );
		class'XComPath'.static.PerformStringPulling(XGUnitNativeBase(ActionMetadata.VisualizeActor), Path);

		PathData.MovingUnitRef = GremlinUnitState.GetReference();
		PathData.MovementData = Path;
		Context.InputContext.MovementPaths.AddItem(PathData);

		class'X2TacticalVisibilityHelpers'.static.FillPathTileData(PathData.MovingUnitRef.ObjectID,	PathData.MovementTiles,	ResultData.PathTileData);
		Context.ResultContext.PathResults.AddItem(ResultData);

		class'X2VisualizerHelpers'.static.ParsePath( Context, ActionMetadata);

		if( TargetVisualizer != none )
		{
			TargetCameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
			TargetCameraAction.LookAtActor = TargetVisualizer;
			TargetCameraAction.BlockUntilActorOnScreen = true;
			TargetCameraAction.LookAtDuration = 10.0f;		// longer than we need - camera will be removed by tag below
			TargetCameraAction.CameraTag = 'TargetFocusCamera';
			TargetCameraAction.bRemoveTaggedCamera = false;
		}
	}

	PerkStartAction = X2Action_AbilityPerkStart(class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	PerkStartAction.NotifyTargetTracks = true;

	PlayAnimation = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree( ActionMetadata, Context ));
	if( AbilityTemplate.CustomSelfFireAnim != '' )
	{
		PlayAnimation.Params.AnimName = AbilityTemplate.CustomSelfFireAnim;
	}
	else
	{
		PlayAnimation.Params.AnimName = 'NO_CombatProtocol';
	}

	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree( ActionMetadata, Context );

	//****************************************************************************************

	//Configure the visualization track for the target
	//****************************************************************************************
	InteractingUnitRef = Context.InputContext.PrimaryTarget;
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = TargetVisualizer;

	DelayAction = X2Action_WaitForAbilityEffect( class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree( ActionMetadata, Context ) );
	DelayAction.ChangeTimeoutLength( class'X2Ability_SpecialistAbilitySet'.default.GREMLIN_ARRIVAL_TIMEOUT );       //  give the gremlin plenty of time to show up
	
	for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
	{
		AbilityTemplate.AbilityTargetEffects[ EffectIndex ].AddX2ActionsForVisualization( VisualizeGameState, ActionMetadata, Context.FindTargetEffectApplyResult( AbilityTemplate.AbilityTargetEffects[ EffectIndex ] ) );
	}
					
	if (AbilityTemplate.bShowActivation)
	{
		OldTargetState = XComGameState_Unit(ActionMetadata.StateObject_OldState);
		//`Log("OldTargetState.IsBleedingOut" @ OldTargetState.IsBleedingOut());
		if(OldTargetState.IsBleedingOut())
		{
			
			UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);

			//Don't visualize if the unit is dead or still incapacitated.
			if( UnitState == none || UnitState.IsDead() || UnitState.IsIncapacitated() || UnitState.bRemovedFromPlay )
				return;

			//Don't add duplicate knockback actions.
			VisualizationMgr = `XCOMVISUALIZATIONMGR;
			KnockBackAction = X2Action_Knockback(VisualizationMgr.GetNodeOfType(VisualizationMgr.VisualizationTree, class'X2Action_Knockback', ActionMetadata.VisualizeActor));
			if(KnockBackAction == none)
			{
				KnockBackAction = X2Action_Knockback(class'X2Action_Knockback'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
			}
	
			KnockBackAction.OnlyRecover = true;

			AddEffectMessageToTrack(
				ActionMetadata,
				class'X2StatusEffects'.default.BleedingOutEffectLostString,
				VisualizeGameState.GetContext(),
				class'UIEventNoticesTactical'.default.UnconsciousTitle,
				"img:///UILibrary_PerkIcons.UIPerk_stun",
				eUIState_Good);
			UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());

			// Need to reinit the behavior since this is destroyed upon adding the Unconscious effect (via X2Action_Death).
			Unit = XGUnit(UnitState.GetVisualizer());
			if (Unit != None && Unit.m_kBehavior == None)
			{
				Unit.InitBehavior();
			}
		}

		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		if (AbilityTemplate.DataName == 'AidProtocol' && ActivatingUnitState.HasSoldierAbility('ThreatAssessment'))
		{
			ThreatTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('ThreatAssessment');
			FlyOverText = ThreatTemplate.LocFlyOverText;			
			FlyOverIcon = ThreatTemplate.IconImage;
		}
		else
		{		
			FlyOverText = AbilityTemplate.LocFlyOverText;
			FlyOverIcon = AbilityTemplate.IconImage;
		}
		AbilityTag = X2AbilityTag(`XEXPANDCONTEXT.FindTag("Ability"));
		AbilityTag.ParseObj = History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID);
		FlyOverText = `XEXPAND.ExpandString(FlyOverText);
		AbilityTag.ParseObj = none;

		SoundAndFlyOver.SetSoundAndFlyOverParameters(none, FlyOverText, '', eColor_Good, FlyOverIcon, 1.5f, true);
	}

	TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
	if (TargetVisualizerInterface != none)
	{
		//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
		TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, ActionMetadata);
	}

	if( TargetCameraAction != none )
	{
		TargetCameraAction = X2Action_CameraLookAt(class'X2Action_CameraLookAt'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		TargetCameraAction.CameraTag = 'TargetFocusCamera';
		TargetCameraAction.bRemoveTaggedCamera = true;
	}

	//****************************************************************************************
}

// Copied from X2StatusEffects
static function AddEffectMessageToTrack(
	out VisualizationActionMetadata ActionMetadata, 
	string UnexpandedLocString, 
	XComGameStateContext Context, 
	string TitleString, 
	string IconPath, 
	EUIState UIStyleType,
	optional bool bDontPlaySoundEvent)
{
	local XComGameState_Unit UnitState;
	local XGParamTag kTag;
	local X2Action_PlayMessageBanner MessageAction;
	local X2Action_PlayWorldMessage WorldMessageAction;

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);
	if (UnitState == none || UnitState.bRemovedFromPlay)
		return;

	kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	kTag.StrValue0 = UnitState.GetFullName();

	if(kTag.StrValue0 != "")
	{
		if( UIStyleType == eUIState_Warning || (UnitState.GetTeam() != eTeam_XCom && UnitState.GetTeam() != eTeam_Resistance) )
		{
			WorldMessageAction = X2Action_PlayWorldMessage(class'X2Action_PlayWorldMessage'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
			WorldMessageAction.AddWorldMessage(`XEXPAND.ExpandString(UnexpandedLocString));
		}
		else
		{
			MessageAction = X2Action_PlayMessageBanner(class'X2Action_PlayMessageBanner'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
			MessageAction.AddMessageBanner(TitleString,
										   ,  // IconPath - not used here b/c we want to always show the default icon for status effects
										   UnitState.GetName(eNameType_RankFull),
										   `XEXPAND.ExpandString(UnexpandedLocString),
										   UIStyleType);
			MessageAction.bDontPlaySoundEvent = bDontPlaySoundEvent;
		}
	}
}

static function UpdateUnitFlag(out VisualizationActionMetadata ActionMetadata, XComGameStateContext Context)
{
	local X2Action_UpdateUI UpdateUIAction;

	if (XComGameState_Unit(ActionMetadata.StateObject_NewState) == none)
		return;

	UpdateUIAction = X2Action_UpdateUI(class'X2Action_UpdateUI'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
	UpdateUIAction.SpecificID = ActionMetadata.StateObject_NewState.ObjectID;
	UpdateUIAction.UpdateType = EUIUT_UnitFlag_Buffs;
}
