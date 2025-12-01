extends Node2D
class_name ObjectClass

@export_enum(MaterialType.new().materials) var material_type
@export var acid_resistance : float = 8.0
@export var grabbable : bool = false
enum weight_type {LOCKED = -1, UNIVERSAL = 0, LIGHT = 1, MEDIUM = 2, HEAVY = 3}
