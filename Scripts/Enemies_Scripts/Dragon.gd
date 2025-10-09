extends Enemy

@onready var breath_colision: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var breath_colision_area: Area2D = $Area2D
@onready var flame_on: GPUParticles2D = $GPUParticles2D
@onready var smoke_on: GPUParticles2D = $SmokeParticles
var is_collied_flame_hitbox = false
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

var flameLerpingTime: float = 0.0
@export var flameDamage: float = 3.0
@export var flameExpandTime: float = 1
@export var flameRetractTime: float = 1.5
@export var flameToGround: float = 15
@export var smokeWaitTime: float = 3.0

func _ready() -> void:
	super._ready()
	breath_colision.disabled = true
	position = startPosition
	start_breath = Vector2(0, 0)
	end_breath = Vector2(0, flameToGround)
	end_breath2 = Vector2(25, flameToGround)
	start_to_end_breath = Vector2((end_breath.x + end_breath2.x) / 2, flameToGround)
	flame_on.emitting = false
	smoke_on.emitting = false

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)
	if is_flame_expanding:
		lerpedBreathValues[0] = start_breath.lerp(end_breath, flameLerpingTime)
		lerpedBreathValues[1] = start_breath.lerp(end_breath2, flameLerpingTime)
		breath_colision.polygon = lerpedBreathValues
	if is_flame_retracting:
		lerpedBreathValues[2] = start_breath.lerp(start_to_end_breath, flameLerpingTime)
		breath_colision.polygon = lerpedBreathValues
	if is_collied_flame_hitbox:
		_player_hit.emit(body_collied_with.name, flameDamage)
	#print(lerpedBreathValues)

func emit_fire_breath() -> void:
	# Start emitting flame	
	smoke_on.emitting = true
	await get_tree().create_timer(smokeWaitTime).timeout
	smoke_on.emitting = false
	is_flame_expanding = true
	breath_colision.disabled = false
	var flameExpandTween: Tween = get_tree().create_tween()
	flameExpandTween.tween_property(self, "flameLerpingTime", 1.0, flameExpandTime)
	flame_on.emitting = true

	await flameExpandTween.finished
	lerpedBreathValues[0] = end_breath
	lerpedBreathValues[1] = end_breath2
	is_flame_expanding = false

	# hold flame breath
	await get_tree().create_timer((attack_delay - smokeWaitTime) - (flameExpandTime + flameRetractTime)).timeout

	# Start retracting flame
	flameLerpingTime = 0
	is_flame_retracting = true
	var flameRetractTween: Tween = get_tree().create_tween()
	flameRetractTween.tween_property(self, "flameLerpingTime", 1.0, flameRetractTime)
	flame_on.emitting = false

	await flameRetractTween.finished
	lerpedBreathValues[2] = start_to_end_breath
	is_flame_retracting = false
	breath_colision.disabled = true

func _on_area_fire_breath_entered(body: Node2D) -> void:
	# print(body.name)
	body_collied_with = body
	is_collied_flame_hitbox = true

func _on_area_fire_breath_exited(body: Node2D) -> void:
	is_collied_flame_hitbox = false
