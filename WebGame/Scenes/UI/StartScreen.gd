extends Control

func _on_PlayButton_button_up():
	get_tree().change_scene("res://Scenes/Levels/World.tscn")


func _on_ControlsButton_button_up():
	get_tree().change_scene("res://Scenes/UI/Controls.tscn")


func _on_SettingsButton_button_up():
	get_tree().change_scene("res://Scenes/UI/Settings.tscn")
