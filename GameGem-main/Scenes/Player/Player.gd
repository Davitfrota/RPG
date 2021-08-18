extends KinematicBody2D
var Death = load("res://Videos & Audio/Audio/DeathSound-[AudioTrimmer.com].wav")
var Ataque = load("res://Videos & Audio/Audio/Fire_4.wav")

func Death():
	$Audio.stream = Death
	$Audio.play()

func Ataque():
	$Audio.stream = Ataque
	$Audio.play()


#Signals
signal attacked_by(Monster)
signal moved
signal stopped

#Preloades
onready var projetil = preload("res://Scenes/Weapons/Projeteis/Base/Projetil.tscn")
onready var warriorClass = preload("res://Scenes/Player/Classes/Warrior.tres")
onready var mageClass = preload("res://Scenes/Player/Classes/Mage.tres")
onready var necromancerClass = preload("res://Scenes/Player/Classes/Necromancer.tres")
onready var noClass = preload("res://Scenes/Player/Classes/NoClass.tres")

#Local Nodes
onready var animatedSprite = $MageAnimatedSprite;
onready var animationPlayer = $AnimationPlayer;
onready var sceneTree = get_tree();
onready var hurtBox = $Hurtbox
onready var stats = $Stats
onready var weapon = $Weapon
onready var weaponAnimationPlayer = $Weapon/PlayerAnimationPlayer
onready var bars = $CanvasLayer/BarUI
onready var blinkAnimation = $BlinkAnimationPlayer
onready var stoppedTimer = $StopTimer

#Principal
export(Resource) var playerClass = null;
export var MAX_SPEED = 100;
export var ACCELERATION = 500;
export var FRICTION = 500;

#Flags
var isRunning;
var isAttacking;
var isJumping;
var timerRunning = true;

#Delays
var attackDelay = false;
var skillDelay = false;

var velocity = Vector2(0, 0)
var motion = Vector2.ZERO;
var UP = Vector2.UP;
var killCountValue = 0;

#Weapons and Skills
var w1;
var w2;
var w3;
var w4;
var w5;
enum Weapons {W1,W2,W3,W4,W5}
var currentSetted = -1;

var explosion;

#Others
var stopWaitTime = 5;

func _ready():
	weapon.weapon.connect("killCountReached", self, "warriorSkill", [weapon.weapon.killCount])
	weapon.weaponHitbox.setWeaponMask()
#	weapon.connect("Enemy", self, )
	weapon.setKillCount(PlayerStats.playerKillCount);
#	print("IsMage = " + str(PlayerStats.isMage))
#	print("IsWarrior = " + str(PlayerStats.isWarrior))
#	print("IsNecromancer = " + str(PlayerStats.isNecromancer))
	
	if(PlayerStats.PLAYERSPEEDBONUS != null):
		MAX_SPEED += PlayerStats.PLAYERSPEEDBONUS;
		print("New Velocity = " + str(MAX_SPEED));
	
	if(PlayerStats.isWarrior):
#		print("Im a Warrior")
		w1 = load("res://Scenes/Weapons/Swords/BasicSword.tres");
		w2 = load("res://Scenes/Weapons/Swords/Sabre.tres")
		w3 = load("res://Scenes/Weapons/Swords/DoubleLance.tres")
		w4 = load("res://Scenes/Weapons/Swords/Waraxe.tres")
		w5 = load("res://Scenes/Weapons/Swords/Excalibur.tres")
		changeToWarrior()
	elif(PlayerStats.isMage):
#		print("Im a Mage")
		explosion = load("res://Scenes/Player/Skills/Explosion.tscn")
		changeToMage()
	elif(PlayerStats.isNecromancer):
#		print("Im a Necromancer")
		changeToNecromancer()
	else:
		animatedSprite = $NoClassAnimatedSprite
	
	stats.updateStats()
	bars.setHealthBar()
	bars.setStaminaBar()
	bars.setManaBar()
	weapon.set_scale_of_weapon()

func _physics_process(delta):
	killCountValue = weapon.weapon.killCount;
	
	if(PlayerStats.isWarrior):
		warriorSkill();
	
	
		#Movement
	
	if(velocity > Vector2.ZERO):
		emit_signal("moved");
		resetStopTimer()
		timerRunning = false
	
	move_state(delta);
	
	if Input.is_action_pressed("UP"):
		animatedSprite.play("walk");
		motion.y = max(motion.y - ACCELERATION, -MAX_SPEED);
		
	if Input.is_action_pressed("DOWN"):
		animatedSprite.play("walk");
		motion.y = min(motion.y + ACCELERATION, MAX_SPEED);
	
	if Input.is_action_pressed("RIGHT"):
		animatedSprite.flip_h = false;
		animatedSprite.play("walk");
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED);
	elif Input.is_action_pressed("LEFT"):
		animatedSprite.flip_h = true;
		animatedSprite.play("walk");
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED);
	else:
		motion.x = lerp(motion.x, 0, 0.2);
		motion.y = lerp(motion.y, 0, 0.2);
		if(velocity.x == 0 && velocity.y == 0):
			animatedSprite.play("idle")
			
			if(!timerRunning):
				timerRunning = true
				print("timer started")
				stoppedTimer.start()
	
	move()
	if(!attackDelay):
		if(Input.is_action_pressed("ATTACK")):
			attackDelay = true;
			$Weapon/AttackSpeed.start();
			resetStopTimer()
			
			var attackStaminaCost = null;
			
			if(weapon.weapon.staminaUsage - stats.strengthValue <= 5):
				attackStaminaCost = 5;
			else:
				attackStaminaCost = weapon.weapon.staminaUsage - stats.strengthValue;
			
			if(stats.mana > weapon.weapon.manaUsage and stats.stamina > attackStaminaCost):
				if(weapon.weapon.weaponType == 1): # "1" representa o tipo RANGED.
					var prj = projetil.instance();
					get_parent().add_child(prj);
					prj.global_position = self.global_position
					prj.moveToMouse();
					Ataque();
				elif(weapon.weapon.weaponType == 0): # "0" representa o tipo MELEE.
					weaponAnimationPlayer.play("MeleeRight")
#					weapon.increaseKillCount(1);
					if(weapon.weapon.staminaUsage - stats.strengthValue >= 5):
						stats.stamina -= weapon.weapon.staminaUsage - stats.strengthValue;
					else:
						stats.stamina -= 5;
				stats.mana -= weapon.weapon.manaUsage
				
	if(!skillDelay):
		if(Input.is_action_just_pressed("SKILL")):
			resetStopTimer()
			if(PlayerStats.isMage):
				mageSkill()
			elif(PlayerStats.isNecromancer):
				necromancerSkill()

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	input_vector.y = Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

func move():
	velocity = move_and_slide(velocity)

func _on_AttackSpeed_timeout():
	attackDelay = false

func _on_Stats_no_health():
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	Death()
	yield($Audio,"finished")
	get_tree().change_scene("res://Menu/PowerUpScena/ScenesMenu/Fim.tscn")

func changeToWarrior():
	weapon.weaponHitboxCollision.disabled = false;
	weapon.change_weapon(warriorClass.defaultWeapon)
	weapon.set_scale_of_weapon()
	print("changed class")
	playerClass = warriorClass
	setarStatus()
	animatedSprite = $WarriorAnimatedSprite;
	$WarriorAnimatedSprite.visible = true;
	$MageAnimatedSprite.visible = false;
	$NecromancerAnimatedSprite.visible = false;
	$NoClassAnimatedSprite.visible = false;

func changeToMage():
	weapon.change_weapon(mageClass.defaultWeapon)
	weapon.set_scale_of_weapon()
	print("changed class")
	playerClass = mageClass
	animatedSprite = $MageAnimatedSprite
	$WarriorAnimatedSprite.visible = false;
	$MageAnimatedSprite.visible = true;
	$NecromancerAnimatedSprite.visible = false;
	$NoClassAnimatedSprite.visible = false;

func changeToNecromancer():
	weapon.change_weapon(necromancerClass.defaultWeapon)
	weapon.set_scale_of_weapon()
	print("changed class")
	playerClass = necromancerClass
	animatedSprite = $NecromancerAnimatedSprite
	$WarriorAnimatedSprite.visible = false;
	$MageAnimatedSprite.visible = false;
	$NecromancerAnimatedSprite.visible = true;
	$NoClassAnimatedSprite.visible = false;

func warriorSkill():
	if(killCountValue >= 5 and PlayerStats.currentWeaponId == 1):
		weapon.change_weapon(w1)
		warriorClass.defaultWeapon = w1
		currentSetted = Weapons.W1;
		PlayerStats.setWarriorDefaultWeapon(w1, w1.weaponId);
	elif(killCountValue >= 50 and PlayerStats.currentWeaponId == 2):
		weapon.change_weapon(w2)
		warriorClass.defaultWeapon = w2
		currentSetted = Weapons.W2;
		PlayerStats.setWarriorDefaultWeapon(w2, w2.weaponId);
	elif(killCountValue >= 50 and PlayerStats.currentWeaponId == 3):
		weapon.change_weapon(w3)
		warriorClass.defaultWeapon = w3
		currentSetted = Weapons.W3;
		PlayerStats.setWarriorDefaultWeapon(w3, w3.weaponId);
	elif(killCountValue >= 50 and PlayerStats.currentWeaponId == 4):
		weapon.change_weapon(w4)
		warriorClass.defaultWeapon = w4
		currentSetted = Weapons.W4;
		PlayerStats.setWarriorDefaultWeapon(w4, w4.weaponId);
	elif(killCountValue >= 250 and PlayerStats.currentWeaponId == 5):
		weapon.change_weapon(w5)
		warriorClass.defaultWeapon = w5
		currentSetted = Weapons.W5;
		PlayerStats.setWarriorDefaultWeapon(w5, w5.weaponId);

func mageSkill():
	var mousePosition = get_global_mouse_position();
	var explosionNode = explosion.instance();
	if(stats.mana - (explosionNode.manaUsage * PlayerStats.PLAYERSPELLCOSTMULTIPLIER) >= 0):
		explosionNode.position = mousePosition; 
		get_parent().add_child(explosionNode);
		stats.mana -= explosionNode.manaUsage * PlayerStats.PLAYERSPELLCOSTMULTIPLIER;

func necromancerSkill():
	print("Ressurecting Enemies...");

func setarStatus():
	PlayerStats.setPlayerStats(playerClass.enduranceValue * 10, playerClass.staminaValue * 10, playerClass.intelligenceValue * 10);

func _on_StopTimer_timeout():
	emit_signal("stopped")

func resetStopTimer():
	stoppedTimer.stop()
	stoppedTimer.wait_time = stopWaitTime;
