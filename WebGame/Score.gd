extends Node

signal score_event(name)

var points = 0

var point_table = {
	"enemy_kill": 100,
	"asteroid_destroy": 50,
	"wave_completed": 500,
}

func _ready():
	connect("score_event", self, '_on_score_event')
	
func _on_score_event(name):
	print("=== %d Points ===" %  point_table[name])
	points += point_table[name]

func restart():
	points = 0
