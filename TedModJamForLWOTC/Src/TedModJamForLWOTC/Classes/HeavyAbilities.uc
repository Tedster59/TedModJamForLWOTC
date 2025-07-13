class HeavyAbilities extends X2ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(Sunomata());
	Templates.AddItem(BlastOff());

	return Templates;
}

static function X2AbilityTemplate Sunomata()
{
	local X2AbilityTemplate             Template;
	local X2Effect_PersistentStatChange			StatEffect;

	Template = PurePassive('Sunomata',  "img:///KetarosPkg_Abilities.UIPerk_palace", , 'eAbilitySource_Perk');
	Template.AdditionalAbilities.AddItem('Entrench');

	StatEffect = new class'X2Effect_PersistentStatChange';
	StatEffect.AddPersistentStatChange(eStat_ArmorMitigation, 1);
	StatEffect.AddPersistentStatChange(eStat_ArmorChance, 100);
	StatEffect.BuildPersistentEffect(1, true, false, false);
	Template.AddTargetEffect(StatEffect);

	return Template;
}

static function X2AbilityTemplate BlastOff()
{
	local X2AbilityTemplate             Template;

	Template = PurePassive('BlastOff',  "img:///KetarosPkg_Abilities.UIPerk_explosion", , 'eAbilitySource_Perk');

	return Template;
}