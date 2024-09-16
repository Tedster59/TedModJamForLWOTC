class X2Condition_HasPurchasedTechUnlock_BU extends X2Condition;

var array<name> TemplateNames;
var name TechTemplatesThatUnlocks;

function bool CanEverBeValid(XComGameState_Unit SourceUnit, bool bStrategyCheck)
{

    //source unit exists
    if (SourceUnit != none)
    {
        //and we care about this unit type having this ability
        if (TemplateNames.Find(SourceUnit.GetMyTemplate().DataName) != INDEX_NONE)
        {
            if (`XCOMHQ.IsTechResearched(TechTemplatesThatUnlocks))
            {
                //xcom has the tech
                return true;
            }
            else
            {
                //xcom does not have the tech
                return false;
            }
        }
        else
        {
            // Not a unit type we care about
            //return true just so we don't lock the ability for other unit types!
            return true;
        }
    }
    else
    {
        // Not a unit - shouldn't ever be possible, but better be safe.
        return false; 
    }
}