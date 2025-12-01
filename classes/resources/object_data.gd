extends Resource
class_name ObjectData

@export var material_data : MaterialData
@export var health : float = 10.0
@export var max_health : float = 10.0
@export var acid_resistance : float = 8.0
enum weight_type {LOCKED = -1, UNIVERSAL = 0, LIGHT = 1, MEDIUM = 2, HEAVY = 3}
@export var weight_class : weight_type
