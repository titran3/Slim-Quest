extends Area2D

var player_scene = preload("res://player.tscn").instantiate()
@onready var animated_sprite_2d = $AnimatedSprite2D

func _process(delta):
	var salads = get_tree().get_nodes_in_group("Salad")
	animated_sprite_2d.play("idle")

func _on_body_entered(body):
	queue_free()
