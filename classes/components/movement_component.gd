extends Node2D
class_name MovementComponent

@export var move_speed : float = 200

enum state {IDLE, CHARGE, BITE, GRAPPLE}
var current_state : int
var direction : Vector2 = Vector2.ZERO


func _set_direction(new_value):
	direction = new_value


func _process(delta):
	# handle movement
	get_parent().look_at(get_global_mouse_position())
	get_parent().velocity = direction * move_speed
	get_parent().move_and_slide()


func switch_state(new_state: int):
	pass
