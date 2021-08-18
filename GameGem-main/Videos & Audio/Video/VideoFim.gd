extends Control
func _ready():
	Music.Mute()

func _on_VideoPlayer_finished():
	get_tree().quit()
