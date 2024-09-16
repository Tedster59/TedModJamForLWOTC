class X2Item_Backburner extends X2Item config(DromeDome);

var config WeaponDamageValue FLAMETHROWER_BASEDAMAGE;
var config int FLAMETHROWER_ISOUNDRANGE;
var config int FLAMETHROWER_IENVIRONMENTDAMAGE;
var config int FLAMETHROWER_RANGE;
var config int FLAMETHROWER_RADIUS;
var config float FLAMETHROWER_TILE_COVERAGE_PERCENT;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

	if (class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('WelcometotheDromeDome') && class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PlayableXCOM2AliensLWOTC') && class'X2DownloadableContentInfo_TedModJamForLWOTC'.static.IsModActive('PurgePriests'))
	{
	Items.AddItem(CreatePABackBurner());
	}

	return Items;
}

static function X2DataTemplate CreatePABackBurner()
{
	local X2WeaponTemplate Template;
	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'PA_BackBurner_WPN');

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'PA_BackBurnerCat';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AndromedonRifle";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.GameArchetype = "DromeDome.Fire.WP_Andromedon_FlameAttack";
	
	Template.BaseDamage = default.FLAMETHROWER_BASEDAMAGE;
	Template.iSoundRange = default.FLAMETHROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.FLAMETHROWER_IENVIRONMENTDAMAGE;
	Template.iClipSize = 1;
	Template.iRange = default.FLAMETHROWER_RANGE;
	Template.iRadius = default.FLAMETHROWER_RADIUS;
	Template.fCoverage = default.FLAMETHROWER_TILE_COVERAGE_PERCENT;

	Template.Tier = 170;
	
	Template.InfiniteAmmo = true;
	Template.PointsToComplete = 0;
	Template.BaseDamage.DamageType = 'Fire';
	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_None;
	
	Template.bCanBeDodged = false;

	Template.Abilities.AddItem('DromeDome_BackBurner');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.FLAMETHROWER_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.FLAMETHROWER_RADIUS);

	Template.Requirements.RequiredSoldierClass = 'AndromedonClass';

	Template.CanBeBuilt = true;
	Template.TradingPostValue = 20;
	Template.bInfiniteItem = false;
	Template.StartingItem = false;

	return Template;
}