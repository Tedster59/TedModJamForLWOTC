class X2Ability_ShadowOpsCharge extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	Templates.AddItem(ChargeM2());
	Templates.AddItem(ChargeM3());
	Templates.AddItem(ChargeM4());

	return Templates;
}

static function X2AbilityTemplate ChargeM2()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCharges                  Charges;
	local X2AbilityCost_Charges             ChargesCost;
	local X2AbilityCooldown                     Cooldown;

	Template = class'X2Ability_RangerAbilitySet'.static.RunAndGunAbility('ShadowOps_Charge_M2');

	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = 2;
	Template.AbilityCharges = Charges;

	ChargesCost = new class'X2AbilityCost_Charges';
	ChargesCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargesCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 2;
	Template.AbilityCooldown = Cooldown;

	return Template;
}

static function X2AbilityTemplate ChargeM3()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCharges                  Charges;
	local X2AbilityCost_Charges             ChargesCost;
	local X2AbilityCooldown                     Cooldown;

	Template = class'X2Ability_RangerAbilitySet'.static.RunAndGunAbility('ShadowOps_Charge_M3');

	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = 3;
	Template.AbilityCharges = Charges;

	ChargesCost = new class'X2AbilityCost_Charges';
	ChargesCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargesCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 3;
	Template.AbilityCooldown = Cooldown;

	return Template;
}

static function X2AbilityTemplate ChargeM4()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCharges                  Charges;
	local X2AbilityCost_Charges             ChargesCost;
	local X2AbilityCooldown                     Cooldown;

	Template = class'X2Ability_RangerAbilitySet'.static.RunAndGunAbility('ShadowOps_Charge_M4');

	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = 4;
	Template.AbilityCharges = Charges;

	ChargesCost = new class'X2AbilityCost_Charges';
	ChargesCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargesCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 4;
	Template.AbilityCooldown = Cooldown;

	return Template;
}

// Added to StandardShot in OnPostTemplatesCreated()
static function X2Effect_PersistentStatChange BotnetEffect()
{
	local X2Effect_PersistentStatChange		Effect;
	local X2Condition_UnitEffectsOnSource   Condition;
	local X2Condition_UnitProperty          Condition_UnitProperty;

    // Only on robots
	Condition_UnitProperty = new class'X2Condition_UnitProperty';
	Condition_UnitProperty.ExcludeOrganic = true;
	Condition_UnitProperty.TreatMindControlledSquadmateAsHostile = true;
    
    // Effect that reduces hack defense
	Effect = class'X2StatusEffects'.static.CreateHackDefenseChangeStatusEffect(-10, Condition_UnitProperty);

    // Only apply if shooter has the required Botnet effect
	Condition = new class'X2Condition_UnitEffectsOnSource';
	Condition.AddRequireEffect('F_Botnet_Valid', 'AA_MissingRequiredEffect');
	Effect.TargetConditions.AddItem(Condition);

	return Effect;
}