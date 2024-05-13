extends Area2D


	


func _on_body_entered(body):
	if body.name == "Player":
		print("Check")
		body.velocity.y = -360
		body.move_and_slide()
	
		
