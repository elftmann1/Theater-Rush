extends Enemy

func _ready() -> void:
	super._ready()
	position = startPosition

func emit_fire_ball(casting: String):
	print(casting)

func emit_lighting():
	pass