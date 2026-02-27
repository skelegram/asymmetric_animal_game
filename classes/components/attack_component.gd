#@icon()
extends Area2D
class_name AttackComponent

@export var new_attack : AttackData
var detected_bodies : Array = []

func attack() -> void:
	for body in detected_bodies:
		if body is CreatureClass:
			body.on_hit(new_attack)
		elif body is ObjectClass:
			stomach_organ.swallow_object(body.object_data)
			body.queue_free()


func _on_body_entered(body) -> void:
	if body == get_parent().get_parent(): return
	if (body is ObjectClass or body is CreatureClass):
		detected_bodies.append(body)


func _on_body_exited(body) -> void:
	if detected_bodies.has(body):
		detected_bodies.erase(body)
