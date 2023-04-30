extends Node

@onready var black = $BlackOverlay
@onready var sleep = $Sleeping
@onready var game_over = $GameOver
@onready var button = $Button

var new_pause_state = false

func pause():
	new_pause_state = true
	get_tree().paused = new_pause_state
	black.visible = new_pause_state
	sleep.visible = new_pause_state
	game_over.visible = new_pause_state
	button.visible = new_pause_state

func unpause():
	new_pause_state = false
	get_tree().paused = new_pause_state
	black.visible = false
	sleep.visible = false
	game_over.visible = false
	button.visible = false
	
func _ready():
	unpause()
	PlayerStats.no_health.connect(pause)
	sleep.play("animate")

func _on_button_pressed():
	PlayerStats.health = 3
	PlayerStats.score = 0
	unpause()
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
