// This file contains AI overrides for every existing enemy that Mod Jam messes with. They are grouped by roster mod of origin.
// (Credit to RustyDios for writing this!)

class OPTC_ModJamAI extends X2DownloadableContentInfo;

static event OnPostTemplatesCreated()
{
    local X2CharacterTemplateManager        CharacterTemplateManager;

    //  Get the Character Template Manager.
    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    //  Access a specific Character template by name.

	// Advent Warlock (Sorcerer)
    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AshAdvWarlockM1'), "AdventSorcererModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AshAdvWarlockM2'), "AdventSorcererModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AshAdvWarlockM3'), "AdventSorcererModJamRoot");

	// Advent Psi Ops
    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdvWraithM1'), "AdventWraithModJam::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdvWraithM2'), "AdventWraithModJam::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdvWraithM3'), "AdventWraithModJam::CharacterRoot");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('AdvWraithM1'), "ScamperRoot_WraithModJam");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('AdvWraithM2'), "ScamperRoot_WraithModJam");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('AdvWraithM3'), "ScamperRoot_WraithModJam");

	// Frost Legion
    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostAdder_M1'),  "FrostAdderModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostAdder_M2'),  "FrostAdderModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostAdder_M3'),  "FrostAdderModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostCobra'), "FrostCobraModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostHardliner_M1'), "FrostHardlinerModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostHardliner_M2'), "FrostHardlinerModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostHardliner_M3'), "FrostHardlinerModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostHitman_M1'), "FrostHitmanModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostHitman_M2'), "FrostHitmanModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostHitman_M3'), "FrostHitmanModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBomber_M1'), "FrostBomberModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBomber_M2'), "FrostBomberModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBomber_M3'), "FrostBomberModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostNecromancer_M1'), "FrostNecromancerModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostNecromancer_M2'), "FrostNecromancerModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostNecromancer_M3'), "FrostNecromancerModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostSectoid_M2'), "FrostNecromancerModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostSectoid_M3'), "FrostNecromancerModJamRoot");

	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('FrostNecromancer_M1'), "ScamperRoot_FrostNecromancerModJam");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('FrostNecromancer_M2'), "ScamperRoot_FrostNecromancerModJam");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('FrostNecromancer_M3'), "ScamperRoot_FrostNecromancerModJam");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBruiser_M1'), "FrostBruiserModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBruiser_M2'), "FrostBruiserModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBruiser_M3'), "FrostBruiserModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostDroidShield_M2'), "FrostBruiserModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostDroidShield_M3'), "FrostBruiserModJamRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostSpectre_M2'), "FrostSpectreModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostSpectre_M3'), "FrostSpectreModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPriest_M1'), "FrostPriestModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPriest_M2'), "FrostPriestModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPriest_M3'), "FrostPriestModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPurifier_M1'), "FrostPurifierModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPurifier_M2'), "FrostPurifierModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPurifier_M3'), "FrostPurifierModJamRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostTech_M2'), "FrostTechModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostTech_M3'), "FrostTechModJamRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostCodex_M2'), "FrostCodexModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostCodex_M3'), "FrostCodexModJamRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostTrooper_M1'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostTrooper_M2'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostTrooper_M3'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostDroid_M1'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostDroid_M2'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostDroid_M3'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPuddingTrooper_M1'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPuddingTrooper_M2'), "AdventTrooper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPuddingTrooper_M3'), "AdventTrooper::CharacterRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostLancer_M1'), "AdventStunLancer::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostLancer_M2'), "AdventStunLancer::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostLancer_M3'), "AdventStunLancer::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPsiLancer_M1'), "AdventStunLancer::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPsiLancer_M2'), "AdventStunLancer::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPsiLancer_M3'), "AdventStunLancer::CharacterRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostChryssalidW_M1'), "Chryssalid::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostChryssalidW_M2'), "Chryssalid::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostChryssalidW_M3'), "Chryssalid::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostChryssalidB_M1'), "Chryssalid::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostChryssalidB_M2'), "Chryssalid::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostChryssalidB_M3'), "Chryssalid::CharacterRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostMuton_M2'), "Muton::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostMuton_M3'), "Muton::CharacterRoot");

    SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostMEC_M1'), "AdventMEC::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostMEC_M2'),  "AdvMECMk2_Root");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostMEC_M3'),  "AdvMECMk2_Root");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostViper_M2'), "Viper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostViper_M3'), "Viper::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostMamba'), "Viper::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostAndromedon'), "Andromedon::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBerserker_M2'), "Berserker::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostBerserker_M3'), "Berserker::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('MiniFrostKeeper'), "Gatekeeper::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostArchon'), "Archon::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostCaptain_M1'), "AdventCaptain::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostCaptain_M2'), "AdventCaptain::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostCaptain_M3'), "AdventCaptain::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPudding_M1'), "Faceless::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPudding_M2'), "Faceless::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostPudding_M3'), "Faceless::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('SpectralFrostZombie_M1'), "PsiZombie::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('SpectralFrostZombie_M2'), "PsiZombie::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('SpectralFrostZombie_M3'), "PsiZombie::CharacterRoot");

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostShadowbindUnit_M2'), "Shadowbind::CharacterRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('FrostShadowbindUnit_M3'), "Shadowbind::CharacterRoot");

	// Advent Assault Troopers

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AssaultTrooperT1'), "AssaultTrooperModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AssaultTrooperT2'), "AssaultTrooperModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AssaultTrooperT3'), "AssaultTrooperModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AssaultTrooperCaptn'), "AssaultTrooperCaptainModJamRoot");

	// Frost Codex

	GateBehindSkulljackingOfficer(CharacterTemplateManager.FindCharacterTemplate('FrostCodex_M2'));
	GateBehindSkulljackingOfficer(CharacterTemplateManager.FindCharacterTemplate('FrostCodex_M3'));

	// Advent Assault MECs

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('GatlingMec'), "GatlingMecModJamRoot");

	// Advent Pathfinder Hunters

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventPathfinderCaptain'), "AdventPathfinderCaptainModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventPathfinderCaptainT2'), "AdventPathfinderCaptainModJamRootT2");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventPathfinderCaptainT3'), "AdventPathfinderCaptainModJamRootT3");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventPathfinderCaptainT4'), "AdventPathfinderCaptainModJamRootT4");

	// Muton Harriers and Muton Harrier Captains

	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('Muton_Harrier'), "MutonHarrierMJRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('Muton_Harrier_Captain'), "MutonHarrierMJRoot");

	// Advent Sniper
	
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventSniperM1'), "AdventSniperModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventSniperM2'), "AdventSniperModJamRoot");
	SwapBehaviourTree(CharacterTemplateManager.FindCharacterTemplate('AdventSniperM3'), "AdventSniperModJamRoot");

	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('AdventSniperM1'), "ScamperRoot_Naja");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('AdventSniperM2'), "ScamperRoot_Naja");
	SwapScamperTree(CharacterTemplateManager.FindCharacterTemplate('AdventSniperM3'), "ScamperRoot_Naja");
}

static function SwapBehaviourTree (X2CharacterTemplate CharTemplate, string NewTree)
{
    if (CharTemplate != none)
    {
        //  Modify template as you wish. (in this case, change the AI to Mod Jam's version)
        CharTemplate.strBehaviorTree = NewTree;
		CharTemplate.ScamperActionPoints = 1;
    }
}

static function SwapScamperTree (X2CharacterTemplate CharTemplate, string NewScamper)
{
    if (CharTemplate != none)
    {
        //  Modify template as you wish. (in this case, change the scamper AI to Mod Jam's version)
        CharTemplate.strScamperBT = NewScamper;
    }
}

static function GateBehindSkulljackingOfficer (X2CharacterTemplate CharTemplate)
{
    if (CharTemplate != none)
    {
        //  Modify template as you wish. (in this case, gate the spawning of Frost Codex variants behind Skulljacking an Advent Officer, just like the regular Codex is)
		CharTemplate.SpawnRequirements.RequiredObjectives.AddItem('T1_M2_HackACaptain');
    }
}