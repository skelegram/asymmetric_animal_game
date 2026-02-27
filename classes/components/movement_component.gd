#@icon()
extends Node2D
class_name MovementComponent

@export var resource_file : MovementResource
@export var parent_node : Node2D

var move_speed : float = 700.0
var rotation_speed : float = 900.0
var direction : Vector2 = Vector2.ZERO


func _load_resource_file() -> void:
	if move_speed: move_speed = resource_file.move_speed
	if rotation_speed: rotation_speed = resource_file.rotation_speed


func _ready() -> void:
	if resource_file:
		_load_resource_file()


func _physics_process(_delta : float) -> void:
	# handle movement
	get_parent().apply_torque(get_angle_to(get_global_mouse_position()) * rotation_speed)
	get_parent().apply_central_force(direction * move_speed)
	#get_parent().velocity = direction * get_parent().creature_data.move_speed
	#get_parent().move_and_slide()


func _set_direction(new_value : Vector2) -> void:
	direction = new_value


func switch_state(new_state: int) -> void:
	pass
