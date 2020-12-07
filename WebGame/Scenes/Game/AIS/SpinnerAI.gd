extends "res://Scenes/Game/ShipAI.gd"

onready var target = get_tree().get_nodes_in_group('player')[0]

onready var ship = get_parent()

onready var dir = 1 if randf() < 0.5 else -1

func _ready():
	print('== spinner spawned ==')

func _process(delta):
	if not ship:
		ship = get_parent()
		print('ai node: %s, is unable to find parent' % self)
		return
	if not target: return
	
	var lp = ship.to_local(target.global_position).normalized().rotated(PI/2)
	output.x = dir as float
	output.y = lp.y
	
	output.fire = true
	
	if ship.global_position.distance_to(target.global_position) < 100:
		output.y = -output.y
	
