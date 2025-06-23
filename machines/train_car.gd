extends CharacterBody2D

var bodies_onboard : Array

func _physics_process(delta):
	for body in bodies_onboard:
		body.velocity += self.velocity

func _on_area_2d_body_entered(body):
	bodies_onboard.append(body)

func _on_area_2d_body_exited(body):
	bodies_onboard.erase(body)
