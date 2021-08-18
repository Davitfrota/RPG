extends StaticBody2D

var flip = true
var Pi
var Pf

func _ready():
	Pi = $".".position.x
	Pf = Pi + 500
func _process(delta):

	if(Pi <= Pf and flip):
		$".".position.x -= 0.1
		$MonsterFly.flip_h = false
		if($".".position.x >= Pf):
			flip = false
			
	if($".".position.x >= Pi and !flip):
		$".".position.x += 0.1
		$MonsterFly.flip_h = true
		if($".".position.x <= Pi):
			flip = true
			
