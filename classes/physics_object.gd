extends RigidBody2D
class_name PhysicsObject

@export var grabbable : bool = false
enum weight_type {LOCKED = -1, UNIVERSAL = 0, LIGHT = 1, MEDIUM = 2, HEAVY = 3}
var inital_mass : float
var weight_mod : float = 1.0

func _ready():
	inital_mass = mass
	add_to_group('object')
	calc_weight_mod()

func calc_weight_mod():
	match weight_type:
		weight_type.LIGHT:
			weight_mod = 0.5
		weight_type.MEDIUM:
			weight_mod = 1.0
		weight_type.HEAVY:
			weight_mod = 2.0
	mass = inital_mass * weight_mod
