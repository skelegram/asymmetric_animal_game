extends Node2D
class_name StomachOrgan

@export var organ_manager : OrganManager

@export_category("UI")
@export var carb_bar : ProgressBar
@export var protein_bar : ProgressBar
@export var fat_bar : ProgressBar
@export var water_bar : ProgressBar
@export var vitamin_bar : ProgressBar
@export var mineral_bar : ProgressBar
@export var fiber_bar : ProgressBar

@export_category("Stats")
@export var capacity : float = 0.0
@export var max_capacity : float = 10.0
@export var energy_efficiency : float = 0.25
@export var acid_strength : float = 8.0

var stomach_contents : Array = []


func _process(delta):
	digest_tick()
	update_bars()


func digest_tick():
	pass


func update_bars():
	carb_bar.value = organ_manager.body_nutrients.carb
	protein_bar.value = organ_manager.body_nutrients.protein
	fat_bar.value = organ_manager.body_nutrients.fat
	water_bar.value = organ_manager.body_nutrients.water
	vitamin_bar.value = organ_manager.body_nutrients.vitamins
	mineral_bar.value = organ_manager.body_nutrients.minerals
	fiber_bar.value = organ_manager.body_nutrients.fiber
