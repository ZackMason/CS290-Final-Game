extends TextureButton

func _on_Close_button_up():
	get_tree().change_scene("res://Scenes/UI/StartScreen.tscn")

func _on_Fullscreen_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		print('fullscreen')
		OS.window_fullscreen = !OS.window_fullscreen
