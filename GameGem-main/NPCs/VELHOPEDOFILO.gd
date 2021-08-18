extends KinematicBody2D

onready var changeDirectionTimer = $ChangeDirectionTimer
onready var animatedSprite = $AnimatedSprite

export var speed = 50;

var velocity = Vector2(0, 0);
var motion = Vector2.ZERO;
var UP = Vector2.UP;
var killCountValue = 0;
var direction = Vector2.ZERO;


func _ready():
	velocity = Vector2(speed, 0);

func _physics_process(delta):
	move();
	checkDirection();

func move():
	velocity = move_and_slide(velocity);

func _on_ChangeDirectionTimer_timeout():
	#Parar o NPC por 5 segs:
	var stopTime = Timer.new();
	add_child(stopTime);
	stopTime.wait_time = 5;
	velocity = Vector2.ZERO;
	stopTime.start()
#	print("Timer Startado")
	yield(stopTime, "timeout");
#	print("Terminou o tempo");
	
	#Fazer ele trocar a direcao:
	speed *= -1;
	velocity = Vector2(speed, 0);
	
	#Iniciar o Timer Novamente:
	changeDirectionTimer.wait_time = 5;
	changeDirectionTimer.start();
#	print("Iniciou Novamente");

func checkDirection():
	if(velocity.x < 0):
		animatedSprite.flip_h = true;
		animatedSprite.play("Run");
	elif(velocity.x > 0):
		animatedSprite.flip_h = false;
		animatedSprite.play("Run");
	else:
		animatedSprite.play("Idle");
