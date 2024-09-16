// This will make flamethrower type weapons like Immolators and Incinerators destroy loot with killing blows dealt by direct attacks.
// Death by a Burning DoT effect should still NOT destroy loot. If they do, let me know.

class OPTC_FlamethrowerAbilities extends X2DownloadableContentInfo config(Game);

var config bool IMMOLATOR_DESTROYSLOOT;
 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager  AbilityTemplateManager;
 
    //Karen!!  Get the Ability Template Manager.
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
 
    AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireSparkFlamethrower'));
	`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('IRI_FireSparkFlamethrowerOverwatch'));
	`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireThrower'));
	`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireThrowerOverwatchShot'));
	`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZFireCanisterActivate'));
	`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFlamethrowerAbility(AbilityTemplateManager.FindAbilityTemplate('MZBlastCanisterActivate'));
	`LOG("a flamethrower single effect was searched",,'flame_ability');
	AdjustFrostBlobAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDAndromedonFrostBlob'));
	AdjustFrostBlobAbility(AbilityTemplateManager.FindAbilityTemplate('MZ_FDFrostPurifierDeathExplosion'));
}
 
static function AdjustFlamethrowerAbility(X2AbilityTemplate Template)
{
    local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
    local X2Effect                          TempEffect;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //single target effects
        foreach Template.AbilityTargetEffects( TempEffect )
        {
            if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
            {
                WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                WeaponDamageEffect.bExplosiveDamage = default.IMMOLATOR_DESTROYSLOOT;
                `LOG("a flamethrower single effect was adjusted",,'flame_loot');
            }
        }
    
        //multitarget effects
        foreach Template.AbilityMultiTargetEffects( TempEffect )
        {
            if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
            {
                WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                WeaponDamageEffect.bExplosiveDamage = default.IMMOLATOR_DESTROYSLOOT;
                `LOG("a flamethrower multi effect was adjusted",,'flame_loot');
            }
        }
    }
}

static function AdjustFrostBlobAbility(X2AbilityTemplate Template)
{
    local X2Effect_ApplyWeaponDamage        WeaponEffect;
    local X2Effect                          TempEffect;

    //  Check if the Ability Template was successfully found by the manager.
    if (Template != none)
    {
        //single target effects
        foreach Template.AbilityTargetEffects( TempEffect )
        {
            if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
            {
                WeaponEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                WeaponEffect.bExplosiveDamage = false;
            }
        }
    
        //multitarget effects
        foreach Template.AbilityMultiTargetEffects( TempEffect )
        {
            if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
            {
                WeaponEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                WeaponEffect.bExplosiveDamage = false;
            }
        }
    }
}

