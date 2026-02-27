extends CharacterBody2D
class_name CreatureManager

@export var resource_file : CreatureResource
@export var hitbox_component : HitboxComponent
@export var input_component : InputComponent
@export var movement_component : MovementComponent
@export var ai_component : AIComponent
@export var stomach_organ : StomachOrgan
var stored_nutrients : Nutrients
var base_mass : float = 10.0


func _load_resource_file() -> void:
	if stored_nutrients: stored_nutrients = resource_file.stored_nutrients


func _ready():
	if resource_file:
		_load_resource_file()


func save_as_resource() -> void:
	var new_resource = CreatureResource.new()
	if input_component: new_resource.input_resource = input_component.resource_file
	if movement_component: new_resource.movement_resource = movement_component.resource_file
	if ai_component: new_resource.ai_resource = ai_component.resource_file
	if stomach_organ: new_resource.stomach_resource = stomach_organ.resource_file
	if stored_nutrients: new_resource.stored_nutrients = stored_nutrients
	if base_mass: new_resource.base_mass = base_mass
	resource_file = new_resource
