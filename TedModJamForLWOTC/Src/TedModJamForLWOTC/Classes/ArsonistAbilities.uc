class ArsonistAbilities extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(ArsonistHotshot());

	return Templates;
}

static function X2AbilityTemplate ArsonistHotshot()
{

	local X2AbilityTemplate										Template;

	Template = PurePassive('ArsonistHotshot', "img:///KetarosPkg_Abilities.UIPerk_flamethrower",, 'eAbilitySource_Perk');
	Template.AdditionalAbilities.AddItem('Quickburn');
	Template.AdditionalAbilities.AddItem('MZFineControl');

		return Template;
}