extends Area2D

@export var next_level = PackedScene
@onready var sprite_2d = $Sprite2D
var image = preload("res://cat door open.png")

func _on_body_entered(body):
	if is_salad_empty():
		get_tree().change_scene_to_packed(next_level)
		$Sprite2D.texture = image

func is_salad_empty() -> bool:
	var salad_nodes = get_tree().get_nodes_in_group("Salad")
	return salad_nodes.size() == 1
