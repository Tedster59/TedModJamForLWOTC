// Kiruka's note: I've added a check to ensure the rockets changes don't happen if the user doesn't have Iridar's Rocket Launchers mod.
// The other features only depend on features from LWOTC itself, and are fine to leave as is.
// All notes in this file below this one are from Knight of NSFW, and I'm not proofreading them.

class ImprovedHeavyTargetingLWOTC extends X2DownloadableContentInfo config(ImprovedHeavyTargeting);
var config bool PATCH_LWOTC_ROCKET;
var config bool PATCH_MZ_CHEMTHROWERTARGETING;
var config bool PATCH_MZ_OWTARGETING;
var config bool PATCH_MZ_CANISTERTARGETING;
var config bool PATCH_SPARKARSENAL;
delegate ModifyTemplate(X2DataTemplate DataTemplate);

//Addition of Phosphorus doesn´t seem to work as those point to the secondary slot - this is the primary. I tested adding it to the weapon itself and it does not work unlike Burnout. 
	//Granting MZCorrodingCompounds  via Ability Editor to the primary with Phosphorys would be a decent substitute too. 
	//That said, primary chemthrowers will benefit from Shredder already! so up to you. 
//NapalmX I could not code properly as it gave errors, but it might be easier if it´s set up via Ability Editor to just grant MZNightmareFuel
		//Chemthrower suppression triggers the smoke on firing the ability. KillZone does so on the reaction shots. 
//All those would be subject to being able to specify the slot to primary for theextra ability via Ability Editor. 
//None should have an effect unless a Chemthrower is equipped though. 
//Fire and Steel *could* work - it seems to straight up buff whatever item it points to and its DOT. 
//Flush works out of the box for Chemthrowers but does not trigger Burnout - I have commented out
//Could also do the same for Suppression/Chemthrower Supression (that way it actually could be worth picking in Technicals)
//By default Iridar´s Spark Flamers, but not UBF, works with Chemthrower perks. UBFs could be added but I didn´t see the point - Iridar didn´t add Chemthrower stuff in his either. 
//Incinerator can´t be added without changing the cone formula, which would invalidate the attachments. 
static event OnPostTemplatesCreated()
{
    local X2AbilityTemplateManager				AbilityTemplateManager;
    local X2AbilityTemplate						AbilityTemplate;
	local X2AbilityTemplate                     AbilityTemplate2;
    AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	//#######	LWOTC ROCKET TARGETING USES IRIDAR´S RL2.0	########
	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WOTCRocketLaunchers'))
    {
		if(default.PATCH_LWOTC_ROCKET)
		{
			AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('ConcussionRocket');
			AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket'); // Or w/e its name is
			if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
			{
				AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			}
			AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('BunkerBuster');
			AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket'); // Or w/e its name is
			if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
			{
				AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			}
			AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('LWRocketLauncher');
			AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('IRI_FireRocket'); // Or w/e its name is
			if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
			{
				AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			}
		}
	}
	//#######	MITZRUTI INCINERATORS USE LWOTC FLAMER TARGETING AND TRIGGER BURNOUT, IF OFFENSIVE	########
	if(default.PATCH_MZ_CHEMTHROWERTARGETING)
	{
		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZFireThrower');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
				 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
				 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		}
		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZChemstormFire');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
				 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
				 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		}

		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZFulmination');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
				 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
				 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		}

		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZPressureBlast');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
				 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
				 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		}
			AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZFumigate');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
		}
			AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZMedispray');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
		}
		}
//#######	MITZRUTI CHEMTHROWER SUPPRESSION AND KILLZONE USE LWOTC FLAMER TARGETING AND TRIGGER BURNOUT	########
		if(default.PATCH_MZ_OWTARGETING)
		{
		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZChemthrowerSuppression');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
				 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
				 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		}
		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZChemthrowerKillZoneShot');
		AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
		 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
				 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
				 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
	 	}
	}
	//#######	MITZRUTI CANISTERS USE LWOTC FLAMER TARGETING AND TRIGGER BURNOUT	########
	if(default.PATCH_MZ_CANISTERTARGETING)
	{
	    AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZFireCanisterActivate');
     	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
			 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		 }
		     AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZBlastCanisterActivate');
     	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
			 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		 }
		     AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZPoisonCanisterActivate');
     	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
			 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		 }
		     AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZAcidCanisterActivate');
     	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
			 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		 }
		     AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZSmokeCanisterActivate');
     	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
			 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		 }
		 	     AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('MZBluescreenCanisterActivate');
     	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
		 }
	}
	if(default.PATCH_SPARKARSENAL)
	{
	    AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('IRI_FireSparkFlamethrower');
      	AbilityTemplate2 = AbilityTemplateManager.FindAbilityTemplate('LWFlamethrower');
			 if ((AbilityTemplate != none) && (AbilityTemplate2 != none))
		{
				 AbilityTemplate.TargetingMethod = AbilityTemplate2.TargetingMethod;
			 AbilityTemplate.AdditionalAbilities.AddItem('Phosphorus');
			 AbilityTemplate.PostActivationEvents.AddItem('FlamethrowerActivated');
		 }
	}
}