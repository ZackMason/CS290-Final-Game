tool
extends Sprite

func _ready():
	print('copyig mat')
	material = material.duplicate()

func _process(delta):
	get_material().set_shader_param("world_pos", global_position)
	global_rotation = 0
