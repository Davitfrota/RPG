extends Node

signal no_health
signal health_changed

onready var hurtBox = get_parent().get_node("Hurtbox")
onready var subject = get_parent();

#Res
var max_health;
var health = null;
var healthRegen;

var max_mana;
var mana;
var manaRegen;

var max_stamina;
var stamina;
var staminaRegen;

#Atr
var strengthValue;
var enduranceValue;
var staminaValue;
var intelligenceValue;

#Flags
var moved = true


func _ready():
	emit_signal("health_changed", 0)
	updateStats()
	
#		print("Health = " + str(health));

func health_changed(value):
	if(value != null):
		health -= value;
#	print("health = " + str(health))
	if(health <= 0):
		health = 0;
		emit_signal("no_health")
	
	emit_signal("health_changed")

func heal(atribute, value):
	print("healando...");
	if(atribute == "health"):
		health += value;
	elif(atribute == "mana"):
		mana += value;

func _on_Hurtbox_body_entered(body):
	if(body.is_in_group("Projectile") or body.is_in_group("Skill")):
		if(subject.is_in_group("Player")):
#			print("is_in_player")
			body.set_collision_mask_bit(5, false);
		elif(subject.is_in_group("Enemy")):
#			print("is_in_monster")
			body.set_collision_mask_bit(4, false);
		health_changed(body.damage)


func _on_Hurtbox_area_entered(area):
	if(area.get_parent().is_in_group("Enemy") and area.get_parent().isDisabled == false and subject.is_in_group("Player") or area.get_parent().is_in_group("Projectile")) and subject.is_in_group("Player"):
		health_changed(area.get_parent().damage);
	elif(area.is_in_group("WeaponHitbox")):
		health_changed(area.get_parent().damage);
		subject.blinkAnimation.play("Start");
		if(subject.is_in_group("Enemy")):
			var playerWeapon = area.get_parent();
			playerWeapon.increaseKillCount(1);
		
#		print("damaged by " + str(area.get_parent().damage))

func _process(delta):
	healthRegen(delta);
	staminaRegen(delta);
	manaRegen(delta);

func updateStats():
	var atributes;
	
	if(subject.is_in_group("Player")):
		atributes = subject.playerClass;
		var luck = atributes.luckValue;
	elif(subject.is_in_group("Enemy")):
		atributes = subject.enemyAttributes;
	
	
	if(subject.is_in_group("Player") or subject.is_in_group("Enemy")):
		#Atributos
		strengthValue = atributes.strengthValue;
		enduranceValue = atributes.enduranceValue;
		staminaValue = atributes.staminaValue;
		intelligenceValue = atributes.intelligenceValue;
		
		#Resourcements
		max_health = enduranceValue * 10;
		health = max_health;
		healthRegen = 1;
#		healthRegen = 100;
		
		max_mana = intelligenceValue * 10;
		mana = max_mana;
		manaRegen = 0.5;
#		manaRegen = 100;
		
		max_stamina = staminaValue * 10;
		stamina = max_stamina;
		staminaRegen = 3;
		
		#Prints
#		print("Max Mana = " + str(max_mana));
#		print("Max Stamina = " + str(max_stamina));

func healthRegen(delta):
	if(health != null and subject.is_in_group("Player")):
		health = min(health + (healthRegen * delta), max_health);

func staminaRegen(delta):
	if(stamina != null):
		stamina = min(stamina + (staminaRegen * delta), max_stamina);

func manaRegen(delta):
	if(mana != null):
		mana = min(mana + (manaRegen * delta), max_mana);

func _on_Player_moved():
	if(!moved):
		moved = true
		print("moved")
		manaRegen /= 2;
		healthRegen /= 2;
		staminaRegen /= 2;

func _on_Player_stopped():
	if(moved):
		moved = false
		print("stopped")
		manaRegen *= 2;
		healthRegen *= 2;
		staminaRegen *= 2;
