extends Button


func _on_Elf_Body_mouse_entered():
	self.add_color_override("font_color", "ffffff")


func _on_Elf_Body_mouse_exited():
	self.add_color_override("font_color", "000000")
