extends Enemy

@onready var timer: Timer = $Timer
var ready_to_jump = true
var was_on_floor = false

func _ready() -> void:
	super._ready()
	position = startPosition
	timer.timeout.connect(_on_timer_timeout)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	var now_on_floor = is_on_floor();
	if now_on_floor and not was_on_floor and ready_to_jump:
		ready_to_jump = false
		velocity.x = 0
		timer.start()
	if ready_to_jump:
		velocity.x = flipSpawn * speed
		if not is_on_floor():
			velocity += get_gravity() * delta
		else:
			velocity -= get_gravity() * delta * 50
	was_on_floor = now_on_floor

	if flipSpawn * (position.x - endPosition.x) > 0:
		print("freed")
		queue_free()

func _on_timer_timeout():
	ready_to_jump = true
