class X2Ability_ReaperHack extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(WOTC_APA_ReaperHack());

	return Templates;
}

static function X2AbilityTemplate WOTC_APA_ReaperHack()
{

	local X2AbilityTemplate										Template;
	local X2Condition_WOTC_APA_ReaperHack						HackCondition;


	Template = class'X2Ability_DefaultAbilitySet'.static.AddHackAbility('WOTC_APA_ReaperHack');


	// Remove existing ability target conditions
	Template.AbilityTargetConditions.Length = 0;

	// Define new hack targeting condition allowing Reaper to hack Advent towers when adjacent
	HackCondition = new class'X2Condition_WOTC_APA_ReaperHack';
	Template.AbilityTargetConditions.AddItem(HackCondition);


	return Template;
}