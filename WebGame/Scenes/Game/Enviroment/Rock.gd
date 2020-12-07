extends RigidBody2D

signal damage(dmg)

var rock_scale = 4
var fracture_count := 2

func _ready():
	get_node("CollisionShape2D").scale = Vector2(rock_scale, rock_scale)
	get_node("asteroid_001").scale = Vector2(rock_scale, rock_scale)
	
func on_death():
	Score.emit_signal("score_event", 'asteroid_destroy')
	if fracture_count > 0:
		for i in range(rand_range(1,3)):
			var a = duplicate()
			a.get_node("Health").value = 10
			a.global_transform = global_transform
			a.rock_scale = self.rock_scale / 2
			a.fracture_count = fracture_count - 1
			get_parent().call_deferred('add_child', a)
