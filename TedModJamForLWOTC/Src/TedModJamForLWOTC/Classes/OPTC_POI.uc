class OPTC_POI extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2StrategyElementTemplateManager  StrategyElementTemplateManager;
 
    //Karen!!  Get the Strategy Element Template Manager.
    StrategyElementTemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
 
    ModifyMJPOI(StrategyElementTemplateManager.FindStrategyElementTemplate('POI_FD_ShrikeGear'));
	DisableDarkEvent(StrategyElementTemplateManager.FindStrategyElementTemplate('DarkEvent_F_SniperElite'));
}

function bool DisablePOI(XComGameState_PointOfInterest POIState)
{
	return false;
}
 
static function ModifyMJPOI(X2StrategyElementTemplate Template)
{
	local X2PointOfInterestTemplate POITemplate;

	POITemplate = X2PointofInterestTemplate(Template);
	if (POITemplate != none)
    {
        //  Modify template as you wish. 
		POITemplate.CanAppearFn = DisablePOI;
    }
}

static function DisableDarkEvent(X2StrategyElementTemplate Template)
{
	local X2DarkEventTemplate DETemplate;

	DETemplate = X2DarkEventTemplate(Template);

	if(DETemplate != none)
	{
		DETemplate.CanActivateFn = DisablePOI;
	}
}