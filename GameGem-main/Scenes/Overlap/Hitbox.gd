extends Area2D

onready var damage;

var location = self;

func _ready():
	if(is_instance_valid(get_parent().get_node("Stats").strengthValue)):
		damage = get_parent().get_node("Stats").strengthValue;
	pass 
