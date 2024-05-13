extends Area2D
var state = "idle"
@export var movement_data: PlayerMovementData
var salad = preload("res://salad.tscn").instantiate()
var player_scene = preload("res://player.tscn").instantiate() 
@onready var animated_sprite_2d = $AnimatedSprite2D
var image = preload("res://cat door open.png")
@onready var player = $"../Player"
@onready var player_scale_y = 1.25
@onready var player_scale_x = 1.15
@onready var eatingsound = $Eatingsound


func _process(delta):
	var icecream = get_tree().get_nodes_in_group("Ice Cream")
	if state == "idle":
		pass
	if state == "eaten":
		player_scene.movement_data.speed -= 15
		queue_free()

func _on_body_entered(body):
	eatingsound.play()
	state = "eaten"
	player.scale.y *= player_scale_y
	player.scale.y *= player_scale_x
