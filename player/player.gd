extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $Player_AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var stats = PlayerStats

func _ready():
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", starting_direction)

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
		
	velocity = input_direction * move_speed
	
	update_animation_parameters(input_direction)
	
	move_and_slide()
	
	pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
	
