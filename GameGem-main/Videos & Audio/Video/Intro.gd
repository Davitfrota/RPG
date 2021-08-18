extends Node2D

func _physics_process(delta):
	if(Input.is_action_pressed("Skip")):
		get_tree().change_scene("res://Menu/MenuOff.tscn")


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Menu/MenuOff.tscn")
