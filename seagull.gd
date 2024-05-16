extends AnimatableBody2D

@onready var player = $"../Player"
@export var left : Node2D
@export var right : Node2D
@onready var sprite = $AnimatedSprite2D
@onready var seagull_sfx = $"seagull sfx"

# Called when the node enters the scene tree for the first time.
func _ready():
	tween_to_left()
	$AnimatedSprite2D.play("Fly")
	
	
func tween_to_left():
	print("tween to left")
	self.position = right.position
	sprite.flip_h = !sprite.flip_h
	#sprite.flip_x = sprite.!flip_x;
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", left.position, 1.8)
	tween.tween_callback(tween_to_right)


func tween_to_right():
	self.position = left.position
	sprite.flip_h = !sprite.flip_h
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", right.position, 1.8)
	tween.tween_callback(tween_to_left)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body == player:
		seagull_sfx.play()
