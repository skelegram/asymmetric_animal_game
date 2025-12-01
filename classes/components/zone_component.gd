extends Area2D
class_name ZoneComponent

@export var stomach_organ : StomachOrgan
@export var new_attack : AttackData
var detected_areas : Array = []

func attack() -> void:
	for area : HitboxComponent in detected_areas:
		if area.is_class("CreatureClass"):
			area.on_hit(new_attack)
		elif area.is_class("ObjectClass"):
			stomach_organ.swallow_object(area.get_parent())

func _on_area_entered(area) -> void:
	if area is HitboxComponent:
		detected_areas.append(area)

func _on_area_exited(area) -> void:
	if detected_areas.has(area):
		detected_areas.erase(area)
