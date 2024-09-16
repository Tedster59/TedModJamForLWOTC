class X2Ability_FlashbangResistance extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(FlashRes20());
	Templates.AddItem(FlashRes25());
	Templates.AddItem(FlashRes33());
	Templates.AddItem(FlashRes50());
	Templates.AddItem(FlashRes67());
	Templates.AddItem(FlashRes75());
	Templates.AddItem(FlashRes100());
	
	return Templates;
}

static function X2AbilityTemplate FlashRes20()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate FlashRes25()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate FlashRes33()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate FlashRes50()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate FlashRes67()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate FlashRes75()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate FlashRes100()
{

	local X2AbilityTemplate				Template;

	Template = PurePassive('FlashRes20', "img:///KetarosPkg_Abilities.UIPerk_3dglasses",, 'eAbilitySource_Perk');

	return Template;
}