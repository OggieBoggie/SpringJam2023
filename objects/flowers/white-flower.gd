extends StaticBody2D

@onready var hurtbox = $FlowerHurt/CollisionShape2D
@onready var animation = $AnimatedSprite2D

var stats = PlayerStats

func _on_flower_hurt_area_entered(area):
	hurtbox.set_deferred("disabled", true)
	animation.play("animate")

func _on_animated_sprite_2d_animation_finished():
		stats.score += 1
