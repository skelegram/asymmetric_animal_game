extends Node
class_name BrainData

@export var seed : float = 0
var rng := RandomNumberGenerator.new()

var awareness : int
@export_range(-100.0, 100.0) var awareness_influence : int
var aggression : int
@export_range(-100.0, 100.0) var aggression_influence : int


func _ready():
	_generate_seed()
	
	# create personality based on seed
	awareness = clamp(randf_range(0.0, 100.0) + awareness_influence, 0.0, 100.0)
	aggression = clamp(randf_range(0.0, 100.0) + aggression_influence, 0.0, 100.0)


func _generate_seed() -> void:
	if seed == 0:
		rng.randomize()
	else:
		rng.seed = seed
