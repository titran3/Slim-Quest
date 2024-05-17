extends Node2D

class_name GameManager
@export var movement_data: PlayerMovementData
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var main_menu = $"CanvasLayer/Main Menu"
@onready var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		main_menu.hide()
		Engine.time_scale = 1
	else:
		main_menu.show()
		Engine.time_scale = 0
	
	paused = !paused


func _on_fire_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
		movement_data.speed = 100
