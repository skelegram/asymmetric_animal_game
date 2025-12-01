extends Node
class_name HealthComponent

@export var health : float = 10
@export var max_health : float = 10

func change_health(attack_data : AttackData):
	health = clamp(health - attack_data.damage, -max_health, max_health)
