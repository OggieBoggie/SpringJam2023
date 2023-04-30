extends CharacterBody2D

@export var move_speed : float = 100
@export var dash_velocity : float
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $Player_AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var hurtbox = $Hurtbox
@onready var sprite = $Sprite2D
@onready var timer = $Transparent
@onready var detection = $Detection/DetectPlayer
@onready var dash_timer = $Dash_Timer
@onready var dash_cooldown = $Dash_Cooldown
@onready var current_level = 0

enum {
	Walk,
	Water
}

var stats = PlayerStats
var state = Walk
var acceleration : float
var can_dash : bool = true

func _ready():
	stats.no_health.connect(queue_free)
	stats.winning.connect(change_scene)
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", starting_direction)
	acceleration = move_speed

func _physics_process(delta):
	if (Input.is_action_just_pressed("Dash") and can_dash):
		dash_state()
	
	match state:
		Walk:
			move_state()
		Water:
			water_state()

func move_state():
	var input_direction = Input.get_vector("left", "right", "up", "down")
		
	velocity = input_direction * acceleration
	
	update_animation_parameters(input_direction)
	
	move_and_slide()
	
	pick_new_state()
	
	if (Input.is_action_just_pressed("water")):
		state = Water

func water_state():
	state_machine.travel("Water")

func water_finished():
	state = Walk

func _on_hurtbox_area_entered(area):
	stats.health -= 1
	sprite.modulate.a = 0.5
	hurtbox.start_invincibility(5)
	detection.set_deferred("disabled", true)
	timer.start(5)

func _on_transparent_timeout():
	sprite.modulate.a = 1
	detection.set_deferred("disabled", false)

func dash_state():
	sprite.modulate.a = 0.5
	hurtbox.start_invincibility(0.5)
	timer.start(0.5)
	can_dash = false
	acceleration = dash_velocity
	dash_timer.start()

func _on_dash_timer_timeout():
	acceleration = move_speed
	state = Walk
	dash_cooldown.start()

func _on_dash_cooldown_timeout():
	can_dash = true

func change_scene():
	if (get_tree().current_scene.name == "level0"):
		get_tree().change_scene_to_file("res://Levels/level_1.tscn")
	elif (get_tree().current_scene.name == "level1"):
		get_tree().change_scene_to_file("res://Levels/level_2.tscn")
	elif (get_tree().current_scene.name == "level2"):
		get_tree().change_scene_to_file("res://Levels/level_3.tscn")
	elif (get_tree().current_scene.name == "level3"):
#		get_tree().change_scene_to_file("res://Levels/level_4.tscn")
#	elif (get_tree().current_scene.name == "level4"):
		get_tree().change_scene_to_file("res://Levels/level_5.tscn")
	elif (get_tree().current_scene.name == "level5"):
		get_tree().change_scene_to_file("res://UI/winner.tscn")
		
		
func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Water/blend_position", move_input)

func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
