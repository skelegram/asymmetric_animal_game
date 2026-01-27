extends Resource
class_name CreatureData


func _ready() -> void:
	_generate_seed()
	
	# create personality based on seed
	awareness = clamp(randf_range(0.0, 100.0) + awareness_influence, 0.0, 100.0)
	aggression = clamp(randf_range(0.0, 100.0) + aggression_influence, 0.0, 100.0)


func _generate_seed() -> void:
	if seed_val == 0:
		rng.randomize()
	else:
		rng.seed = seed_val
