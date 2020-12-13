extends RigidBody2D

signal damage(dmg)

export(float) var TURN_SPEED = 2500
export(float) var THRUST_POWER = 10
export(float) var SHIELD_DRAIN = 3.0
export(float) var SHIELD_RESTORE = 1.0

onready var ai = $AI;
onready var _bullet = preload("res://Scenes/Game/Bullet.tscn")

var can_fire := true
var power := 100.0

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		if not is_in_group('player'):
			Score.emit_signal('score_event', 'enemy_kill')

func _ready():
	connect('damage', self, '_on_damaged')
	
	if not is_in_group('player'):
		set_collision_layer(2)

func _process(delta):
	set_applied_torque(ai.output.x * -TURN_SPEED)

	if not ai.output.strafe:
		apply_central_impulse(Vector2.RIGHT.rotated(global_rotation) * ai.output.y * THRUST_POWER)
		$ship_01/flame.visible = ai.output.y > 0.1
		$Smoke.emitting = ai.output.y > 0.1
		$CPUParticles2D.emitting = ai.output.y > 0.1
	else:
		set_linear_velocity(linear_velocity)

	if ai.output.fire and not ai.output.shield:
		fire()

	$Shield.on = ai.output.shield and power > 0.0
	$Shield.visible = ai.output.shield and power > 0.0
	$Health.shield = ai.output.shield and power > 0.0
	
	if ai.output.shield:
		power -= SHIELD_DRAIN * delta
	else:
		power += SHIELD_RESTORE * delta
	power = clamp(power, 0.0, 100.0)


func fire():
	if can_fire:
		can_fire = false
		for fp in $FiringPoints.get_children():
			var b = _bullet.instance()
			b.global_transform = fp.global_transform
			if is_in_group('player'):
				b.set_collision_mask_bit(1, true)
			else:
				b.set_collision_mask_bit(0, true)
			get_parent().add_child(b)
	elif $FireDelay.is_stopped():
		$FireDelay.start()

func _on_FireDelay_timeout():
	can_fire = true

func _on_damaged(damage):
	if $Shield.on: return
	$AnimationPlayer.play("hit")
