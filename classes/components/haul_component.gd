#@icon()
extends Area2D
class_name HaulComponent

@export var resource_file : HaulResource
@export var parent_node : Node2D
var contained_bodies : Dictionary = {}
var is_reparenting := false


func _on_body_entered(body) -> void:
	if is_reparenting:
		return
	if (body is CreatureManager or body is ObjectManager) and body != parent_node and not contained_bodies.has(body):
		is_reparenting = true
		print(body, " in. Parent: ", body.get_parent())
		contained_bodies[body] = body.get_parent()
		monitoring = false
		body.call_deferred("reparent", parent_node)
		await get_tree().process_frame
		monitoring = true
		is_reparenting = false
		## ALERT *** save original parent before switching ***
		## CreatureManager / ObjectManager filters acting strangle, double check and try again when i have time


func _on_body_exited(body) -> void:
	if is_reparenting:
		return
	if (body is CreatureManager or body is ObjectManager) and contained_bodies.has(body):
		is_reparenting = true
		print(body.name, " out. Parent : ", body.get_parent())
		var body_parent : Node2D = contained_bodies[body]
		contained_bodies.erase(body)
		monitoring = false
		body.call_deferred("reparent", body_parent)
		await get_tree().process_frame
		monitoring = true
		is_reparenting = false
