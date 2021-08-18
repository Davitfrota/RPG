extends Control

onready var stats = get_parent().get_parent().get_node("Stats")
onready var player = get_parent().get_parent()

onready var healthBar = $HealthProgressBar
onready var staminaBar = $StaminaProgressBar
onready var manaBar = $ManaProgressBar
onready var healthBarLabel = $HealthProgressBar/HealthBarLabel
onready var staminaBarLabel = $StaminaProgressBar/StaminaBarLabel
onready var manaBarLabel = $ManaProgressBar/ManaBarLabel
onready var killCountLabel = $KillCount/KillCountLabel

onready var max_health;
onready var health;

onready var max_stamina;
onready var stamina;

onready var max_mana;
onready var mana;

func _ready():
	setHealthBar()
	setStaminaBar()
	setManaBar()

func _on_Stats_health_changed():
	updateHealthBar()

func _process(delta):
	updateHealthBar()
	updateStaminaBar()
	updateManaBar()
	setKillCount()

func setHealthBar():
	if(is_instance_valid(stats)):
		max_health = stats.max_health;
		health = stats.health;
		healthBar.max_value = max_health;
		healthBar.value = health;
		healthBarLabel.text = str(health) + "/" + str(max_health)

func updateHealthBar():
	health = int(stats.health);
	healthBar.value = health;
	healthBarLabel.text = str(health) + "/" + str(max_health)

func setStaminaBar():
	if(is_instance_valid(stats)):
		max_stamina = stats.max_stamina;
		stamina = stats.stamina;
		staminaBar.max_value = max_stamina;
		staminaBar.value = stamina;
		staminaBarLabel.text = str(stamina) + "/" + str(max_stamina)

func updateStaminaBar():
	stamina = int(stats.stamina);
	staminaBar.value = stamina;
	staminaBarLabel.text = str(stamina) + "/" + str(max_stamina);

func setManaBar():
	if(is_instance_valid(stats)):
		max_mana = stats.max_mana;
		mana = stats.mana;
		manaBar.max_value = max_mana;
		manaBar.value = mana;
		manaBarLabel.text = str(mana) + "/" + str(max_mana)

func updateManaBar():
	mana = int(stats.mana);
	manaBar.value = mana;
	manaBarLabel.text = str(mana) + "/" + str(max_mana);

func setKillCount():
	if(is_instance_valid(player.weapon.weapon)):
		killCountLabel.text = str(player.weapon.weapon.killCount);



