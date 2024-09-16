class OPTC_SystemInfiltration extends X2DownloadableContentInfo config(AbilityConfigsOPTC);

var config int SI_CHARGES;
var config bool ENABLE_SI_CHARGES;

static event OnPostTemplatesCreated ()
{
	local X2AbilityTemplateManager AbilityTemplateManager;
	local X2AbilityTemplate AbilityTemplate;
	local X2AbilityCharges Charges;
	local X2AbilityCost_Charges ChargeCost;


	if(default.ENABLE_SI_CHARGES){
	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('SI_SystemInfiltration');

	if (AbilityTemplate != none)
	{
		Charges = new class 'X2AbilityCharges';
		Charges.InitialCharges = default.SI_CHARGES;
		AbilityTemplate.AbilityCharges = Charges;

		ChargeCost = new class'X2AbilityCost_Charges';
		ChargeCost.NumCharges = 1;
		AbilityTemplate.AbilityCosts.AddItem(ChargeCost);
		//adding this so that the ability should always show
		AbilityTemplate.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
		

	}
}

}

