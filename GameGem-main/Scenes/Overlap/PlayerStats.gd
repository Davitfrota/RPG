extends "res://Scenes/Overlap/Stats.gd"

onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")
onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
onready var necromancerClass = preload("res://Scenes/Player/Classes/Necromancer.tres")

onready var taverna = get_node("res://Scenes/Maps/Main/Traverna.gd") 

var isMage = false;
var isWarrior = false;
var isNecromancer = false;

var currentWeapon = null;
var currentWeaponId = 1;
var playerKillCount;

var PLAYERMAXHEALTH = null;
var PLAYERMAXMANA = null;
var PLAYERMAXSTAMINA = null;
var PLAYERSPEEDBONUS = null;
var PLAYERSPELLCOSTMULTIPLIER = 1;


export(Resource) var playerClass = null

func changeToWarrior():
	print("SETTED TO WARRIOR")
	isWarrior = true;
	pass

func changeToMage():
	print("SETTED TO MAGE")
	isMage = true;
	pass

func changeToNecromancer():
	print("SETTED TO NECROMANCER")
	isNecromancer = true;
	pass

func setWarriorDefaultWeapon(in_weapon, weapon_id):
	currentWeapon = in_weapon;
	currentWeaponId = in_weapon.weaponId;

func setPlayerKillCount(value):
	playerKillCount = value;

func setPlayerStats(in_health, in_stamina, in_mana):
	PLAYERMAXHEALTH = in_health;
	PLAYERMAXMANA = in_mana;
	PLAYERMAXSTAMINA = in_stamina;
	print("STATUS SETTADOS PARA: " + " HEALTH = " + str(PLAYERMAXHEALTH) + " STAMINA = " + str(PLAYERMAXSTAMINA) + " MANA = " + str(PLAYERMAXMANA));

func setPlayerSpeed(in_speed):
	if(PLAYERSPEEDBONUS != null):
		PLAYERSPEEDBONUS += in_speed;
	else:
		PLAYERSPEEDBONUS = in_speed;

func setPlayerSpellCostMultiplier(valor):
	PLAYERSPELLCOSTMULTIPLIER -= valor;
