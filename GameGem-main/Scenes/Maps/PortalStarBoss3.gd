extends Node2D

onready var destination = get_parent().get_node("PortalStarBossEntrada2")

export(String, "Entrada", "Saída") var tipo;

var active = false

func _on_Area2D_body_entered(body):
#	print("entrou")
	if(body.is_in_group("Player")):
		body.position.x = destination.position.x;
		body.position.y = destination.position.y - 40;

func _on_Area2D_area_entered(area):
#	print("entrou")
	pass
