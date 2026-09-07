class XMBAbility_XMBStuff extends XMBAbility;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(MagneticKineticDrivers());

	return Templates;
}

static function X2AbilityTemplate MagneticKineticDrivers()
{
	local XMBEffect_ConditionalBonus Effect;

	Effect = new class'XMBEffect_ConditionalBonus';
	Effect.AddDamageModifier(5);
	Effect.AbilityTargetConditions.AddItem(default.MeleeCondition);

	Effect.ScaleBase = 1;

	// TODO: icon
	return Passive('MagneticKineticDrivers', "img:///KetarosPkg_Abilities.UIPerk_knuckles", true, Effect);
}
