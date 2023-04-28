extends Node

# make sure to auto load this file in project settings when using it for player

@export var max_health : int = 5:
	# set get for getting max health
	get:
		return max_health
	set(value):
		# plug in health into set function
		max_health = value
		self.health = min(health, max_health)
		emit_signal("max_health_changed")

@export var health = max_health:
	get:
		return health
	set(value):
		health = value
		# when health is changed call signal
		emit_signal("health_changed", health)
		if health <= 0:
			# no health, call this signal
			emit_signal("no_health")
		
# signal when no health
signal no_health
# signal when health value is changed
signal health_changed(value)
# signal when max_health is changed
signal max_health_changed(value)

# function for changing health in case you need to call it
func set_health(value):
	health = value

func _ready():
	self.health = max_health


