extends Area2D

export (float) var speed = 1000.0

onready var _explosion = preload("res://Scenes/Game/Explosion.tscn")

func _ready():
	randomize()
	$Timer.start()

func _physics_process(delta):
	position += (Vector2.RIGHT.rotated(global_rotation) * speed * delta)


func _on_Timer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	if body.is_in_group('health'):
		body.emit_signal('damage', 1)
	
	var e = _explosion.instance()
	e.global_position = global_position
	e.global_rotation = rand_range(0, 1000)
	get_parent().add_child(e)
	queue_free()
