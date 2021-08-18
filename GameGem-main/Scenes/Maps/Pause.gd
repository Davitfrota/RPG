extends Node

func _ready():
 set_visible(false)
func _process(delta):
		
		if Input.is_action_just_pressed("PAUSE"):
			if get_tree().current_scene.name == "Mapa01" || get_tree().current_scene.name == "Mapa02" || get_tree().current_scene.name == "Mapa03" || get_tree().current_scene.name == "Mapa03Castelo" || get_tree().current_scene.name == "Main":
				set_visible(!get_tree().paused)
				get_tree().paused = !get_tree().paused
				$VBoxContainer2.visible = false
				$VSlider.visible = false
				
func _on_Button_pressed():
	get_tree().paused = false 
	set_visible(false)

func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible
		
func _on_Button2_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	
func _on_Button3_pressed():
	get_tree().change_scene("res://Menu/MenuOff.tscn")
	get_tree().paused = false

func _on_Quit_pressed():
	get_tree().quit()

func _on_Restart_pressed():
	get_tree().paused = false
	set_visible(false)
	if get_tree().current_scene.name == "Mapa01":
		get_tree().change_scene("res://Scenes/Maps/Mapa01.tscn")
		
	elif get_tree().current_scene.name == "Mapa02":
		get_tree().change_scene("res://Scenes/Maps/Mapa02.tscn")
		
	elif get_tree().current_scene.name == "Mapa03":
		get_tree().change_scene("res://Scenes/Maps/Mapa03.tscn")
	
	elif get_tree().current_scene.name == "Mapa03Castelo":
		get_tree().change_scene("res://Scenes/Maps/Mapa03Castelo.tscn")
	
	else :
		get_tree().change_scene("res://Scenes/Maps/Main/Main.tscn")
		
func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	

func _on_Options_pressed():
	$VBoxContainer.visible = false
	$VBoxContainer2.visible = true
	
func _on_Full_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_Back_pressed():
	$VBoxContainer.visible = true
	$VBoxContainer2.visible = false

func _on_CheckButton_toggled(pressed):
	if pressed == true:
		Music.Mute()
	else:
		Music.desMute()

