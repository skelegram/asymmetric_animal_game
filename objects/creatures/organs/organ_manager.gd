extends Node2D
class_name OrganManager

var body_nutrients = Nutrients.new()

func _ready():
	body_nutrients.change_carb_level(50.0)
	body_nutrients.change_protein_level(50.0)
	body_nutrients.change_fat_level(50.0)
	body_nutrients.change_water_level(50.0)
	body_nutrients.change_vitamin_level(50.0)
	body_nutrients.change_mineral_level(50.0)
	body_nutrients.change_fiber_level(50.0)
