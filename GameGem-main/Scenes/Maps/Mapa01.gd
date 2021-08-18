extends Node2D

#onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")
#onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
#onready var necromancerClass = preload("res://Scenes/Player/Classes/Necromancer.tres")
#
#var MenuOff = preload("res://Menu/MenuOff.tscn")
#
#var player
#var isMage = MenuOff.isMage;
#var isWarrior = MenuOff.isWarrior;
#var isNecromancer = MenuOff.isNecromancer;
#
#func _ready():
#	MenuOff.connect("changeToMage", self, "setMageClass")
#	MenuOff.connect("changeToWarrior", self, "setWarriorClass")
#	MenuOff.connect("changeToNecromancer", self, "setNecromancerClass")
#
#func register_player(in_player):
#	player = in_player
#	print("global player = " + str(player))
#
#func changeClass():
#	print("changed class")
#	print("isMage = " + str(isMage))
#	if(isMage):
#		player.changeToMage();
#	elif(isWarrior):
#		player.changeToWarrior();
#	elif(isNecromancer):
#		player.changeToNecromancer();
#
#
#func setMageClass():
#	isMage = true;
#	print("Changed to mage")
#func setWarriorClass():
#	isWarrior = true;
#	print("Changed to warrior")
#func setNecromancerClass():
#	isNecromancer = true;
#	print("Changed to necromancer")
#
#func _process(delta):
#	print(isMage)
#
#
#func _on_DetectorInimigos_area_cleared():
#	$"All traps/Area2D2/CollisionShape2D".disabled = true
#
#
#func _on_DetectorInimigos2_area_cleared():
#	$"All traps/Area2D/CollisionShape2D".disabled = true

onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")
onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
onready var necromancerClass = preload("res://Scenes/Player/Classes/Necromancer.tres")

var MenuOff = preload("res://Menu/MenuOff.tscn")

var player
#var isMage = MenuOff.isMage;
#var isWarrior = MenuOff.isWarrior;
#var isNecromancer = MenuOff.isNecromancer;
#
#func _ready():
#	MenuOff.connect("changeToMage", self, "setMageClass")
#	MenuOff.connect("changeToWarrior", self, "setWarriorClass")
#	MenuOff.connect("changeToNecromancer", self, "setNecromancerClass")
#
#func register_player(in_player):
#	player = in_player
#	print("global player = " + str(player))
#
#func changeClass():
#	print("changed class")
#	print("isMage = " + str(isMage))
#	if(isMage):
#		player.changeToMage();
#	elif(isWarrior):
#		player.changeToWarrior();
#	elif(isNecromancer):
#		player.changeToNecromancer();
#
#
#func setMageClass():
#	isMage = true;
#	print("Changed to mage")
#func setWarriorClass():
#	isWarrior = true;
#	print("Changed to warrior")
#func setNecromancerClass():
#	isNecromancer = true;
#	print("Changed to necromancer")
#
#func _process(delta):
	#	print(isMage)
func _ready():
	Music.Mapa1_music()


func _on_DetectorInimigos_area_cleared():
	$"All traps/Area2D2/CollisionShape2D".disabled = true


func _on_DetectorInimigos2_area_cleared():
	$"All traps/Area2D/CollisionShape2D".disabled = true

