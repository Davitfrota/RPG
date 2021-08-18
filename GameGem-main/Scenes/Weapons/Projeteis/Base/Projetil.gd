extends KinematicBody2D

onready var weapon = get_parent().get_node("Player/Weapon")
onready var enemyWeapon = get_parent().get_node("Enemy/Weapon")
#onready var weapon = get_parent().get_node("Weapon")
#onready var player = get_parent().get_node("Player")
onready var subject = get_parent().get_node("Player")
onready var enemySubject = get_parent().get_node("Enemy")
onready var sprite = $Sprite;
onready var animatedSprite = $AnimatedSprite;
onready var light2D = $Light2D;
onready var collisionShape = $CollisionShape2D;

onready var damage;

var direction = Vector2(0,0);
var speed = 0;
var motion = Vector2(0,0);

func _ready():
	#Principal
	print("Subject = " + str(subject))
	if(is_instance_valid(subject) and subject.is_in_group("Player")):
		damage = weapon.weapon.damage;
		
		self.scale.x = weapon.weapon.projectile.scaleX;
		self.scale.y = weapon.weapon.projectile.scaleY;
		
		print("projectil scale x = " + str(self.scale.x))
		print("projectil scale y = " + str(self.scale.y))
		
	if(is_instance_valid(enemySubject) and enemySubject.is_in_group("Enemy")):
		damage = enemyWeapon.weapon.damage;
		
		self.scale.x = enemyWeapon.weapon.projectile.scaleX;
		self.scale.y = enemyWeapon.weapon.projectile.scaleY;
	
	$ActiveTime.start()
	
	#Collision
	if(is_instance_valid(subject) and subject.is_in_group("Player")):
		collisionShape.shape.radius = weapon.weapon.projectile.collisionRadius
	elif(is_instance_valid(enemySubject) and enemySubject.is_in_group("Enemy")):
		collisionShape.shape.radius = enemyWeapon.weapon.projectile.collisionRadius
	
	# Movement & Direction
#	animatedSprite.rotation = get_global_mouse_position().angle()
	if(is_instance_valid(subject) and subject.is_in_group("Player")):
		moveToMouse()
	elif(is_instance_valid(subject) and subject.is_in_group("Enemy") and is_instance_valid(subject.get_node("Weapon"))):
		moveToTarget()
	if(is_instance_valid(weapon) and weapon.weapon.projectile != null):
		speed = weapon.weapon.projectile.speed;
	elif(is_instance_valid(enemyWeapon) and enemyWeapon.weapon.projectile != null):
		speed = enemyWeapon.weapon.projectile.speed;
	
	#Sprite & Texture
	if(is_instance_valid(weapon) and weapon.weapon.projectile.staticTexture != null):
		sprite.visible = true;
		animatedSprite.visible = false;
		sprite.texture = weapon.weapon.projectile.staticTexture;
	if(is_instance_valid(weapon) and weapon.weapon.projectile.lightTexture != null):
		light2D.texture = weapon.weapon.projectile.lightTexture;

func _physics_process(delta):
	var collision = move_and_collide(direction * speed * delta)
	if(is_instance_valid(collision)):
		queue_free()

func moveToMouse():
	direction = direction.direction_to(get_global_mouse_position() - self.position)
#	print("Mouse position = " + str(get_global_mouse_position()))
#	print("Subject = " + str(get_parent().position))
#	print("Projectile Position = " + str(self.position))
#	print("Direction = " + str(direction))

func moveToTarget():
	direction = direction.direction_to(subject.player.position - subject.position)

func _on_ActiveTime_timeout():
	queue_free()
