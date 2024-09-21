// This is an Unreal Script

class OPTC_BlackFlameGrenade extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
	local X2GrenadeTemplate					GrenadeTemplate;
	local X2ItemTemplateManager				ItemTemplateMgr;
	local X2Effect							Effect;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	local int idx;

	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	

	GrenadeTemplate = X2GrenadeTemplate(ItemTemplateMgr.FindItemTemplate('XCOM_BLACKFLAME_GRENADE'));

	// Replace with identical effects that don't use Assert statements
	if(GrenadeTemplate != none)
	{
		for(idx = GrenadeTemplate.ThrownGrenadeEffects.Length - 1; idx >= 0; idx--)
		{
			if(GrenadeTemplate.ThrownGrenadeEffects[idx].isa('X2Effect_PsiRipple'))
			{

				GrenadeTemplate.ThrownGrenadeEffects.Remove(idx,1);
				GrenadeTemplate.ThrownGrenadeEffects.InsertItem(idx, class'X2StatusEffects_RipplingRifle'.static.CreatePsiRippleStatusEffect(2, 0));

			}
		}
		
		for(idx = GrenadeTemplate.LaunchedGrenadeEffects.Length - 1; idx >= 0; idx--)
		{
			if(GrenadeTemplate.LaunchedGrenadeEffects[idx].isa('X2Effect_PsiRipple'))
			{

				GrenadeTemplate.LaunchedGrenadeEffects.Remove(idx,1);
				GrenadeTemplate.LaunchedGrenadeEffects.InsertItem(idx, class'X2StatusEffects_RipplingRifle'.static.CreatePsiRippleStatusEffect(2, 0));

			}
		}

	}

}