extends Enemy

func _ready() -> void:
	super._ready()
	position = startPosition

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if not is_on_floor():
		velocity += get_gravity() * delta
