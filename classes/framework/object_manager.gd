extends CharacterBody2D
class_name ObjectManager

@export var resource_file : ObjectResource
var stored_nutrients : Nutrients


func _load_resource_file() -> void:
	if stored_nutrients: stored_nutrients = resource_file.stored_nutrients

func _ready() -> void:
	if resource_file:
		_load_resource_file()


func save_as_resource(resource_class :  ) -> void:
	var new_resource : ObjectResource = ObjectResource.new()
	if stored_nutrients: new_resource.stored_nutrients = stored_nutrients
	resource_file = new_resource
