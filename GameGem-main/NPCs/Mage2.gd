extends KinematicBody2D

export var speed = 100;

var velocity = Vector2(0, 0);
var motion = Vector2.ZERO;
var UP = Vector2.UP;
var killCountValue = 0;
var direction = Vector2.ZERO;
var stop = true
onready var timer = $Timer
func _ready():
	pass
	
	

func _physics_process(delta):
	if(stop):
		stop = false
		timer.start()
		yield(timer,"timeout")
		changeDirection(-1)
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
		stop = true
	move();

func move():
	velocity = Vector2(speed, 0);
	velocity = move_and_slide(velocity);
	print(speed)

func changeDirection(value):
	speed = speed*value

func stop():
	pass


func _on_Timer_timeout():
	changeDirection(-1);
	
	
	
