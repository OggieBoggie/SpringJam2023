extends Node

@onready var black = $BlackOverlay
@onready var win = $Win
@onready var happy = $Happy
@onready var button = $Button

var new_pause_state = true

# Called when the node enters the scene tree for the first time.
func _ready():
	happy.play("animate")
	get_tree().paused = new_pause_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func unpause():
	new_pause_state = false
	get_tree().paused = new_pause_state

func _on_button_pressed():
	PlayerStats.health = 3
	PlayerStats.score = 0
	unpause()
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
