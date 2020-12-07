extends "res://Scenes/Game/ShipAI.gd"

var mouse_control = true

func _process(delta):
	if mouse_control and get_parent().is_in_group('player'):
		var md = get_parent().get_local_mouse_position().normalized().rotated(PI/2)
		var a = atan2(md.y, md.x)
		
		#get_parent().rotation = a
		
		output.x = md.x
		output.y = 1 if Input.is_action_pressed("thrust") else 0
		if output.y <= 0:
			output.x = sign(output.x)
	else:
		output.x = int(Input.is_action_pressed('turn_left')) - int(Input.is_action_pressed('turn_right'))
		output.y = int(Input.is_action_pressed('thrust')) - int(Input.is_action_pressed('brake'))
	
	output.fire = Input.is_action_pressed("fire")
	output.shield = Input.is_action_pressed("shield")
	output.strafe = Input.is_action_pressed("strafe")
