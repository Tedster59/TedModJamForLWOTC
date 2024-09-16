// This will add a free Hacker's Laptop to the Resistance Communications research (upon completion)
// Didn't work with LW_Overhaul config for some reason

class OPTC_ResistanceCommunications extends X2DownloadableContentInfo config(HackerLaptop);

var config name ResistanceCommunicationsTech;

static event OnPostTemplatesCreated()
{
    local X2StrategyElementTemplateManager  TechMgr;
    local X2TechTemplate                    Template;
    local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                    DifficultyVariant;

    TechMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();

    TechMgr.FindDataTemplateAllDifficulties(default.ResistanceCommunicationsTech, DifficultyVariants);

    foreach DifficultyVariants(DifficultyVariant)
    {
        Template = X2TechTemplate(DifficultyVariant);
        if (Template != none)
        {
            Template.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
			Template.ItemRewards.AddItem('IRI_HackerLaptop');
        }
    }
}