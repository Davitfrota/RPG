extends Node2D

onready var player = $Player;
var afterKingPosition = Vector2(512, 367);

func _ready():
	Music.Mapa3_music()
	if(Global.kingBossKilled == true):
		player.position = afterKingPosition;
