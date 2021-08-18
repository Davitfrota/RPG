extends Area2D

signal area_cleared
signal spawn_enemies

var mapa01

onready var enemyDetectorCollision = $EnemyDetector
onready var enemySpawn = get_parent().get_parent().get_node("PlayerAndEnemies/EnemySpawn")

var contEnemies = 0;
var enemySpawned = false
export var id = 0;

func _ready():
	for i in get_tree().get_nodes_in_group("EnemySpawn"):
		if(i.id == self.id):
			contEnemies = i.get_child_count();
#			print("enemy quantity setted to " + str(contEnemies))


func _on_DetectorInimigos_body_entered(body):
	contEnemies+=1;

func _on_DetectorInimigos_body_exited(body):
	contEnemies-=1;
	if(contEnemies <= 0):
		emit_signal("area_cleared")


func _on_DetectorInimigos_area_entered(area):
	if(area.is_in_group("PlayerHurtbox")):
		emit_signal("spawn_enemies")
		enemySpawned = true
		
	elif(enemySpawned):
		pass


func _on_DetectorInimigos_area_exited(area):
	if(enemySpawned):
		contEnemies-=1;
		if(contEnemies <= 0):
			print("area cleared")
			enemySpawned = false
			emit_signal("area_cleared")
	#		Conectar o sinal AREA_CLEARED nas traps da respectiva área para fazer elas desativarem.
