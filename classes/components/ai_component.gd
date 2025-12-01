extends NavigationAgent2D
class_name AIComponent

@export var hitbox_component : HitboxComponent
@export var brain_data : CreatureData

@export var max_pack_size : int = 1
var pack_members : Array[CharacterBody2D] = []
var tracked_objects : Dictionary[Node2D, float] = {}
var tracked_locations : Dictionary[Vector2, float] = {}

enum state {IDLE, WANDER}
var current_state : int = state.IDLE
@onready var raycast := $RayCast2D
@export var navigation_attempts : int = 5


func _ready():
	debug_enabled = true


func _process(delta):
	match current_state:
		state.IDLE:
			await get_tree().create_timer(5.0).timeout
			
		state.WANDER:
			if is_navigation_finished():
				if not _pick_wander_point():
					pass


func _identify_targets() -> void:
	for object in tracked_objects:
		object.visible = _has_line_of_sight(object.id)


func _pick_wander_point() -> bool:
	## !!EXPECTING A CIRCLE COLLIDER, CRASHES IF SHAPE DOES NOT MATCH!!
	var hearing_radius : float = hitbox_component.shape.radius
	var wander_point : Vector2 = Vector2(0, 0)
	
	for attempt in navigation_attempts:
		wander_point = Vector2(randf_range(-hearing_radius, hearing_radius), randf_range(-hearing_radius, hearing_radius))
		target_position = wander_point
		print(str(get_parent().name) + " reachable space found.")
		return true
	print(str(get_parent().name) + " could not find an reachable space.")
	return false

func _has_line_of_sight(body) -> bool:
	raycast.target_position = body.global_position
	return raycast.get_collider() == body

func _on_sight_range_body_entered(body):
	var new_object : ObjectClass = ObjectClass.new()
	new_object.id = body
	
	## BASE INTEREST RATING, MULTIPLIED BY CREATURE DETAILS
	tracked_objects[new_object] = 0.0

func _on_sight_range_body_exited(body):
	for object in tracked_objects:
		if object.id == body:
			tracked_objects.erase(body)
			break
