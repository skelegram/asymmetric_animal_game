extends CharacterBody2D
class_name MovementComponent

@export var move_speed : float = 500
@export var rotation_speed : float = 50

enum state {IDLE, CHARGE, BITE, GRAPPLE}
var current_state : int
var direction : Vector2 = Vector2.ZERO


func _set_direction(new_value):
	direction = new_value


func _process(delta):
	# handle movement
	look_at(get_global_mouse_position())
	velocity = direction * move_speed
	print(velocity)
	move_and_slide()


func switch_state(new_state: int):
	pass
