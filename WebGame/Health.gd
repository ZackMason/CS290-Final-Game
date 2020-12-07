extends Node

var shield := false
export (int) var value = 10

func _on_damage(dmg):
	if shield: return
	value -= dmg
	if value <= 0.0:
		if get_parent().has_method('on_death'):
			get_parent().call('on_death')
		get_parent().queue_free()

func _ready():
	get_parent().add_to_group('health')
	get_parent().connect('damage', self, '_on_damage')
