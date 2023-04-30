extends Node

@onready var black = $BlackOverlay
@onready var sprite = $AnimatedSprite2D
@onready var paused = $Paused
@onready var resume = $Resume
@onready var retry = $Retry

var new_pause_state = false

func _ready():
	unpause()
	sprite.play("animation")

func unpause():
	new_pause_state = false
	get_tree().paused = new_pause_state
	black.visible = new_pause_state
	sprite.visible = new_pause_state
	paused.visible = new_pause_state
	resume.visible = new_pause_state
	retry.visible = new_pause_state
	
func pause():
	new_pause_state = true
	get_tree().paused = new_pause_state
	black.visible = new_pause_state
	sprite.visible = new_pause_state
	paused.visible = new_pause_state
	resume.visible = new_pause_state
	retry.visible = new_pause_state

func _input(event):
	if event.is_action_pressed("pause"):
		pause()

func _on_resume_pressed():
	unpause()

func _on_retry_pressed():
	PlayerStats.health = 3
	PlayerStats.score = 0
	unpause()
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")
