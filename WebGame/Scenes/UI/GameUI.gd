extends Control

export(NodePath) var player_path = null
onready var _player = get_node(player_path)

func _on_player_damaged(damage):
	if not _player: return
	$HBoxContainer/Health.value = _player.get_node('Health').value

func _ready():
	_player.connect('damage', self, '_on_player_damaged')
	_on_player_damaged(0)


func _process(delta):
	if not _player: return
	$HBoxContainer/Shield.value = _player.power
