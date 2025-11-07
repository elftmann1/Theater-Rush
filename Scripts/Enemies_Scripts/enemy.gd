class_name Enemy extends CharacterBody2D

signal _player_hit(collision_name : String, damage : float)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var GET_SCREEN_WIDTH: float
var GET_SCREEN_WIDTH_LEFT: float
var GET_SCREEN_WIDTH_RIGHT: float
var spawnPosition = null
var spawnPositionVector: Vector2
var flipSpawn: int = 1

var body_collied_with : Node2D
var is_collied_hitbox : bool = false

var startPosition: Vector2
var endPosition: Vector2
var time: float = 0

@export var speed: float = 0
@export var damage: float = 0
@export var attack_delay: int = 10

@onready var sprite = $Sprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var collisionHitBox : Area2D = $HitBoxArea2d

func _ready() -> void:
	GET_SCREEN_WIDTH = get_viewport_rect().size.x
	GET_SCREEN_WIDTH_LEFT = -get_viewport_rect().size.x / 2
	GET_SCREEN_WIDTH_RIGHT = get_viewport_rect().size.x / 2
	if spawnPosition == SpawnPosition.GROUNDLEFT:
		sprite.flip_h = true
		startPosition = Vector2(GET_SCREEN_WIDTH_LEFT, 284.84 - ((collision.scale.y / 2) / 0.05))
		endPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, 284.84 - ((collision.scale.y / 2) / 0.05))
	elif spawnPosition == SpawnPosition.GROUNDRIGHT:
		flipSpawn = -1
		sprite.flip_h = false
		startPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, 284.84 - ((collision.scale.y / 2) / 0.05))
		endPosition = Vector2(GET_SCREEN_WIDTH_LEFT, 284.84 - ((collision.scale.y / 2) / 0.05))
	elif spawnPosition == SpawnPosition.TOPLEFT:
		sprite.flip_h = true
		startPosition = Vector2(GET_SCREEN_WIDTH_LEFT, -60)
		endPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, -60)
	elif spawnPosition == SpawnPosition.TOPRIGHT:
		flipSpawn = -1
		sprite.flip_h = false
		startPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, -60)
		endPosition = Vector2(GET_SCREEN_WIDTH_LEFT, -60)
	elif spawnPosition == SpawnPosition.MIDDLE:
		startPosition = Vector2(0, 0)
	elif spawnPosition == SpawnPosition.LEFT:
		scale.x = 1
		startPosition = Vector2(GET_SCREEN_WIDTH_LEFT, 0)
	elif spawnPosition == SpawnPosition.RIGHT:
		scale.x = -1
		startPosition = Vector2(GET_SCREEN_WIDTH_RIGHT, 0)

func _physics_process(_delta: float) -> void:
	move_and_slide()
	if is_collied_hitbox:
		_player_hit.emit(body_collied_with.name, damage)

func get_screen_width_left():
	return GET_SCREEN_WIDTH_LEFT

func get_screen_width_right():
	return GET_SCREEN_WIDTH_RIGHT

func get_attack_delay() -> int:
	return attack_delay

func set_attack_delay(delay : int):
	attack_delay = delay

func _on_hit_box_area_body_entered(body: Node2D) -> void:
	body_collied_with = body
	is_collied_hitbox = true

func _on_hit_box_area_body_exited(body: Node2D) -> void:
	is_collied_hitbox = false
