extends Node

# make sure to auto load the tscn file (not this file) in project settings when using it for player
@export var win_score:  int = 10
@export var score : int = 0:
	get:
		return score
	set(value):
		score = value
		emit_signal("score_changed", score)
		if score == win_score:
			score = 0
			emit_signal("winning")
		

@export var max_health : int = 99:
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
# signal when score changed
signal score_changed(value)

signal winning

# function for changing health in case you need to call it
func set_health(value):
	health = value

func set_score(value):
	score = value

func _ready():
	self.health = max_health - 96


