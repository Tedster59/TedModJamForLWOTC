// The original mod apparently has some mystery bug in it causing the armor to permanently debuff a soldier's Will if removed
// Easiest way (for me) to resolve this is to remove anything to do with Will interactions, i.e. just axe the Will bonus, which I'll do by making brand new templates

class X2Item_PsiArmor_LW extends X2Item config(PsiArmorLW);

    var config int PSI_SUIT_HP_BONUS;
	var config int PSI_SUIT_ARMOR_BONUS;
	var config int PSI_SUIT_MOBILITY_BONUS;
	var config int PSI_SUIT_DEFENSE_BONUS;
	var config int PSI_SUIT_PSIOFFENSE_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Armors;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('EUPsiArmor'))
    {
    Armors.AddItem(CreateCX_PsiArmor_LW());
	}

	 return Armors;    
}


static function X2DataTemplate CreateCX_PsiArmor_LW()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'CX_PsiArmor_LW');
	Template.strImage = "img:///PsiArmor.UILib.INV_PsiArmor";
	Template.ItemCat = 'armor';
	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.PointsToComplete = 0;
	Template.Abilities.AddItem('PsiArmorBonusStats_LW');
	Template.ArmorTechCat = 'powered';
	Template.ArmorClass = 'light';
	Template.Tier = 4;
	Template.AkAudioSoldierArmorSwitch = 'Wraith';
	Template.EquipSound = "StrategyUI_Armor_Equip_Powered";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, class'X2Ability_PsiArmor_LW'.default.PSI_SUIT_HP_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_PsiArmor_LW'.default.PSI_SUIT_ARMOR_BONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_PsiArmor_LW'.default.PSI_SUIT_MOBILITY_BONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DefenseLabel, eStat_Defense, class'X2Ability_PsiArmor_LW'.default.PSI_SUIT_DEFENSE_BONUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_PsiArmor_LW'.default.PSI_SUIT_PSIOFFENSE_BONUS);
	return Template;
}