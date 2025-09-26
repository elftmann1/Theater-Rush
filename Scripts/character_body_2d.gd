extends CharacterBody2D

signal is_moving
signal player_died
@export var speed: int = 100
@export var health: float = 3

func _ready():
	while isMoving():
		await get_tree().process_frame
	is_moving.emit()

func _process(delta: float) -> void:
	velocity.x = Input.get_axis("Left","Right") * speed
	velocity.y -= -9
	move_and_slide()

func has_died() -> void:
	print("has died")
	player_died.emit()
	queue_free()

func isMoving():
	return velocity.x < 0.1

func _on_enmey_hit_player(collision_name : String, damage : int) -> void:
	if (name == collision_name):
		print(name, damage)
