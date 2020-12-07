extends Node2D

signal new_wave

onready var _rock = preload("res://Scenes/Game/Enviroment/Rock.tscn")
onready var _enemy_prefabs = {
	'grunt': preload("res://Scenes/Game/Ships/Grunt.tscn"),
	'spinner': preload("res://Scenes/Game/Ships/Spinner.tscn")
}

func _on_spawn_enemies(count):
	for i in range(count):
		var s = _enemy_prefabs['grunt' if randf() < 0.17 else 'spinner'].instance()
		s.add_to_group('enemy')
		$Enemies.add_child(s)
		s.global_position.x = rand_range(-1000,1000)
		s.global_position.y = rand_range(-1000,1000)
		s.global_rotation = rand_range(-1000,1000)

func _ready():
	randomize()
	
	WaveManager.connect('spawn_enemies', self, '_on_spawn_enemies')
	connect('new_wave', WaveManager, '_on_new_wave')
	
	WaveManager.emit_signal('spawn_enemies', 1)
	
	# spawn asteroid
	for i in range(30):
		var r = _rock.instance();
		add_child(r)
		r.global_position.x = rand_range(-1000,1000)
		r.global_position.y = rand_range(-1000,1000)
		r.global_rotation = rand_range(-1000,1000)

func _process(delta):
	if get_tree().get_nodes_in_group('enemy').empty():
		emit_signal("new_wave")
		Score.emit_signal('score_event', 'wave_completed')

	if get_tree().get_nodes_in_group('player').empty():
		WaveManager.wave = 1
		get_tree().change_scene("res://Scenes/UI/ScoreScreen.tscn")
