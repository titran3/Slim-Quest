extends Area2D
var state = "idle"
@export var movement_data: PlayerMovementData
var salad = preload("res://salad.tscn").instantiate()
var player_scene = preload("res://player.tscn").instantiate() 
@onready var animated_sprite_2d = $AnimatedSprite2D
var image = preload("res://cat door open.png")
@onready var player = $"../Player"
@onready var player_scale_y = 1.125
@onready var player_scale_x = 1.1
@onready var eatingsound = $Eatingsound
@onready var error = $Error


func _process(delta):
	print(player_scene.movement_data.speed)
	var icecream = get_tree().get_nodes_in_group("Ice Cream")
	if state == "idle":
		pass
	if state == "eaten":
		player_scene.movement_data.speed -= 10
		self.visible = false
		position.y = -500
		state = "idle"
		await get_tree().create_timer(2.0).timeout
		queue_free()

func color():
	player.modulate = Color(0.99,0.24,0.24)
	await get_tree().create_timer(0.15).timeout
	player.modulate = Color.WHITE

func _on_body_entered(body):
	color()
	state = "eaten"
	player.scale.y *= player_scale_y
	player.scale.y *= player_scale_x
	$Eatingsound.play()
	$Error.play()
