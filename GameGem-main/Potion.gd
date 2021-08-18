extends Area2D

signal collected(healAmount)

enum PotionTypes {HEAL, STAMINA, MANA}

export(String) var potionName;
export(PotionTypes) var potionType = null;
export(int) var healAmount;

func _ready():
	print(potionType)



func _on_HealthPotion_body_entered(body):
	if(body.is_in_group("Player")):
#		print("playerEntrou")
		var player = body;
		player.stats.health += 50;
		queue_free();
		
