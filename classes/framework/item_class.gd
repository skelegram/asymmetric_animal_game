extends ObjectClass
class_name ItemClass

@export var grabbable : bool = false
enum weight_type {LOCKED = -1, UNIVERSAL = 0, LIGHT = 1, MEDIUM = 2, HEAVY = 3}

func _ready():
	add_to_group('object')
