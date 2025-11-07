extends RigidBody2D

func _ready() -> void:
	contact_monitor = true;
	max_contacts_reported = 1;

func _on_body_entered(body: Node) -> void:
	if body.has_method("has_died"):
		body.has_died();
		print("died");
	queue_free();
