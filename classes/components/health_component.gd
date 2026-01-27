extends Node
class_name HealthComponent

@export var health : float
@export var max_health : float


@export var acid_resistance : float = 8.0



func change_health(attack_data : AttackData) -> void:
	health = clamp(health - attack_data.damage, -max_health, max_health)
