// This will allow the Laser and Mag Grenades to not destroy loot. This is configurable separately for each of them.

class OPTC_LaserAndMagGrenades extends X2DownloadableContentInfo config(Game);

var config bool LASERGRENADES_DESTROYLOOT;
var config bool MAGGRENADES_DESTROYLOOT;
 
static event OnPostTemplatesCreated()
{
    local X2ItemTemplateManager  ItemTemplateManager;
	local X2GrenadeTemplate                  Template;
	local X2Effect  TempEffect;                //placeholder for Effects
    local X2Effect_ApplyWeaponDamage  WeaponDamageEffect;        //required to manipulate applied damage
 
    //Karen!!  Get the Ability Template Manager.
    ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
 
    Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('MagGrenade'));
	if (Template != none)
	{
	        foreach Template.ThrownGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = default.MAGGRENADES_DESTROYLOOT;
                }
            }

            foreach Template.LaunchedGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = default.MAGGRENADES_DESTROYLOOT;
                }
            }
	}

	Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('LaserGrenade'));
	if (Template != none)
	{
	        foreach Template.ThrownGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = default.LASERGRENADES_DESTROYLOOT;
                }
            }

            foreach Template.LaunchedGrenadeEffects( TempEffect )
            {
                if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
                {
                    WeaponDamageEffect = X2Effect_ApplyWeaponDamage(TempEffect);
                    WeaponDamageEffect.bExplosiveDamage = default.LASERGRENADES_DESTROYLOOT;
                }
            }
	}

	Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('GasGrenade'));
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

	Template = X2GrenadeTemplate(ItemTemplateManager.FindItemTemplate('GasGrenadeMk2'));
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