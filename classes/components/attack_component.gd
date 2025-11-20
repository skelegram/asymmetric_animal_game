extends Area2D
class_name AttackComponent

@export var attack := Attack.new()


func _on_area_entered(area) -> void:
	if area is HitboxComponent and area.get_parent() != get_parent():
		pass
		#area.on_hit(attack)
