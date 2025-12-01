extends CollisionShape2D
class_name HitboxComponent

@export var health_component : HealthComponent

func on_hit(attack) -> void:
	health_component.change_health(	attack)
