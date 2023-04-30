extends Area2D

var player = null

func can_see_player():
	return player != null

func _on_area_exited(area):
	print("Bye")
	player = null

func _on_area_entered(area):
	print("Hello")
	player = area
