extends Node

signal enmey_hit_player(collision_name: String, damage: float)

var knight_prefab = preload("res://Scenes/Inherited_Enemies/Knight.tscn")
var frog_prefab = preload("res://Scenes/Inherited_Enemies/frog.tscn")
var wizard_prefab = preload("res://Scenes/Inherited_Enemies/wizard.tscn")
var dragon_prefab = preload("res://Scenes/Inherited_Enemies/dragon.tscn")
@export var ground_offset = 284.84

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Down"):
		instantiate_enemy(knight_prefab.instantiate(), SpawnPosition.GROUNDRIGHT)
	if Input.is_action_just_pressed("Up"):
		instantiate_enemy_with_positions(frog_prefab.instantiate(), Vector2(500, 200), Vector2(-500, 200))
	if Input.is_action_just_pressed("SpawnWiz"):
		instantiate_enemy_with_tweens(wizard_prefab.instantiate(), SpawnPosition.RIGHT, -100, 500, "emit_fire_ball", ["casting"])
	if Input.is_action_just_pressed("spawnDragon"):
		instantiate_enemy_with_tweens(dragon_prefab.instantiate(), SpawnPosition.LEFT, -100, 500, "emit_fire_breath", [])
			

func instantiate_enemy(prefab, spawnPosition):
	prefab.spawnPosition = spawnPosition
	add_child(prefab)
	prefab._player_hit.connect(func(collision_name, damage): enmey_hit_player.emit(collision_name, damage))
	print("Spawning?", prefab)

func instantiate_enemy_with_positions(prefab, startPosition: Vector2, endPosition: Vector2):
	prefab.startPosition = startPosition
	prefab.endPosition = endPosition
	add_child(prefab)
	if prefab.startPosition.x - prefab.endPosition.x > 0:
		prefab.flipSpawn = -1
		prefab.get_node("Sprite2D").flip_h = false
	else:
		prefab.speed *= -1
		prefab.get_node("Sprite2D").flip_h = false
	prefab._player_hit.connect(func(collision_name, damage): enmey_hit_player.emit(collision_name, damage))
	print("Spawning?", prefab)

func instantiate_enemy_with_tweens(prefab, spawnPosition, heightSpawnPosition: float, distance: float, attack_name: String, attack_args: Array):
	print("Spawning?", prefab)
	prefab.spawnPosition = spawnPosition
	add_child(prefab)
	prefab.position.y = heightSpawnPosition
	prefab._player_hit.connect(func(collision_name, damage): enmey_hit_player.emit(collision_name, damage))
	var tween := get_tree().create_tween()
	tween.tween_property(prefab, "position:x", prefab.flipSpawn * distance, 2).as_relative()
	if (attack_args.size() == 0):
		tween.tween_callback(Callable(prefab, attack_name))
	else:
		tween.tween_callback(Callable(prefab, attack_name).bindv(attack_args))
	tween.tween_interval(prefab.get_attack_delay())
	tween.tween_property(prefab, "position:x", prefab.flipSpawn * -distance, 2).as_relative()
	tween.tween_callback(Callable(prefab, "queue_free"))
