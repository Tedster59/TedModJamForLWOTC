// This is an Unreal Script

class OPTC_Rockets extends X2DownloadableContentInfo config(Rockets);

var config array<name> GuaranteedHitAbilities;
var config bool bDirectFireGuaranteedHit;

static event OnPostTemplatesCreated()
{

	local X2AbilityTemplateManager			AbilityManager;
	local X2AbilityTemplate					Template;
	local name								TemplateName;
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local X2GrenadeTemplate					GrenadeTemplate;
	local X2ItemTemplateManager				ItemTemplateMgr;
	local X2Effect							Effect;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	local X2Effect_Persistent				PersistentEffect;
	local array<X2DataTemplate> DataTemplateAllDifficulties;
	local X2DataTemplate DataTemplate;

	// Patch direct fire abilities
	AbilityManager = class'x2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	foreach default.GuaranteedHitAbilities(TemplateName)
	{
		Template = AbilityManager.FindAbilityTemplate(TemplateName);

		if (Template == none)
		{
			continue;
		}

		StandardAim = X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc);

		if (StandardAim != none)
		{
			
			if(default.bDirectFireGuaranteedHit)
			{
				X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc).bGuaranteedHit = true;
			}
			X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc).bIndirectFire = false;

		}
	}

	// Patch Flechette rockets

	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	// T3 one
	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateMgr.FindItemTemplate('IRI_X2Rocket_Flechette'));

	if(GrenadeTemplate != none)
	{
		foreach GrenadeTemplate.ThrownGrenadeEffects (Effect)
		{
			WeaponDamageEffect = X2Effect_ApplyWeaponDamage(Effect);

			if(WeaponDamageEffect != none)
			{
				WeaponDamageEffect.bExplosiveDamage = false;
			}
		}
	}

	// T3 one
	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateMgr.FindItemTemplate('IRI_X2Rocket_Flechette_T3'));

	if(GrenadeTemplate != none)
	{
		foreach GrenadeTemplate.ThrownGrenadeEffects (Effect)
		{
			WeaponDamageEffect = X2Effect_ApplyWeaponDamage(Effect);
			if(WeaponDamageEffect != none)
			{
				WeaponDamageEffect.bExplosiveDamage = false;
			}
		}
	}

	// Shredder rockets don't stack

	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateMgr.FindItemTemplate('IRI_X2Rocket_Shredder'));

	if(GrenadeTemplate != none)
	{
		foreach GrenadeTemplate.ThrownGrenadeEffects (Effect)
		{
			PersistentEffect = X2Effect_Persistent(Effect);
			if(PersistentEffect != none && PersistentEffect.IsA('X2Effect_IRI_Shredded'))
			{
				PersistentEffect.DuplicateResponse = eDupe_Ignore;
			}
		}
	}



	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateMgr.FindItemTemplate('IRI_X2Rocket_Shredder_T3'));

	if(GrenadeTemplate != none)
	{
		foreach GrenadeTemplate.ThrownGrenadeEffects (Effect)
		{
			PersistentEffect = X2Effect_Persistent(Effect);
			if(PersistentEffect != none && PersistentEffect.IsA('X2Effect_IRI_Shredded'))
			{
				PersistentEffect.DuplicateResponse = eDupe_Ignore;
			}
		}
	}

}