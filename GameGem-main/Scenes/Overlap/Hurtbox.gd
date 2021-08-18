extends Area2D

signal damaged(value)

onready var subject = get_parent();


func _on_Hurtbox_body_entered(body):
	if(body.is_in_group("Projectile") and body.damage > 0):
#		print("projectile entered")
#		print(body.damage)
		emit_signal("damaged", body.damage);
		if(subject.is_in_group("Player") or subject.is_in_group("Enemy")):
			if(is_instance_valid(subject.blinkAnimation)):
				if(subject.is_in_group("Enemy") and subject.isDisabled == false):
					subject.blinkAnimation.play("Start");
				elif(subject.is_in_group("Player")):
					subject.blinkAnimation.play("Start");
	pass


func _on_Hurtbox_area_entered(area):
	if(!area.is_in_group("Radar")):
#		print(area.get_parent().damage);
		emit_signal("damaged", area.get_parent().damage);
		if(subject.is_in_group("Enemy") and subject.isDisabled == false):
			subject.blinkAnimation.play("Start");
		elif(subject.is_in_group("Player")):
			subject.blinkAnimation.play("Start");
			if(is_instance_valid(area.location)):
				subject.emit_signal("attacked_by", area.location);
			print("Master Attacked Emitted from Player");
