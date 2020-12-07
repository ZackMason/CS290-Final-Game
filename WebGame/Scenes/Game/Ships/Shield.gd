extends Area2D

var on = false

func _on_Area2D_area_entered(area):
	if area.is_in_group('bullet') and on:
		area.queue_free()

