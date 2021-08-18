extends Node2D

onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")
onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
onready var necromancerClass = preload("res://Scenes/Player/Classes/Necromancer.tres")
onready var mapa01 = preload("res://Scenes/Maps/Mapa01.tscn")

onready var player = $Player

var isMage = false;
var isWarrior = false;
var isNecromancer = false;


func _ready():
	Music.Tavern_music()

func _process(delta):
	if(isMage):
		if(Input.is_action_just_pressed("ACTION")):
			PlayerStats.changeToMage()
			_change_to_dungeon()
	elif(isWarrior):
		if(Input.is_action_just_pressed("ACTION")):
			PlayerStats.changeToWarrior()
			_change_to_dungeon()
	elif(isNecromancer):
		if(Input.is_action_just_pressed("ACTION")):
			PlayerStats.changeToNecromancer()
			_change_to_dungeon()

func _on_MageClass_body_entered(body):
	if(body.is_in_group("Player")):
		isMage = true;
		print("At Mage")


func _on_WarriorClass_body_entered(body):
	if(body.is_in_group("Player")):
		isWarrior = true;
		print("At Warrior")


func _on_NecromancerClass_body_entered(body):
	if(body.is_in_group("Player")):
		isNecromancer = true;
		print("At Necromancer")


func _on_MageClass_body_exited(body):
	if(body.is_in_group("Player")):
		isMage = false;
		print("Mage Area Exited");


func _on_WarriorClass_body_exited(body):
	if(body.is_in_group("Player")):
		isWarrior = false;
		print("Warrior Area Exited");


func _on_NecromancerClass_body_exited(body):
	if(body.is_in_group("Player")):
		isNecromancer = false;
		print("Necromancer Area Exited");

func _change_to_dungeon():
	get_tree().change_scene_to(mapa01);
