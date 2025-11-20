extends Node2D
class_name HealthComponent

@export var health : float = 10
@export var max_health : float = 10


func change_health(attack : Attack):
	health -= attack.damage
