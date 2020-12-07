extends "res://Scenes/Game/ShipAI.gd"

onready var target = get_tree().get_nodes_in_group('player')[0]

onready var ship = get_parent()

func _process(delta):
	if not ship:
		ship = get_parent()
		print('ai node: %s, is unable to find parent' % self)
		return
	if not target: return
	
	var lp = ship.to_local(target.global_position).normalized().rotated(PI/2)
	output.x = lp.x
	output.y = lp.y
	output.fire = output.y > 0.8
	
	if ship.global_position.distance_to(target.global_position) < 100:
		#output.x = -output.x
		output.y = -output.y
	
