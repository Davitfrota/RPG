extends KinematicBody2D

var speed = 200
var motion = Vector2()
func _physics_process(delta):
	motion = Vector2()
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
		$AnimatedSprite.play("run")
	
	motion = move_and_slide(motion)
