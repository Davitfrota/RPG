extends KinematicBody2D

#Signals
signal killed(position)
signal boss_killed

#Preloads
onready var projetil = preload("res://Scenes/Weapons/Projeteis/Base/Projetil.tscn");
onready var sumonnableDeathEffect = preload("res://Scenes/Effects/SummonableDeathEffect.tscn");
onready var deathEffect = preload("res://Effects/NormalDeathEffect.tscn")
#onready var playerScene = preload("res://Scenes/Player/Player.tscn");

#Atribution
onready var playerDetectionZone = $PlayerDetectionZone
onready var hitbox = $Hitbox
onready var hitboxCollision = $Hitbox/CollisionShape2D
onready var sprite = $Sprite
onready var oldSprite = sprite;
onready var animationPlayer = $AnimationPlayer
onready var hurtbox = $Hurtbox
onready var hurtboxCollision = $Hurtbox/CollisionShape2D
onready var blinkAnimation = $EnemyBlinkAnimation
onready var mainCollision = $CollisionShape2D

#Exports
export(Resource) var enemyAttributes;
export(bool) var boss;
export(bool) var finalBoss = false;
export var speed = 50;
export(bool) var ranged = false
export(int) var minDistance = 50;

#Principal
onready var damage = enemyAttributes.strengthValue
var direction = Vector2.ZERO;
var checkDistanceFromPlayer = 500;
var flipped = false;
var player = null;

#Flags
var isDisabled = false;
var timerCreated = false;

#Summoning
export var summoned = false;
var target = null;

#Event
export var eventEnemy = false;
var waitToAttackTimer;
var pussyMode = false;
var isInWaitToAttack = false;

func _ready():
	Socket.connect("sound", self, "_on_sound");
	pass

func _physics_process(delta):
	changeDirectionOfSprite()
	
	player = playerDetectionZone.player
	if(player):
		
		checkDistanceFromPlayer = sqrt((player.position.x - self.position.x) * (player.position.x - self.position.x) + (player.position.y - self.position.y) * (player.position.y - self.position.y));
		
		#Actions
		if(!summoned and !eventEnemy):
			if(!ranged):
				_direction_to_point(player.position - self.position, delta);
			elif(ranged and checkDistanceFromPlayer < minDistance):
				_direction_to_point(self.position - player.position, delta);
			if(ranged and checkDistanceFromPlayer >= minDistance):
				animationPlayer.play("RangeAttack");
				yield($Weapon/AttackSpeed, "timeout");
			
#			animationPlayer.play("Idle");
			var collision = move_and_collide(direction * speed * delta);
#			animationPlayer.play("Run");
			sprite.play("Run");
			animationPlayer.play("Attack");
			if(is_instance_valid(collision) and collision.collider.is_in_group("Player")):
				animationPlayer.play("Attack");
		
		
		#Summon
		elif(summoned and !eventEnemy):
			#TODO: RESOLVER BUG DO HITBOX, FAZER O SUMMON PROTEGER O PLAYER.
			
#			print("Summonado")
			#Retirar o Hitbox do inimigo da área do player e colocar na área dos próprios inimigos.
			hitbox.set_collision_mask_bit(4, false); #Faz o summon não poder atacar o player.
			hitbox.set_collision_mask_bit(5, true); #Faz o summon poder atacar outros inimigos.
			#hitboxCollision.disabled = true;
			
			#Fazer o summon proteger o player: Atacar todo e qualquer ser que tiver atacado o player:
				#Sistema de Target.
			if(target):
				move_to_point(target, delta);
				print("Target = " + str(target));
				sprite.play("Run");
			else:
				move_to_point(player, delta);
				sprite.play("Run");
		
		elif(eventEnemy):
			print("Evento ativado");
			hitboxCollision.disabled = true;
			$DialogBox/DialogText.visible = true;
			
			
			if(!timerCreated):
				waitToAttackTimer = Timer.new();
				self.add_child(waitToAttackTimer);
				waitToAttackTimer.wait_time = 5;
			
			if(checkDistanceFromPlayer < 50):
				$DialogBox/DialogText.text = "Get back, sir!\n Otherwise, we'll \n Beat U up, \n NIGGER!";
				if(!timerCreated):
					isInWaitToAttack = true;
					timerCreated = true;
					waitToAttackTimer.start();
				
				
				if(waitToAttackTimer.time_left < 0.1):
					eventEnemy = false;
					hitboxCollision.disabled = false;
					$DialogBox/DialogText.text = "KILL HIM!";
				elif(pussyMode):
					#Fazer com que eles saiam se o player fizer algum som.
					eventEnemy = false;
					hitboxCollision.disabled = true;
					ranged = true;
					Socket.write_text("PussyMode \n");
					$DialogBox/DialogText.text = "NO, PLEASE,\n DON'T HURT US!";
					emit_signal("killed", position);
				
			else:
				isInWaitToAttack = false;
				$DialogBox/DialogText.text = "Do not get closer, \n sir!";
				timerCreated = false;
				waitToAttackTimer.wait_time = 5;
	
	else:
#		animationPlayer.play("Idle")
		sprite.play("Idle");

func _direction_to_point(point, delta):
	direction = direction.direction_to(point)

func changeDirectionOfNode():
	if(direction.x < 0 && !flipped):
		self.scale.x *= -1;
		flipped = true;
	if(direction.x > 0 && flipped):
		self.scale.x *= -1;
		flipped = false;

func changeDirectionOfSprite():
	if(direction.x < 0):
		sprite.flip_h = true;
	else:
		sprite.flip_h = false;

func _on_Stats_no_health():
	emit_signal("killed", position)
	
	if(boss):
		print("Boss Killed")
		emit_signal("boss_killed")
		if(finalBoss):
			Global.setKingBossKilled(true);
			print("King Boss Killed = " + str(Global.kingBossKilled));
	
	if(!PlayerStats.isNecromancer): #Player Não é Necromancer...
		var normalDeathEffect = deathEffect.instance()
		self.add_child(normalDeathEffect);
		normalDeathEffect.play("NormalDeathEffect");
		sprite.visible = false;
		isDisabled = true;
		hitboxCollision.disabled = true;
		mainCollision.disabled = true;
		hurtboxCollision.disabled = true;
		yield(normalDeathEffect, "animation_finished");
		queue_free()
	else: #Player é Necromancer...
		#Parar a Physics Process.
		print("Morto por Necromancer")
		disableEnemy()
		
		set_physics_process(false);

func shootProjectile():
	$Weapon/AttackSpeed.start();
	var prj = projetil.instance();
	prj.set_collision_mask_bit(5, false)
	prj.set_collision_mask_bit(6, true)
	self.add_child(prj);
	prj.global_position = self.global_position
	yield($Weapon/AttackSpeed, "timeout")

func disableEnemy():
	var deathEffect = sumonnableDeathEffect.instance()
	self.add_child(deathEffect);
	deathEffect.play("default")
	print("Adicionado");
	sprite.visible = false;
	
	isDisabled = true;
	hitboxCollision.disabled = true;
	mainCollision.disabled = true;
	hurtboxCollision.disabled = true;

func activateEnemy():
	sprite.visible = true;
	isDisabled = false;
	hitboxCollision.disabled = false;
	mainCollision.disabled = false;
	hurtboxCollision.disabled = false;

func _on_Player_attacked_by(Monster):
	print("Master Attacked Connecting to Summon");
	var masterAttacked = true;
	target = Monster;
	print("masterAttacked = " + str(masterAttacked));
	_masterAttacked(Monster, 1/60);

func _masterAttacked(target, delta):
	if is_instance_valid(target):
		var checkDistanceFromTarget = sqrt((target.position.x - self.position.x) * (target.position.x - self.position.x) + (target.position.y - self.position.y) * (target.position.y - self.position.y));
		#Mover para o target
		_direction_to_point(target.position - self.position, delta);
		print("Seguindo Target");
		print("Target = " + str(target));
		if checkDistanceFromTarget < 30:
			animationPlayer.play("Attack");
		elif checkDistanceFromTarget > 30:
			animationPlayer.play("Idle");

func move_to_point(point, delta):
	_direction_to_point(point.position - self.position, delta);
	var collision = move_and_collide(direction * speed * delta);

func _on_sound(player):
	if(isInWaitToAttack):
		print("Pussy Mode Activated");
		pussyMode = true;
