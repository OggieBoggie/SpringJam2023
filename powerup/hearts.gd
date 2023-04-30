extends Area2D

var stats = PlayerStats

func _on_body_entered(body):
	stats.health += 1
	queue_free()
