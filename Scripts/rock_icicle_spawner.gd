extends Node

var fruit_prefab = preload("res://Scenes/RockIcicle.tscn")

@export var spawn_interval: float = 0.8
@export var pattern_points: Array[int] = [-530, -300, -100, 100, 300, 530, 300, 100, -100, -300]
@export var fruit_y_start: float = -430

var pattern_index := 0
var game_started := false

@onready var timer = $Timer

func _ready():
	GameManager.start_game.connect(_on_game_manager_start_game)
	GameManager.player_died.connect(_on_player_player_died)
	timer.wait_time = spawn_interval
	timer.timeout.connect(spawn_fruit_pattern)

func spawn_fruit_pattern() -> void:
	var fruit = fruit_prefab.instantiate()
	var x_pos = pattern_points[pattern_index]
	fruit.position = Vector2(x_pos, fruit_y_start)
	add_child(fruit)

	pattern_index = (pattern_index + 1) % pattern_points.size()

func _on_game_manager_start_game() -> void:
	game_started = true
	pattern_index = 0
	timer.start()

func _on_player_player_died() -> void:
	game_started = false
	timer.stop()
