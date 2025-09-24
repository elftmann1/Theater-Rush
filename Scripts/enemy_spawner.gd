extends Node

var knight_prefab = preload("res://Scenes/Inherited_Enemies/Knight.tscn")
var frog_prefab = preload("res://Scenes/Inherited_Enemies/frog.tscn")
enum SpawnPosition { BOTTOMLEFT, BOTTOMRIGHT, TOPLEFT, TOPRIGHT}
@export var ground_offset = 284.84

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Up"):
		var knight = knight_prefab.instantiate()
		add_child(knight)
		print("Spawning?", knight)
	if Input.is_action_just_pressed("Left"):
		var frog = frog_prefab.instantiate()
		add_child(frog)
		print("Spawning?", frog)
