class_name Enemy extends CharacterBody2D

signal player_hit(collision_name, damage)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var GET_SCREEN_WIDTH : float
var GET_SCREEN_WIDTH_LEFT : float
var GET_SCREEN_WIDTH_RIGHT : float
var spawnPosition = null
var spawnPositionVector : Vector2
var flipSpawn : int = 1

var startPosition : Vector2
var endPosition : Vector2
var time : float = 0

@export var speed : float = 0
@export var damage : float = 0

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready() -> void:
	GET_SCREEN_WIDTH = get_viewport_rect().size.x
	GET_SCREEN_WIDTH_LEFT = -(get_viewport_rect().size.x / 2)
	GET_SCREEN_WIDTH_RIGHT = get_viewport_rect().size.x / 2
	if spawnPosition == SpawnPosition.GROUNDLEFT:
		sprite.flip_h = true
		startPosition = Vector2(GET_SCREEN_WIDTH_LEFT, 284.84 - ((collision.scale.y/2) / 0.05))
		endPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, 284.84 - ((collision.scale.y/2) / 0.05))
	elif spawnPosition == SpawnPosition.GROUNDRIGHT:
		flipSpawn = -1
		sprite.flip_h = false
		startPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, 284.84 - ((collision.scale.y/2) / 0.05))
		endPosition = Vector2(GET_SCREEN_WIDTH_LEFT, 284.84 - ((collision.scale.y/2) / 0.05))
	elif spawnPosition == SpawnPosition.MIDDLE:
		startPosition = Vector2(0,0)
	elif spawnPosition == SpawnPosition.LEFT:
		sprite.flip_h = false
		startPosition = Vector2(GET_SCREEN_WIDTH_LEFT,0)
	elif spawnPosition == SpawnPosition.RIGHT:
		sprite.flip_h = true
		flipSpawn = -1
		startPosition = Vector2(GET_SCREEN_WIDTH_RIGHT,0)

func _physics_process(delta: float) -> void:

	move_and_slide()

	for i in get_slide_collision_count():
		var collision_hit = get_slide_collision(i);
		if collision_hit.get_collider():
			player_hit.emit(collision_hit.get_collider().name, damage)
	# # Add the gravity.
	# if not is_on_floor():
	# 	velocity += get_gravity() * delta

	# # Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY

	# # Get the input direction and handle the movement/deceleration.
	# # As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)

	# move_and_slide()
func get_screen_width_left():
	return GET_SCREEN_WIDTH_LEFT

func get_screen_width_right():
	return GET_SCREEN_WIDTH_RIGHT


func collision_with_player():
	pass

func deal_damage():
	pass
