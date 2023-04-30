extends Node

@onready var black = $BlackOverlay
@onready var sleep = $Sleeping
@onready var game_over = $GameOver

func pause():
	print("Hello")
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	black.visible = new_pause_state
	sleep.visible = new_pause_state
	game_over.visible = new_pause_state

func _ready():
	PlayerStats.no_health.connect(pause)
	sleep.play("animate")
