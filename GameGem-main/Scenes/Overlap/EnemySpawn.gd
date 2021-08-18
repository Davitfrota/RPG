extends YSort

export var id = 0

func _ready():
	desactivate_enemies()
	
	for i in get_tree().get_nodes_in_group("Radar"):
		if(i.id == self.id):
			i.connect("spawn_enemies", self, "activate_enemies")
#			print(str(i) + " connected to " + str(self))

func _on_DetectorInimigos_spawn_enemies():
	if(self.id == 1):
		activate_enemies()

func desactivate_enemies():
	for i in get_child_count():
		get_child(i).set_physics_process(false)
		get_child(i).sprite.visible = false;

func activate_enemies():
	for i in get_child_count():
		get_child(i).set_physics_process(true)
		get_child(i).sprite.visible = true;


func _on_DetectorInimigos2_spawn_enemies():
	if(self.id == 2):
		activate_enemies()


func _on_DetectorInimigos3_spawn_enemies():
	pass # Replace with function body.


func _on_DetectorInimigos4_spawn_enemies():
	if(self.id == 4):
		activate_enemies()


func _on_DetectorInimigos5_spawn_enemies():
	if(self.id == 5):
		activate_enemies();
