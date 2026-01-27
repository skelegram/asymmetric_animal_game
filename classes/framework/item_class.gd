extends ObjectClass
class_name ItemClass

enum weight_type {LOCKED = -1, UNIVERSAL = 0, LIGHT = 1, MEDIUM = 2, HEAVY = 3}
@export var weight_class : weight_type
@export var nutrient_ref : Nutrients
