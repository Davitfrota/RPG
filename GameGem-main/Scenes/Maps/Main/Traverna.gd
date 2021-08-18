extends Node2D

signal isMage
signal isWarrior
signal isNecromancer



onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")
onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
onready var necromancerClass = preload("res://Scenes/Player/Classes/Necromancer.tres")
onready var mapa01 = preload("res://Scenes/Maps/Mapa01.tscn")

onready var player = $Player

var isMage = false;
var isWarrior = false;
var isNecromancer = false;




func _process(delta):
	if(isMage):
		if(Input.is_action_just_pressed("ACTION")):
			emit_signal("isMage")
			PlayerStats.changeToMage()
			player.changeToMage()
#			Global.register_player(player)
			_change_to_dungeon()
	if(isWarrior):
		if(Input.is_action_just_pressed("ACTION")):
			emit_signal("isWarrior")
			PlayerStats.changeToWarrior()
			player.changeToWarrior()
			_change_to_dungeon()
	if(isNecromancer):
		if(Input.is_action_just_pressed("ACTION")):
			emit_signal("isNecromancer")
			PlayerStats.changeToNecromancer()
			player.changeToNecromancer()
			_change_to_dungeon()

func _on_MageClass_body_entered(body):
	isMage = true


func _on_WarriorClass_body_entered(body):
	isWarrior = true


func _on_NecromancerClass_body_entered(body):
	isNecromancer = true


func _on_MageClass_body_exited(body):
	isMage = false


func _on_WarriorClass_body_exited(body):
	isWarrior = false


func _on_NecromancerClass_body_exited(body):
	isNecromancer = false

func _change_to_dungeon():
	get_tree().change_scene_to(mapa01);
