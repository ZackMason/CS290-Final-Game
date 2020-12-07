extends Node

signal spawn_enemies(count)

export (int) var wave = 1
export (int) var spawn_count = 1

func fib(n):
	if n <= 1: return 1
	return fib(n-1) + fib(n-2)

func _on_new_wave():
	print('=== Starting wave: %d' % wave)
	wave += 1
	spawn_count = fib(wave)
	emit_signal('spawn_enemies', spawn_count)
