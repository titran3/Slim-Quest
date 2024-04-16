extends CharacterBody2D

var speed = 50
var player_chase = false
var animatedSprite
var player = null


func _ready():
	print("Enemy ready")

	animatedSprite = $AnimatedSprite2D
	animatedSprite.play("idle")

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		
		
		
		




func _on_area_2d_body_entered(body):
	
	player = body
	player_chase = true
	animatedSprite.play("walk")
	var direction = player.global_position.x - global_position.x
	if direction > 0:
		scale.x = abs(scale.x)  # Ensure facing right
	else:
		scale.x = -abs(scale.x)  # Flip horizontally to face left

	


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
	animatedSprite.play("idle")
