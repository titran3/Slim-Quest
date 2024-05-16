extends Area2D
@onready var boing_sfx = $"Boing sfx"


	


func _on_body_entered(body):
	if body.name == "Player":
		boing_sfx.play()
		print("Check")
		body.velocity.y = -360
		body.move_and_slide()
	
		
