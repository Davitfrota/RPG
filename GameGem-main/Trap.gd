extends Node2D

var killedEnemies;


func _on_Area2D2_body_entered(body):
	if body.is_in_group("Player"):
		$CollisionShapeT.set_deferred("disabled", false)
		$AnimatedSprite.play("Up")

func _on_DetectorInimigos_area_cleared():
	$CollisionShapeT.set_deferred("disabled", true)
	$AnimatedSprite.play("Down")
	$Area2D/CollisionShape2D.disabled = true
