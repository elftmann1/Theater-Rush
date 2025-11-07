extends Enemy

var isDiving: bool = false
var current_player_pos : Vector2
var target_rot : float = 36
func _ready() -> void:
	super._ready()
	position = startPosition
	target_rot = deg_to_rad(target_rot)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if isDiving:
		speed = 700
	velocity.x = flipSpawn * speed
		#rotation = move_toward(rotation, 36, delta * 10)
		#pass

	if flipSpawn * (position.x - endPosition.x) > 0:
		print("freed")
		queue_free()


func dive() -> void:
	await get_tree().create_timer(1).timeout;
	current_player_pos = Global.player.position
	current_player_pos.y -= 60
	var get_current_side = get_screen_width_right()
	var angle = 80
	if flipSpawn == -1:
		get_current_side = get_screen_width_left()
		angle = -80
	print(rad_to_deg(target_rot))
	var tween = create_tween()
	var tween1 = create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(angle), 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween1.parallel().tween_property(self, "position:x", get_current_side, 1.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween1.parallel().tween_property(self, "position:y", current_player_pos.y, 1.5).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation", 0, 0.75).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	isDiving = true
