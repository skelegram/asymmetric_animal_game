#@icon()
extends Node2D
class_name InputComponent

@export var resource_file : InputResource
@export var parent_node : Node2D


func _physics_process(_delta : float) -> void:
	_get_input()


func _get_input() -> void:
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	parent_node.movement_component._set_direction(direction)
	
	if Input.is_action_just_pressed("attack"):
		pass
	if Input.is_action_just_released("attack"):
		pass
	if Input.is_action_just_pressed("block"):
		pass
	if Input.is_action_just_released("block"):
		pass
	if Input.is_action_just_pressed("interact"):
		print("pressed")
	if Input.is_action_just_pressed("ui"):
		parent_node.stomach_organ.fullness_bar.visible = !parent_node.stomach_organ.fullness_bar.visible

func _get_auto_input(request : String = "null", optional_data : Vector2 = Vector2.ZERO) -> void:
	var direction : Vector2 = optional_data
	parent_node.movement_component._set_direction(direction)
	
	if request == "attack":
		pass
	if request == "block":
		pass
