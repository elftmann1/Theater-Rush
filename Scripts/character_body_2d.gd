extends CharacterBody2D

signal is_moving
signal player_died
@export var speed: float = 28.0
@export var health: float = 3.0
@export var dash_speed: int = 10000
@onready var timer: Timer = $Timer
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	Global.player = self
	animated_sprite.play("Idle")
	while isMoving():
		await get_tree().process_frame
	is_moving.emit()

func _physics_process(delta: float) -> void:
	if timer.is_stopped() and Input.is_action_just_pressed("Dash"):
		velocity.x = Input.get_axis("Left","Right") * dash_speed
		print("dash")
		timer.start()
	else:
		velocity.x = Input.get_axis("Left","Right") * speed
		print(velocity.x)
	velocity.y -= -9
	if velocity.x >= 0.1:
		if animated_sprite.animation != "Walk":
			animated_sprite.play("Walk")
		animated_sprite.flip_h = false
	elif velocity.x <= -0.1:
		if animated_sprite.animation != "Walk":
			animated_sprite.play("Walk")
		animated_sprite.flip_h = true
	else:
		animated_sprite.play("Idle")
	move_and_slide()

func has_died() -> void:
	print("has died")
	player_died.emit()
	queue_free()

func isMoving():
	return abs(velocity.x) < 0.1

func _on_enmey_hit_player(collision_name : String, damage : float) -> void:
	if (name == collision_name):
		print(name, damage)
		
