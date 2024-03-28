extends CharacterBody2D

var speed = 10
var player_chase = false
var player = null
var animatedSprite

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


func _on_area_2d_body_exited(body):
	player = null
	player_chase = false
	animatedSprite.play("idle")
