extends Area2D
var state = "idle"
@export var movement_data: PlayerMovementData

var player_scene = preload("res://player.tscn").instantiate()
@onready var animated_sprite_2d = $AnimatedSprite2D

func _process(delta):
	var salads = get_tree().get_nodes_in_group("Salad")
	if state == "idle":
		animated_sprite_2d.play("idle")
	if state == "eaten":
		player_scene.movement_data.speed = 150
		await get_tree().create_timer(0.05).timeout
		animated_sprite_2d.play("eaten")
		await get_tree().create_timer(1.0).timeout
		queue_free()
		await get_tree().create_timer(3.0).timeout
		player_scene.movement_data.speed = 100

func _on_body_entered(body):
	state = "eaten"