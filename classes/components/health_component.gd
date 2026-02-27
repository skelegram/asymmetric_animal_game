extends Node
class_name HealthComponent

@export var resource_file : HealthResource
var health : float
var max_health : float
var acid_resistance : float = 8.0


func _load_resource_file() -> void:
	if health: health = resource_file.health
	if max_health: max_health = resource_file.max_health
	if acid_resistance: acid_resistance = resource_file.acid_resistance


func _ready() -> void:
	if resource_file:
		_load_resource_file()


func change_health(attack_data : AttackData) -> void:
	health = clamp(health - attack_data.damage, -max_health, max_health)
