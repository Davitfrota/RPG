extends Node2D

var weaponScript = preload("res://Scenes/Weapons/Base/WeaponScript.gd")
var enemyScript = preload("res://Scenes/Enemies/Base/Enemy.gd")
onready var projetil = preload("res://Scenes/Weapons/Projeteis/Base/Projetil.tscn")

onready var sprite = $Sprite
onready var attackSpeed = $AttackSpeed
onready var subject = get_parent()
onready var animationPlayer
onready var weaponHitbox = $weaponHitbox
onready var weaponHitboxCollision = $weaponHitbox/CollisionShape2D

var enemy;
var player;
export(Resource) var weapon = null;
var mousePosition;
var initialRot = 45;
onready var damage;

func _ready():
	if(subject.is_in_group("Player")):
		change_weapon(subject.playerClass.defaultWeapon);
	set_weapon()

func _process(delta):
	if(subject.is_in_group("Player")):
		mousePosition = get_local_mouse_position()
		rotation += mousePosition.angle()
	elif(subject.is_in_group("Enemy")):
		rotation = subject.direction.angle()
	
	if(is_instance_valid(enemy) and enemy.checkDistanceFromPlayer < 25):
		play_animation(rotation_degrees)


func play_animation(angle):
	if(angle >= 0 and angle <= 15 or angle <= 0 and angle >= -15):
		animationPlayer.play("MeleeAttack")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle > 15 and angle <= 45):
		animationPlayer.play("MeleeAttackUpRight")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle > 45 and angle <= 75):
		animationPlayer.play("MeleeAttackDownRight")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle > 75 and angle <= 90 or angle >= 90 and angle < 105):
		animationPlayer.play("MeleeAttackDown")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle >= 105 and angle < 130):
		animationPlayer.play("MeleeAttackDownLeft")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle < 180 and angle > 160):
		animationPlayer.play("MeleeAttackUpLeft")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle >= 145 and angle <= 160 or angle <= 145 and angle >= 130):
		animationPlayer.play("MeleeAttackRight")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;
	if(angle >= -90 and angle >= -75 or angle <= -90 and angle > -105):
		animationPlayer.play("MeleeAttackUp")
		weaponHitboxCollision.disabled = false;
		yield(animationPlayer, "animation_finished");
		weaponHitboxCollision.disabled = true;

func set_collision():
	if(subject.is_in_group("Player")):
		pass
	elif(subject.is_in_group("Enemy")):
		weaponHitbox.set_collision_mask_bit(4, true)
		weaponHitbox.set_collision_layer_bit(7, true)

func set_weapon():
#	if(subject.is_in_group("Player")):
#		change_weapon(subject.playerClass.defaultWeapon);
	set_collision()
	if(weapon):
#		print("weapon = " + weapon.name)
		damage = weapon.damage
#		print("Weapon Damage " + str(damage))
		attackSpeed.wait_time = weapon.attackSpeed;
		sprite.texture = weapon.texture;
		sprite.scale.x = weapon.scaleX;
		sprite.scale.y = weapon.scaleY;
		
		if(weapon.weaponType == weaponScript.WeaponTypes.MELEE):
#			print("Melee weapon")
			if(subject.is_in_group("Player")):
	#			Animacao para atacar com melee pelo player
				animationPlayer = $PlayerAnimationPlayer
				player = subject
				
			elif(subject.is_in_group("Enemy")):
	#			Animacao para atacar com melee pelo inimigo
				animationPlayer = $EnemyAnimationPlayer
				enemy = subject

func change_weapon(in_weapon):
	weapon = in_weapon;
	sprite.texture = weapon.texture;
	set_weapon()
	print("Weapon Setted to " + in_weapon.name)
	print("Weapon Damage " + str(damage))
	

func set_scale_of_weapon():
	scale.x = weapon.scaleX;
	scale.y = weapon.scaleY;

func increaseKillCount(value):
	weapon.incrementKillCount(value);

func setKillCount(value):
	weapon.setKillCount(value);




