class X2Item_NeurotoxinGrenades extends X2Item_DefaultGrenades;

//var config WeaponDamageValue GASGRENADEM1_BASEDAMAGE;
//var config WeaponDamageValue GASGRENADEM2_BASEDAMAGE;

//var config int GASGRENADE_ISOUNDRANGE;
//var config int GASGRENADE_IENVIRONMENTDAMAGE;
//var config int GASGRENADE_ISUPPLIES;
//var config int GASGRENADE_TRADINGPOSTVALUE;
//var config int GASGRENADE_IPOINTS;
//var config int GASGRENADE_ICLIPSIZE;
//var config int GASGRENADE_RANGE;
var config(BDData) int NEUROTOXINGRENADE_RADIUS;
//var config int GASBOMB_RANGE;
var config(BDData) int NEUROTOXINBOMB_RADIUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Grenades;

    if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('BioDivision'))
    {
	Grenades.AddItem(CreateNeurotoxinGrenade());
	Grenades.AddItem(CreateNeurotoxinGrenadeMk2());
	}

	return Grenades;
}

static function X2DataTemplate CreateNeurotoxinGrenade()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_ApplyPoisonToWorld WeaponEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'NeurotoxinGrenade');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Gas_Grenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_gas");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_gas");
	Template.iRange = default.GASGRENADE_RANGE;
	Template.iRadius = default.NEUROTOXINGRENADE_RADIUS;

	Template.BaseDamage = default.GASGRENADEM1_BASEDAMAGE;
	Template.iSoundRange = default.GASGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.GASGRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.GASGRENADE_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.GASGRENADE_IPOINTS;
	Template.iClipSize = default.GASGRENADE_ICLIPSIZE;
	Template.Tier = 1;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');
	
	WeaponEffect = new class'X2Effect_ApplyPoisonToWorld';	
	Template.ThrownGrenadeEffects.AddItem(WeaponEffect);
	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());
	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false));
	// immediate damage
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = false;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);

	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;
	
	Template.GameArchetype = "WP_Grenade_Gas.WP_Grenade_Gas";

	Template.CanBeBuilt = false;
	
	//Template.RewardDecks.AddItem('ExperimentalGrenadeRewards');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.GASGRENADE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.NEUROTOXINGRENADE_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.GASGRENADEM1_BASEDAMAGE.Shred);

	return Template;
}

static function X2DataTemplate CreateNeurotoxinGrenadeMk2()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyPoisonToWorld WeaponEffect;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'NeurotoxinGrenadeMk2');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Gas_GrenadeMK2";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_gas");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_gas");
	Template.iRange = default.GASBOMB_RANGE;
	Template.iRadius = default.NEUROTOXINBOMB_RADIUS;

	Template.BaseDamage = default.GASGRENADEM2_BASEDAMAGE;
	Template.iSoundRange = default.GASGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.GASGRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.GASGRENADE_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.GASGRENADE_IPOINTS;
	Template.iClipSize = default.GASGRENADE_ICLIPSIZE;
	Template.Tier = 2;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');
	
	WeaponEffect = new class'X2Effect_ApplyPoisonToWorld';
	Template.ThrownGrenadeEffects.AddItem(WeaponEffect);
	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());
	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false));
	// immediate damage
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = false;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);

	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;

	Template.GameArchetype = "WP_Grenade_Gas.WP_Grenade_Gas_Lv2";

	Template.CanBeBuilt = false;
	
	//Template.CreatorTemplateName = 'AdvancedGrenades'; // The schematic which creates this item
	//Template.BaseItem = 'GasGrenade'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.GASBOMB_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.NEUROTOXINBOMB_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.GASGRENADEM2_BASEDAMAGE.Shred);

	return Template;
}