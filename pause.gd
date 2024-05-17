extends Control

@export var movement_data: PlayerMovementData
@onready var world = $"../../"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_pressed():
	world.pauseMenu()


func _on_restart_pressed():
	get_tree().reload_current_scene()
	movement_data.speed = 100
	world.pauseMenu()


func _on_quit_button_pressed():
	get_tree().quit()
