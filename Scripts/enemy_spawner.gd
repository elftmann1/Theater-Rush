extends Node

signal enmey_hit_player(collision_name : String, damage : int)

var knight_prefab = preload("res://Scenes/Inherited_Enemies/Knight.tscn")
var frog_prefab = preload("res://Scenes/Inherited_Enemies/frog.tscn")
var wizard_prefab = preload("res://Scenes/Inherited_Enemies/wizard.tscn")
@export var ground_offset = 284.84

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Down"):
		instantiate_enemy(knight_prefab.instantiate(), SpawnPosition.BOTTOMRIGHT)
	if Input.is_action_just_pressed("Up"):
		instantiate_enemy(frog_prefab.instantiate(), SpawnPosition.BOTTOMLEFT)
	if Input.is_action_just_pressed("SpawnWiz"):
		instantiate_enemy(wizard_prefab.instantiate(), SpawnPosition.MIDDLE)
			

func instantiate_enemy(prefab, spawnPosition):
	prefab.spawnPosition = spawnPosition
	add_child(prefab)
	prefab.player_hit.connect(func(collision_name, damage): enmey_hit_player.emit(collision_name, damage))
	print("Spawning?", prefab)
