extends Control

var dialog = [
	'MESMO LUTANDO COM TODAS AS SUAS ENERGIAS.',
	'O HEROI NAO FOI CAPAZ DE DERROTAR AS FORCAS SOMBRIAS',
	'E ALI MESMO SEU CORPO APODRECEU COM TODAS AS SUAS RELIQUIAS'
]

var dialog_index = 0
var finished = false

func _ready():
	load_dialog()
	Music.Death_music()
	
func _process(delta):
	$"next-indicator".visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		get_tree().change_scene("res://Scenes/Maps/Main/Main.tscn")
	dialog_index += 1


func _on_Tween_tween_completed(object, key):
	finished = true
