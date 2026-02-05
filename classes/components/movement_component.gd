extends Node2D
class_name MovementComponent

@export_category("Stats")
@export var move_speed : float = 200.0
var direction : Vector2 = Vector2.ZERO

func _set_direction(new_value : Vector2) -> void:
	direction = new_value


func _physics_process(_delta) -> void:
	# handle movement
	#get_parent().look_at(get_global_mouse_position())
	get_parent().apply_torque(get_angle_to(get_global_mouse_position()))
	#get_parent().velocity = direction * get_parent().creature_data.move_speed
	#get_parent().move_and_slide()


func switch_state(new_state: int):
	pass
