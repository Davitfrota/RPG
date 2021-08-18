extends Area2D

var location = null
onready var damage = get_parent().damage
onready var weapon = get_parent()

func _ready():
	setWeaponMask()

func setWeaponMask():
	if(is_instance_valid(weapon.subject) and get_parent().subject.is_in_group("Player")):
		self.set_collision_mask_bit(4, false);
		self.set_collision_mask_bit(5, true);
