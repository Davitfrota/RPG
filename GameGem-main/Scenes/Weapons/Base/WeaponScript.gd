extends Resource
class_name Weapon

signal killCountReached(value)

enum WeaponTypes {MELEE, RANGED};
enum MeleeTypes {NULL, SWORD, AXE, HAMMER, CLUB};
enum RangedTypes {NULL, STAFF, BOW};
enum StaffEnergyType {NULL, FIRE, ICE, GRASS};


#Principal
export(float) var scaleX = 1;
export(float) var scaleY = 1;
export(String) var name = null;
export(int) var weaponId = null;
export(WeaponTypes) var weaponType = null;
export(MeleeTypes) var meleeType = null;
export(RangedTypes) var rangedType = null;
export(StaffEnergyType) var staffEnergyType = null;
export(Texture) var texture = null;
export(AudioEffect) var hitSound = null;
export(Resource) var projectile = null;
export(bool) var isInEnemy = false;


#Damage & Projectil
export(int) var damage = 1;
export(int) var manaUsage = 0;
export(int) var staminaUsage = 0;
export(float) var attackSpeed = 1;
var killCount = 0;


func incrementKillCount(value):
	if(!isInEnemy):
		killCount += value;
		PlayerStats.setPlayerKillCount(killCount);
#	print("Incremented in " + str(value));
#	print("Current kill count = " + str(killCount));

func setKillCount(value):
	if(!isInEnemy):
		killCount = value;
		print("killCount = " + str(killCount));















