extends Node

var rock_prefab = preload("res://Scenes/RockIcicle.tscn")
@export var number_of_rocks: int = 2
@onready var rock_instance : Array = []
@onready var rock_position_x : Array = []
var is_spawning_rocks = false
var game_started = false

func _physics_process(delta: float) -> void:
	if game_started:
		spawn_rock_icicle()

func spawn_rock_icicle() -> void:
	if is_spawning_rocks:
		return 
	is_spawning_rocks = true

	rock_instance.clear()
	rock_position_x.clear()

	for i in range(number_of_rocks):
		var rock = rock_prefab.instantiate()
		var rand_x = randi_range(-530, 530)
		rock.position = Vector2(rand_x, -430)
		rock_position_x.append(rand_x)
		add_child(rock)
		rock_instance.append(rock)
		rock.tree_exited.connect(func():
			rock_instance.erase(rock)
			rock_position_x.erase(rand_x)
			if rock_instance.is_empty():
				is_spawning_rocks = false	
		)

func _on_game_manager_start_game() -> void:
	game_started = true


func _on_player_player_died() -> void:
	game_started = false
