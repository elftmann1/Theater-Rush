extends Enemy

var number_of_fireball = 3
var fireball = preload("res://Scenes/fireball.tscn")

func _ready() -> void: 
	super._ready()
	position = startPosition
	
func casting():
	print("fireball")
	var fireball = fireball.instantiate()
	add_child(fireball)
	fireball.position.y = -400
	
	var randomX = randi_range(get_screen_width_left(), get_screen_width_right())
	fireball.position.x = randomX

func emit_fireball():
	var tween := get_tree().create_tween().set_loops(number_of_fireball)
	tween.tween_callback(casting)
	tween.tween_interval(1)
	
