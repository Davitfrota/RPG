extends Label
onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
onready var necroClass = preload("res://Scenes/Player/Classes/Necromancer.tres")


var Mana = str("SUA INTELIGENCIA AUMENTA")
var Staff = str("SUAS SKILLS CUSTAM MENOS MANA")
var Speed = str("SEU HEROI FICA MAIS VELOZ")

func _on_sword_mouse_entered():
	set_text(Mana)

func _on_sword_mouse_exited():
	set_text("")

func _on_Staff_mouse_entered():
	set_text(Staff)

func _on_Staff_mouse_exited():
	set_text("")

func _on_Speed_mouse_entered():
	set_text(Speed)

func _on_Speed_mouse_exited():
	set_text("")

##################################################

func _on_Speed_pressed():
	get_tree().change_scene("res://Scenes/Maps/Mapa02.tscn")
	PlayerStats.setPlayerSpeed(15);

func _on_Staff_pressed():
	get_tree().change_scene("res://Scenes/Maps/Mapa02.tscn")
	PlayerStats.setPlayerSpellCostMultiplier(0.15);
	
func _on_Mana_pressed():
	get_tree().change_scene("res://Scenes/Maps/Mapa02.tscn")
	mageClass.increaseIntelligence(5);
	necroClass.increaseIntelligence(5);
