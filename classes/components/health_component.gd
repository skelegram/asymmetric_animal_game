extends Node
class_name HealthComponent

@export var flesh_type : ObjectData

func change_health(attack_data : AttackData):
	flesh_type.health = clamp(flesh_type.health - attack_data.damage, -flesh_type.max_health, flesh_type.max_health)
