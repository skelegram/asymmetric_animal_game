extends Node2D
class_name InputComponent

@export var movement_component : MovementComponent
@export var zone_component : ZoneComponent
@export var ai_component : AIComponent
@export var stomach_organ : StomachOrgan


func _physics_process(_delta) -> void:
	_get_input()


func _get_input() -> void:
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
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
		print("pressed")
	if Input.is_action_just_pressed("ui"):
		stomach_organ.fullness_bar.visible = !stomach_organ.fullness_bar.visible

func _get_auto_input(request : String = "null", optional_data : Vector2 = Vector2.ZERO) -> void:
	var direction := optional_data
	movement_component._set_direction(direction)
	
	if request == "attack":
		pass
	if request == "block":
		pass
