extends StaticBody2D

@onready var hurtbox = $FlowerHurt/CollisionShape2D
@onready var animation = $AnimatedSprite2D

var stats = PlayerStats

func _on_flower_hurt_area_entered(area):
	stats.score += 1
	hurtbox.set_deferred("disabled", true)
	animation.play("animate")
	
