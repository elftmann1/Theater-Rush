extends Enemy

@onready var breath_colision: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var breath_colision_area: Area2D = $Area2D
var is_flame_expanding = false
var is_flame_retracting = false

var lerpedBreathValues := PackedVector2Array([
	Vector2(0, 0),
	Vector2(0, 0),
	Vector2(0, 0)
])

var start_breath
var end_breath
var end_breath2
var start_to_end_breath

var flameLerpingTime : float = 0.0
@export var flameExpandTime : float = 3.0
@export var flameRetractTime : float = 3.0
@export var flameToGround : float = 15

func _ready() -> void:
	super._ready()
	breath_colision.disabled = true
	position = startPosition
	start_breath = Vector2(0, 0)
	end_breath = Vector2(0, flameToGround)
	end_breath2 = Vector2(25, flameToGround)
	start_to_end_breath = Vector2((end_breath.x + end_breath2.x)/2, flameToGround)

func _physics_process(delta: float) -> void:
	if is_flame_expanding:
		lerpedBreathValues[0] = start_breath.lerp(end_breath, flameLerpingTime)
		lerpedBreathValues[1] = start_breath.lerp(end_breath2, flameLerpingTime)
		breath_colision.polygon = lerpedBreathValues
	if is_flame_retracting:
		lerpedBreathValues[2] = start_breath.lerp(start_to_end_breath, flameLerpingTime)
		breath_colision.polygon = lerpedBreathValues
	#print(lerpedBreathValues)

func emit_fire_breath() -> void:
	# Start emitting flame
	is_flame_expanding = true
	breath_colision.disabled = false
	var flameExpandTween : Tween = get_tree().create_tween()
	flameExpandTween.tween_property(self, "flameLerpingTime", 1.0, flameExpandTime)

	await flameExpandTween.finished
	lerpedBreathValues[0] = end_breath
	lerpedBreathValues[1] = end_breath2
	is_flame_expanding = false	
	
	# hold flame breath
	await get_tree().create_timer(attack_delay - (flameExpandTime + flameRetractTime)).timeout

	# Start retracting flame
	flameLerpingTime = 0
	is_flame_retracting = true
	var flameRetractTween : Tween = get_tree().create_tween()
	flameRetractTween.tween_property(self, "flameLerpingTime", 1.0, flameRetractTime)

	await flameRetractTween.finished
	lerpedBreathValues[2] = start_to_end_breath
	is_flame_retracting = false	
	breath_colision.disabled = true

func _on_area_fire_breath_entered(body: Node2D) -> void:
	pass # Replace with function body.
