extends Node

var rock_prefab = preload("res://Scenes/RockIcicle.tscn")
@export var number_of_rocks: int = 2
@onready var rock_instance : Array = []
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

	for i in range(number_of_rocks):
		var rock = rock_prefab.instantiate()
		rock.position = Vector2(randi_range(-400, 400), -430)
		add_child(rock)
		rock_instance.append(rock)
		rock.tree_exited.connect(func():
			rock_instance.erase(rock)
			if rock_instance.is_empty():
				is_spawning_rocks = false	
		)

func _on_game_manager_start_game() -> void:
	game_started = true


func _on_player_player_died() -> void:
	game_started = false
