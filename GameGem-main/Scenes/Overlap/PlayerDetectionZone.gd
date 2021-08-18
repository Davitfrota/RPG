extends Area2D

var player = null




func _on_PlayerDetectionZone2_body_entered(body):
	if(body.is_in_group("Player")):
		player = body
		print(player)



func _on_PlayerDetectionZone2_body_exited(body):
	if(body.is_in_group("Player")):
		player = null
		print(player)
