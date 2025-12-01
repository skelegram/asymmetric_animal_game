extends Node2D
class_name InputComponent

@export var movement_component : MovementComponent
@export var zone_component : ZoneComponent
@export var ai_component : AIComponent


func _process(delta):
	_get_input()


func _get_input() -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	movement_component._set_direction(direction)
	
	if Input.is_action_just_pressed("attack"):
		pass
	if Input.is_action_just_released("attack"):
		pass
	if Input.is_action_just_pressed("block"):
		pass
	if Input.is_action_just_released("block"):
		pass
	if Input.is_action_just_pressed("interact"):
		zone_component.attack()

func _get_auto_input(request := "null", optional_data := Vector2.ZERO) -> void:
	var direction = optional_data
	movement_component._set_direction(direction)
	
	if request == "attack":
		pass
	if request == "block":
		pass
