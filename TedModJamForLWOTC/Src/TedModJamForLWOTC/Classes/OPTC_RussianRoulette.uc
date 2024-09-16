class OPTC_RussianRoulette extends X2DownloadableContentInfo config(Game);

var config bool PatchRussianRoulette;

static event OnPostTemplatesCreated()
{
    local X2AbilityTemplate         Template;
    local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2Effect_Persistent						RussianRouletteTargetEffect;
	local X2Condition_UnitEffectsWithAbilitySource	RussianRouletteTargetCondition;
	
	if (default.PatchRussianRoulette)
	{
    //  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

    //  Access a specific ability template by name.
    Template = AbilityTemplateManager.FindAbilityTemplate('OverwatchShot');

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish.

		RussianRouletteTargetEffect = new class'X2Effect_Persistent';
		RussianRouletteTargetEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
		RussianRouletteTargetEffect.EffectName = 'RussianRouletteTarget';
		RussianRouletteTargetEffect.bApplyOnMiss = true; //Only one chance, even if you miss (prevents making multiple attempts on one target)
		Template.AddTargetEffect(RussianRouletteTargetEffect);
    
		RussianRouletteTargetCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
		RussianRouletteTargetCondition.AddExcludeEffect('RussianRouletteTarget', 'AA_DuplicateEffectIgnored');
		Template.AbilityTargetConditions.AddItem(RussianRouletteTargetCondition);
    }

	}
}