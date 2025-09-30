extends Enemy

var emit_fire_ball_time = 2

func _ready() -> void:
	super._ready()
	position = startPosition

func emit_fire_ball(casting : String):
	print(casting)

func emit_lighting():
	pass