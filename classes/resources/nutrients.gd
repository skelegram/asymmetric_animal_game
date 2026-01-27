extends Node2D
class_name Nutrients

## Does x, y. Found in
@export_range(0.0, 100.0) var carb : float = 0.0
## Does x, y. Found in
@export_range(0.0, 100.0) var protein: float = 0.0
## Does x, y. Found in
@export_range(0.0, 100.0) var fat : float = 0.0
## Does x, y. Found in
@export_range(0.0, 100.0) var water: float = 0.0
## Does x, y. Found in
@export_range(0.0, 100.0) var vitamins: float = 0.0
## Does x, y. Found in
@export_range(0.0, 100.0) var minerals: float = 0.0
## Does x, y. Found in
@export_range(0.0, 100.0) var fiber: float = 0.0


func change_carb_level(value : float) -> float:
	var old_value = carb
	carb = clamp(carb + value, 0.0, 100.0)
	return carb - old_value


func change_protein_level(value : float) -> float:
	var old_value = protein
	protein = clamp(protein + value, 0.0, 100.0)
	return protein - old_value


func change_fat_level(value : float) -> float:
	var old_value = fat
	fat = clamp(fat + value, 0.0, 100.0)
	return fat - old_value


func change_water_level(value : float) -> float:
	var old_value = water
	water = clamp(water + value, 0.0, 100.0)
	return water - old_value


func change_vitamin_level(value : float) -> float:
	var old_value = vitamins
	vitamins = clamp(vitamins + value, 0.0, 100.0)
	return vitamins - old_value


func change_mineral_level(value : float) -> float:
	var old_value = minerals
	minerals = clamp(minerals + value, 0.0, 100.0)
	return minerals - old_value


func change_fiber_level(value : float) -> float:
	var old_value = fiber
	fiber = clamp(fiber + value, 0.0, 100.0)
	return fiber - old_value
