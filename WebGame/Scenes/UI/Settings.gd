extends Control

var master_bus = AudioServer.get_bus_index('Master')
var sfx_bus = AudioServer.get_bus_index('SoundFX')
var music_bus = AudioServer.get_bus_index('Music')

func _on_Master_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)

func _on_SoundFX_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, value)

func _on_Music_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)

func _input(event):
	if Input.is_action_just_pressed("settings"):
		visible = false
