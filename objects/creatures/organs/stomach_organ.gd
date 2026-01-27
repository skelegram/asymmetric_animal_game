extends Node2D
class_name StomachOrgan

@export var storage_component : StorageComponent

@export_category("Data")
@export var fullness : float = 0.0
@export var max_fullness : float = 10.0
@export var energy_efficiency : float = 0.25
@export var acid_strength : float = 8.0

@export_category("UI")
@export var fullness_bar : TextureProgressBar
@export var carb_bar : ProgressBar
@export var protein_bar : ProgressBar
@export var fat_bar : ProgressBar
@export var water_bar : ProgressBar
@export var vitamin_bar : ProgressBar
@export var mineral_bar : ProgressBar
@export var fiber_bar : ProgressBar

var stomach_contents : Array[Object] = []


#func _ready() -> void:
	#update_bars()
#
#
#func _physics_process(delta) -> void:
	#drain_tick(delta)
	#if stomach_contents.size() > 0:
		#digest_tick(delta)
	#update_bars()


func swallow_object(new_object : ItemClass) -> void:
	stomach_contents.append(new_object)


#func drain_tick(delta) -> void:
	#storage_component.stored_nutrients.carb -= 2 * delta
	#storage_component.stored_nutrients.protein -= 2 * delta
	#storage_component.stored_nutrients.fat -= 2 * delta
	#storage_component.stored_nutrients.water -= 2 * delta
	#storage_component.stored_nutrients.vitamins -= 2 * delta
	#storage_component.stored_nutrients.minerals -= 2 * delta
	#storage_component.stored_nutrients.fiber -= 2 * delta
	#print(storage_component.stored_nutrients.protein, ", ", protein_bar.value)
#
#
#func digest_tick(delta) -> void:
	#for item in stomach_contents:
		#storage_component.stored_nutrients.carb -= item.material_data.nutrient_ref.change_carb_level(-10 * delta)
		#storage_component.stored_nutrients.protein -= item.material_data.nutrient_ref.change_protein_level(-10 * delta)
		#storage_component.stored_nutrients.fat -= item.material_data.nutrient_ref.change_fat_level(-10 * delta)
		#storage_component.stored_nutrients.water -= item.material_data.nutrient_ref.change_water_level(-10 * delta)
		#storage_component.stored_nutrients.vitamins -= item.material_data.nutrient_ref.change_vitamin_level(-10 * delta)
		#storage_component.stored_nutrients.minerals -= item.material_data.nutrient_ref.change_mineral_level(-10 * delta)
		#storage_component.stored_nutrients.fiber -= item.material_data.nutrient_ref.change_fiber_level(-10 * delta)
		#print(storage_component.stored_nutrients.protein, ", ", protein_bar.value, "; ", item)
#
#func update_bars() -> void:
	#carb_bar.value = storage_component.stored_nutrients.carb
	#protein_bar.value = storage_component.stored_nutrients.protein
	#fat_bar.value = storage_component.stored_nutrients.fat
	#water_bar.value = storage_component.stored_nutrients.water
	#vitamin_bar.value = storage_component.stored_nutrients.vitamins
	#mineral_bar.value = storage_component.stored_nutrients.minerals
	#fiber_bar.value = storage_component.stored_nutrients.fiber
