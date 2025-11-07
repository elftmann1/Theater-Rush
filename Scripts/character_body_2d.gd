extends CharacterBody2D

signal is_moving
signal player_died
@export var speed: int = 100
@export var health: float = 3
@export var dash_speed: int = 10000
@export var score: int = 0
@onready var timer: Timer = $Timer
@export var gravity: int = 900
@export var jump_force: int = -600

func _ready():
	while isMoving():
		await get_tree().process_frame
	is_moving.emit()

func _physics_process(delta: float) -> void:
	if timer.is_stopped() and Input.is_action_just_pressed("Dash"):
		velocity.x = Input.get_axis("Left", "Right") * dash_speed
		print("dash")
		timer.start()
	else:
		if not is_on_floor():
			velocity.y += gravity * delta
			if Input.is_action_pressed("Down"):
				velocity.y += speed * 10 * delta
				# velocity.y *= -speed * .001 # save for slow fall ability
				
		else:
		# Jump
			if Input.is_action_just_pressed("Up"):
				velocity.y = jump_force
			

		# Left/right movement
		velocity.x = Input.get_axis("Left", "Right") * speed

	move_and_slide()

func has_died() -> void:
	print("has died")
	player_died.emit()
	queue_free()

func isMoving():
	GameManager.start_game.emit()
	return velocity.x < 0.1

func _on_enmey_hit_player(collision_name: String, damage: float) -> void:
	if (name == collision_name):
		print(name, damage)
