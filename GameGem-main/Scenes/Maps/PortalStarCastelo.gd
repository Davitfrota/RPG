extends Node2D

onready var sprite = $PortalSprite
onready var collision = $PortalSprite/Area2D/CollisionShape2D

export(String, "Entrada", "Saída") var tipo;

var active = false

func _ready():
	if(tipo == "Entrada"):
#		print("Portal de Entrada")
		pass
	elif(tipo == "Saída"):
#		print("Portal de Saida")
#		desactivate()
		pass

func desactivate():
	sprite.visible = false;
	collision.disabled = true;

func activate():
	collision.disabled = false;


func _on_Area2D_body_entered(body):
	print("entrou")
	if(tipo == "Saída" and body.is_in_group("Player") and active):
		print("mudando cena")
		if(PlayerStats.isWarrior):
			get_tree().change_scene("res://Scenes/Maps/Mapa03.tscn")
		else:
			get_tree().change_scene("res://Scenes/Maps/Mapa03.tscn");



func _on_Area2D_area_entered(area):
	print("area entrou")
	pass


func _on_King_boss_killed():
	active = true
	activate()
