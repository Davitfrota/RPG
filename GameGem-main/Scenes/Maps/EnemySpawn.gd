extends YSort

export var id = 0

func _ready():
	if(!Global.kingBossKilled):
		activate_enemies();
	else:
		desactivate_enemies();

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
