extends Area2D

var player = null

# if the collision shape of the detection enters the player's hitbox, call this function
func _on_body_entered(body):
	player = body

# call this function if the player's hitbox leaves the detection of this shape
func _on_body_exited(body):
	player = null
