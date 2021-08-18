extends Node

var player;
var playerClass;

var kingBossKilled = false;

func _ready():
	Socket.connect_to_server()

func register_player(in_player):
	player = in_player
	playerClass = in_player.playerClass
	print("global player = " + str(player))

func changeClass(in_playerClass):
	print("PLAYER CLASS = " + str(in_playerClass));
	playerClass = in_playerClass

func setKingBossKilled(boolean):
	kingBossKilled = boolean;
