extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func _process(delta):
	animated_sprite_2d.play("Fire")



