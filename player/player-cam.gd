extends Camera2D

@onready var top_left = $Limits/TopLeft
@onready var bot_right = $Limits/BottomRight

# Called when the node enters the scene tree for the first time.
func _ready():
	limit_top = top_left.position.y
	limit_left = top_left.position.x 
	limit_bottom = bot_right.position.y
	limit_right = bot_right.position.x
