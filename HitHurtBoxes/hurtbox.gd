extends Area2D

# call the time and collision shapes
@onready var timer = $Timer
@onready var collision_shape = $CollisionShape2D

# create instances of invincibility 
signal invincibility_started
signal invincibility_ended

# call this function when the player gets hit or if you want to add it to the dash
func start_invincibility(duration):
	emit_signal("invincibility_started")
	# start timer based on duration passed
	timer.start(duration)

func _on_timer_timeout():
	emit_signal("invincibility_ended")

# this function is connected from a signal in hurtbox and will get called if invincibility_started 
# signal has been emitted
func _on_invincibility_started():
	# make the player transparent if they get hit
	modulate.a = 0.5
	# disable the hit box if invincbility started
	collision_shape.set_deferred("disabled", true)

# this function is also connected, but will start when invincibility_ended has been emitted
func _on_invincibility_ended():
	# change player transparency back
	modulate.a = 1
	
	collision_shape.disabled = false
