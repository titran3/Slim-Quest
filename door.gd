extends Area2D

@export var next_level = PackedScene
@onready var sprite_2d = $Sprite2D
var image = load("res://cat door open.png")
var portal = "closed"
@onready var point_light_2d = $PointLight2D

func _on_body_entered(body):
	if portal == "open":
		sprite_2d.texture = load("res://cat door open.png")
		await get_tree().create_timer(0.15).timeout
		get_tree().change_scene_to_packed(next_level)

func _process(delta):
	if is_salad_empty():
		portal = "open"
	if portal == "open":
		point_light_2d.energy = 0.5
		sprite_2d.texture = load("res://cat door open.png")
	

func is_salad_empty():
	var salad_nodes = get_tree().get_nodes_in_group("Salad")
	return salad_nodes.size() == 0
