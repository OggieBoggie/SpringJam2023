extends CharacterBody2D

@export var move_speed : float = 50
@export var acceleration : float = 5000
@export var idle_time : float = 5
@export var walk_time : float = 2

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var sprite = $Sprite2D
@onready var walk_timer = $WalkTimer
@onready var idle_timer = $IdleTimer
@onready var player_detection = $PlayerDetection

enum { Idle, Walk, Chase }

var state = Idle

var knockback = Vector2.ZERO
var move_direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true
	idle_timer.start(idle_time)

func _physics_process(delta):

	match state:
		Idle:
			state_machine.travel("Idle")
			velocity = move_direction.move_toward(Vector2.ZERO, 200 * delta)
			seek_player()
		Walk:
			state_machine.travel("Walk")
			velocity = move_speed * move_direction
			walk_timer.start(walk_time)
			move_and_slide()
			seek_player()
			
		Chase:
			state_machine.travel("Chase")
			var player = player_detection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = move_direction.move_toward(direction * move_speed, acceleration * delta)
				move_and_slide()
			else:
				state = Idle
				idle_timer.start(idle_time)
			sprite.flip_h = velocity.x < 0

func seek_player():
	if player_detection.can_see_player():
		state = Chase

func select_new_direction():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	
	if (move_direction.x < 0):
		sprite.flip_h = true
	elif (move_direction.x > 0):
		sprite.flip_h = false

func _on_walk_timer_timeout():
	state = Idle
	idle_timer.start(idle_time)

func _on_idle_timer_timeout():
	state = Walk
	select_new_direction()
	walk_timer.start(walk_time)
