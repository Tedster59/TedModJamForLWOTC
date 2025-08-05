// This script file is a testament to how badly underutilized cryo weapons are in normal MJ, these smash loot, which isnt suppose to be a thing of cryo weapons

class OPTC_BitterfrostAntiLootSmash extends X2DownloadableContentInfo;
static event OnPostTemplatesCreated()
{
    local X2ItemTemplateManager  ItemTemplateManager;
	local X2GrenadeTemplate                  Template;
	local X2Effect  TempEffect;                //placeholder for Effects
    local X2Effect_ApplyWeaponDamage  WeaponDamageEffect;        //required to manipulate applied damage
 
    //I have no idea how any of this works, i am just reverse engineering what Kiruka did
    ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
 
    Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('MZBitterFrostGrenade'));
	if (Template != none)
	{
	        foreach Template.ThrownGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }

            foreach Template.LaunchedGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }

		Template.HideIfResearched = '';
	}

	Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('MZBitterFrostBomb'));
	if (Template != none)
	{
	        foreach Template.ThrownGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }

            foreach Template.LaunchedGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }
	}

	Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('MZCryoLauncher'));
	if (Template != none)
	{
	        foreach Template.ThrownGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }

            foreach Template.LaunchedGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }
	}

	Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('MZCryoLauncherMk2'));
	if (Template != none)
	{
	        foreach Template.ThrownGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }

            foreach Template.LaunchedGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = false;
                }
            }
	}
}