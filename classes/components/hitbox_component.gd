extends CollisionShape2D
class_name HitboxComponent

@export var health_component : HealthComponent

func on_hit(attack : AttackData) -> void:
	if health_component:
		health_component.change_health(attack)
