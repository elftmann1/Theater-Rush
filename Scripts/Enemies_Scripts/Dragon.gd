extends Enemy

var breath_colision
func _ready() -> void:
	super._ready()
	position = startPosition

func emit_fire_breath(casting: String):
	print(casting)
