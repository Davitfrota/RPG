extends Node2D


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Maps/Main/Main.tscn")


func _on_Quit_pressed():
	get_tree().quit()

func _on_Hero_pressed():
	$Camera2D.position = Vector2(512,912)


func _on_Cavaleiro_pressed():
	$Camera2D.position = Vector2(512,292)


func _on_Mago_pressed():
	$Camera2D.position = Vector2(1535,292)

