// This is an Unreal Script

class OPTC_PlayableAliens extends X2DownloadableContentInfo config (GameData);

var config array<name> ALIEN_REWARDS;

static event OnPostTemplatesCreated ()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	local X2AbilityTemplate AbilityTemplate;
	local X2Condition_UnitEffects UnitEffectsCondition;

	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local name RewardName;


	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();


	// Add "not bound" condition to Bind again.
	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('Bind');

	if(AbilityTemplate != none)
	{
		UnitEffectsCondition = new class'X2Condition_UnitEffects';
		UnitEffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BoundName, 'AA_UnitIsBound');
		UnitEffectsCondition.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_CarryingUnit');
		UnitEffectsCondition.AddExcludeEffect(class'X2Effect_PersistentVoidConduit'.default.EffectName, 'AA_UnitIsBound');
		AbilityTemplate.AbilityTargetConditions.AddItem(UnitEffectsCondition);
	}

	// OPTC fix the playable aliens rewards

	foreach default.ALIEN_REWARDS(RewardName)
	{
		RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate(RewardName));

		if(RewardTemplate != none)
		{
			RewardTemplate.GiveRewardFn = GiveAlienReward_Fixed;
		}
	}
	
}

// Updated PA reward stuff
static function GiveAlienReward_Fixed(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
    local XComGameState_Unit    UnitState;

    class'X2StrategyElement_DefaultRewards'.static.GivePersonnelReward(NewGameState, RewardState, AuxRef, bOrder, OrderHours);

    UnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
    if (UnitState == none)
        UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', RewardState.RewardObjectReference.ObjectID));
    
    UnitState.bMissionProvided = false;
}