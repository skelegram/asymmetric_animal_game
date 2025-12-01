extends Area2D
class_name ZoneComponent

var detected_areas : Array = []

func _on_area_entered(area) -> void:
	if area is HitboxComponent:
		detected_areas.append(area)

func _on_area_exited(area):
	if detected_areas.has(area):
		detected_areas.erase(area)
