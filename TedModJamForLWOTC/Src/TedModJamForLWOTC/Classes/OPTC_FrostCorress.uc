// This is an attempt to not allow Frost Necromancers to use Frost Corress while burning or disoriented
// Includes some other abilities from Frost Legion

class OPTC_FrostCorress extends X2DownloadableContentInfo;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M1'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M2'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M3'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDReanimateFrostZombie_M1'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDReanimateFrostZombie_M1'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDReanimateFrostZombie_M1'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('AcidBlob'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDAndromedonFrostBlob'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('BioShieldBash'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('AdvBioShieldDeflect'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostAxeSlash'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('Avenger_LW'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('CommandoEnergyShield'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('CommandoEnergyShieldMk2'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('CommandoEnergyShieldMk3'));
	AdjustFrostCorressAbility(AbilityTemplateManager.FindAbilityTemplate('DP_PistolWhip'));
	NotWhileBurningAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDSpectreShot'));
	NotWhileBurningAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDSpectreOverwatchShot'));
	NotWhileBurningAbility(AbilityTemplateManager.FindAbilityTemplate('MZIceThrower'));
	NotWhileBurningAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireThrower'));
	AdjustFrostCorressAbilityActions(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M1'));
	AdjustFrostCorressAbilityActions(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M2'));

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModInactive('PlayableXCOM2AliensLWOTC'))
    {
		AdjustFrostCorressAbilityActions(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M3'));
	}

	AdjustFrostPurifierDeathExplosion(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostPurifierDeathExplosion'));

	//AdjustFrostCorressAbilityGlobalCooldown(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M1'));
	//AdjustFrostCorressAbilityGlobalCooldown(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M2'));
	//AdjustFrostCorressAbilityGlobalCooldown(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostCorress_M3'));
}

static function AdjustFrostPurifierDeathExplosion(X2AbilityTemplate Template)
{
	local X2Effect TargetEffect;
	local X2Effect_ApplyWeaponDamage DamageEffect;

	if (Template != none)
	{
		foreach Template.AbilityMultiTargetEffects (TargetEffect)
		{
			DamageEffect = X2Effect_ApplyWeaponDamage(TargetEffect);
			if(DamageEffect != None)
			{
				DamageEffect.bExplosiveDamage = false;
			}
		}
	}
}
 
static function NotWhileBurningAbility(X2AbilityTemplate Template)
{
	local X2Condition_UnitEffects UnitEffects;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
        //  Remove the exclusions that let Frost Necromancers uses these abilities while burning or disoriented
		UnitEffects = new class'X2Condition_UnitEffects';
		UnitEffects.AddExcludeEffect(class'X2StatusEffects'.default.BurningName, 'AA_UnitIsBurning');
		UnitEffects.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_CarryingUnit');
		UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BoundName, 'AA_UnitIsBound');            
		UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.ConfusedName, 'AA_UnitIsConfused');
		UnitEffects.AddExcludeEffect(class'X2Effect_PersistentVoidConduit'.default.EffectName, 'AA_UnitIsBound');
		UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_UnitIsStunned');
		UnitEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DazedName, 'AA_UnitIsStunned');
		UnitEffects.AddExcludeEffect('Freeze', 'AA_UnitIsFrozen');

		Template.AbilityShooterConditions.AddItem(UnitEffects);
    }
}

static function AdjustFrostCorressAbility(X2AbilityTemplate Template)
{
    local X2Condition_UnitEffects UnitEffect;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {

		UnitEffect = new class'X2Condition_UnitEffects';
		UnitEffect.AddExcludeEffect(class'X2StatusEffects'.default.BurningName, 'AA_UnitIsBurning');
		UnitEffect.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName, 'AA_UnitIsDisoriented');

		Template.AbilityShooterConditions.AddItem(UnitEffect);
	}
}

static function AdjustFrostCorressAbilityActions(X2AbilityTemplate Template)
{
	local X2AbilityCost_ActionPoints ActionPointCost;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //  Modify template as you wish. 
		ActionPointCost = new class'X2AbilityCost_ActionPoints';
		ActionPointCost.iNumPoints = 2;
		ActionPointCost.bConsumeAllPoints = true;
		Template.AbilityCosts.AddItem(ActionPointCost);
    }
}

//static function AdjustFrostCorressAbilityGlobalCooldown(X2AbilityTemplate Template)
//{
//	local X2AbilityCooldown_Global          GlobalCooldown;

    //  Check if the Ability Template was successfully found by the manager.
 //   if (Template != none)
 //   {
        //  Modify template as you wish. 
		// Add a 1 turn global cooldown to Frost Corress
	//	GlobalCooldown = new class'X2AbilityCooldown_Global';
	//	GlobalCooldown.iNumTurns = 1;
	//	Template.AbilityCooldown = GlobalCooldown;
	//	Template.AdditionalAbilities.AddItem('RemoveSpectralZombies');
    //}
//}