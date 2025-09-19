extends CharacterBody2D
@export var speed: int = 100
func _process(delta: float) -> void:
	velocity.x = Input.get_axis("Left","Right") * speed
	velocity.y = Input.get_axis("Up","Down") * speed
	velocity.y -= -9
	
	move_and_slide()
	
