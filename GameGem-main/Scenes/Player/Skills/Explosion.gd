extends KinematicBody2D

var damage = 100;
var manaUsage = 100;

func _ready():
	$AnimationPlayer.play("Explode")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
