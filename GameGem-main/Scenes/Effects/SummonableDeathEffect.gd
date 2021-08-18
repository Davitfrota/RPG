extends AnimatedSprite

onready var nameLabel = $NameLabel
onready var subject = get_parent();


func _ready():
	#Label conter o nome do respectivo inimigo.
	if(subject.is_in_group("Enemy")):
		nameLabel.text = subject.enemyAttributes.enemyName;

func _on_Label_mouse_entered():
	nameLabel.visible = true;
	print("Mouse Entered");


func _on_NameLabel_mouse_exited():
	nameLabel.visible = false;
	print("Mouse Exited");
