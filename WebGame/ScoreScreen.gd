extends Control

onready var input = $ColorRect/ColorRect/VBoxContainer/LineEdit

func _ready():
	$ColorRect/ColorRect2/VBoxContainer/ScoreLabel.text += str(Score.points)
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	
func _on_request_completed(result, response_code, headers, body):
	if result == HTTPRequest.RESULT_SUCCESS:
		restart_game()

func _on_Close_button_up():
	restart_game()

func _on_Okay_button_up():
	assert(input.text != "")
	
	var query = JSON.print({'name': input.text, 'score': Score.points})
	var headers = ["Content-Type: application/json"]
	var err = $HTTPRequest.request('http://localhost:8888/play.html', headers, false, HTTPClient.METHOD_POST, query)
	if err != OK:
		print('error sending score')
	
	
	
func restart_game():
	Score.restart()
	WaveManager.wave = 1
	get_tree().change_scene("res://Scenes/UI/StartScreen.tscn")
