extends Control

# set get for hearts ui empty
@onready var hearts : int = 5:
	get:
		return hearts
	set(value):
		hearts = value
		

# set get for hearts ui full
@onready var max_hearts : int = 5:
	get:
		return max_hearts
	set(value):
		max_hearts = value
		
# create instances of heart empty and heart full ui
@onready var heart_full = $HealthFull
@onready var label = $Label

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if label != null:
		label.text = "x " + str(hearts)

func set_max_hearts(value):
	# make sure the max possible value passed is at least 1
	max_hearts = max(value, 1)
	# self.hearts can not go above max_hearts
	self.hearts = min(hearts, max_hearts)

func _ready():
	# set the max hearts to the playerstat script's max hearts
	self.max_hearts = PlayerStats.max_health
	# set the hearts to the current health in player stats
	self.hearts = PlayerStats.health
	# whenever the health changed is called, also call this function
	PlayerStats.health_changed.connect(set_hearts)
	PlayerStats.max_health_changed.connect(set_max_hearts)
