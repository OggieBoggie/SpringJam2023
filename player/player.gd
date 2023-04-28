extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $Player_AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var hurtbox = $Hurtbox
@onready var sprite = $Sprite2D

enum {
	Walk,
	Water,
	Dash
}

var stats = PlayerStats
var state = Walk

func _ready():
	stats.no_health.connect(queue_free)
	animation_tree.active = true
	animation_tree.set("parameters/Idle/blend_position", starting_direction)

func _physics_process(delta):
	match state:
		Walk:
			move_state()
		Water:
			water_state()
		Dash:
			pass
func move_state():
	var input_direction = Input.get_vector("left", "right", "up", "down")
		
	velocity = input_direction * move_speed
	
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

func dash_state():
	pass

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

