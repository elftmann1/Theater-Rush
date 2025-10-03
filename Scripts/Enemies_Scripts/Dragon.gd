extends Enemy

@onready var breath_colision: CollisionPolygon2D = $CollisionPolygon2D
var is_emiting = false


var array1 := PackedVector2Array([
	Vector2(-10, -10),
	Vector2(-10, -10),
	Vector2(-10, -10)
])

var start_breath
var end_breath
var end_breath2

@export var inerpolated_weight := 0.0

func _ready() -> void:
	super._ready()
	position = startPosition
	start_breath = Vector2(-10, -10)
	end_breath = Vector2(20, get_viewport_rect().size.y)
	end_breath2 = Vector2(GET_SCREEN_WIDTH_RIGHT, get_viewport_rect().size.y)

func _physics_process(delta: float) -> void:
	if (is_emiting):
		# update interpolation factor
		inerpolated_weight += delta * 0.01
		inerpolated_weight = clamp(inerpolated_weight, 0, 1)

		# update polygon points
		array1[0] = start_breath.lerp(end_breath, inerpolated_weight)
		array1[1] = start_breath.lerp(end_breath2, inerpolated_weight)
		array1[2] = start_breath # keep the third point connected to start

		# assign updated polygon to collision
		breath_colision.polygon = array1

		print(array1)

func emit_fire_breath() -> void:
	is_emiting = true
