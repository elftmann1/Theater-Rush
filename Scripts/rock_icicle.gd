extends Area2D

func _on_body_entered(body: Node) -> void:
	if body.has_method("has_died"):
		print("fruit get")
		GameManager.add_score(1)
		queue_free()
