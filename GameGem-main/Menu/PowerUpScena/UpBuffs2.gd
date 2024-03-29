extends Label

#Preloads

onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")



#Signals
signal health_pressed
signal luck_pressed
signal strength_pressed

#Buffs
var Speed = str("SUA VELOCIDADE AUMENTA BASTANTE")
var Vida = str("SUA VITALIDADE MAXIMA AUMENTA")
var Stam = str("SUA ENERGIA MAXIMA AUMENTOU")

func _on_Speed_mouse_entered():
	set_text(Speed)

func _on_Speed_mouse_exited():
	set_text("")
	
func _on_Vida_mouse_entered():
	set_text(Vida)
	
func _on_Vida_mouse_exited():
	set_text("")

func _on_Stren_mouse_entered():
	set_text(Stam)

func _on_Stren_mouse_exited():
	set_text("")
##############################CLICK#######################################

func _on_Speed_pressed():
	get_tree().change_scene("res://Scenes/Maps/Mapa03.tscn")
	PlayerStats.setPlayerSpeed(15);

func _on_Vida_pressed():
	get_tree().change_scene("res://Scenes/Maps/Mapa03.tscn")
	warriorClass.increaseEndurance(5);

func _on_Stren_pressed():
	get_tree().change_scene("res://Scenes/Maps/Mapa03.tscn")
	warriorClass.increaseStamina(5)
