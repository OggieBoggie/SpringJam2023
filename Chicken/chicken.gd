extends CharacterBody2D

enum CHICKEN_STATE { IDLE, WALK, CHASE }

@export var move_speed : float = 50
@export var acceleration : float = 80
@export var idle_time : float = 5
@export var walk_time : float = 2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var player_detection = $PlayerDetection

var move_direction : Vector2 = Vector2.ZERO
var current_state : CHICKEN_STATE = CHICKEN_STATE.IDLE

func _ready():
	animation_tree.active = true
	pick_new_state()

func _physics_process(delta):
	if (current_state == CHICKEN_STATE.WALK):
		velocity = move_speed * move_direction
			
		move_and_slide()
	
	var player = player_detection.player
	
	if (player != null):
		current_state == CHICKEN_STATE.CHASE
		
	if (current_state == CHICKEN_STATE.CHASE):
		state_machine.travel("Chase")
		var direction_to_player = (player.global_position - global_position).normalized()
		velocity = move_direction.move_toward(direction_to_player * move_speed, acceleration * delta)
			
		move_and_slide()

func select_new_direction():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false

func pick_new_state():
	if (current_state == CHICKEN_STATE.IDLE):
		state_machine.travel("Walk")
		current_state = CHICKEN_STATE.WALK
		select_new_direction()
		timer.start(walk_time)
	elif (current_state == CHICKEN_STATE.WALK):
		state_machine.travel("Idle")
		current_state = CHICKEN_STATE.IDLE
		timer.start(idle_time)


func _on_timer_timeout():
	pick_new_state()
