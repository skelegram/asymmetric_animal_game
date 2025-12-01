extends Resource
class_name Nutrients

@export_range(0.0, 100.0) var carb : float = 0.0
@export_range(0.0, 100.0) var protein: float = 0.0
@export_range(0.0, 100.0) var fat : float = 0.0
@export_range(0.0, 100.0) var water: float = 0.0
@export_range(0.0, 100.0) var vitamins: float = 0.0
@export_range(0.0, 100.0) var minerals: float = 0.0
@export_range(0.0, 100.0) var fiber: float = 0.0

func change_carb_level(value) -> void:
	carb = clamp(carb + value, 0.0, 100.0)

func change_protein_level(value) -> void:
	protein = clamp(protein + value, 0.0, 100.0)

func change_fat_level(value) -> void:
	fat = clamp(fat + value, 0.0, 100.0)

func change_water_level(value) -> void:
	water = clamp(water + value, 0.0, 100.0)

func change_vitamin_level(value) -> void:
	vitamins = clamp(vitamins + value, 0.0, 100.0)

func change_mineral_level(value) -> void:
	minerals = clamp(minerals + value, 0.0, 100.0)

func change_fiber_level(value) -> void:
	fiber = clamp(fiber + value, 0.0, 100.0)
