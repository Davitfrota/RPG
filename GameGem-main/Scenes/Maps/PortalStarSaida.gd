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
		desactivate()

func desactivate():
	sprite.visible = false;

func activate():
	sprite.visible = true;
	collision.disabled = false;


func _on_Area2D_body_entered(body):
#	print("entrou")
	if(tipo == "Saída" and body.is_in_group("Player") and active):
		get_tree().change_scene("res://Scenes/Maps/Map03.tscn")

func _on_Area2D_area_entered(area):
#	print("entrou")
	pass


func _on_BigDemon_boss_killed():
	active = true
	activate()
