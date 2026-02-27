#@icon()
extends NavigationAgent2D
class_name AIComponent

@export var resource_file : AIResource
@export var parent_node : Node2D

@onready var raycast : RayCast2D = $RayCast2D

var max_pack_size : int = 1
var navigation_attempts : int = 5
var pack_members : Array[CreatureResource] = []

var tracked_objects : Dictionary[ObjectResource, float] = {}
var tracked_locations : Dictionary[Vector2, float] = {}

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var seed_val : int = 0
var awareness_influence : int
var awareness : int
var hearing_radius : float = 32.0 * (awareness / 10.0)
var aggression_influence : int
var aggression : int


func _load_resource_file() -> void:
	if max_pack_size: max_pack_size = resource_file.max_pack_size
	if navigation_attempts: navigation_attempts = resource_file.navigation_attempts
	if pack_members: pack_members = resource_file.pack_members
	if tracked_objects: tracked_objects = resource_file.tracked_objects
	if tracked_locations: tracked_locations = resource_file.tracked_locations
	if seed_val: seed_val = resource_file.seed_val
	if awareness_influence: awareness_influence = resource_file.awareness_influence
	if awareness: awareness = resource_file.awareness
	if aggression_influence: aggression_influence = resource_file.aggression_influence
	if aggression: aggression = resource_file.aggression

func _ready() -> void:
	if resource_file:
		_load_resource_file()
	_generate_seed()
	
	# create personality based on seed
	awareness = clamp(randf_range(0.0, 100.0) + awareness_influence, 0.0, 100.0)
	aggression = clamp(randf_range(0.0, 100.0) + aggression_influence, 0.0, 100.0)


func _physics_process(_delta : float) -> void:
	#match current_state:
		#state.IDLE:
			#await get_tree().create_timer(5.0).timeout
			#
		#state.WANDER:
			#if is_navigation_finished():
				#if not _pick_wander_point():
					pass


func _generate_seed() -> void:
	if seed_val == 0:
		rng.randomize()
	else:
		rng.seed = seed_val


#func _identify_targets() -> void:
	#for object in tracked_objects:
		#object.visible = _has_line_of_sight(object)


func _pick_wander_point() -> bool:
	## !!EXPECTING A CIRCLE COLLIDER, CRASHES IF SHAPE DOES NOT MATCH!!
	var wander_point : Vector2 = Vector2(0, 0)
	
	for attempt in navigation_attempts:
		wander_point = Vector2(randf_range(-hearing_radius, hearing_radius), randf_range(-hearing_radius, hearing_radius))
		target_position = wander_point
		print(str(get_parent().name) + " reachable space found.")
		return true
	print(str(get_parent().name) + " could not find an reachable space.")
	return false

func _has_line_of_sight(body : HitboxComponent) -> bool:
	raycast.target_position = body.global_position
	return raycast.get_collider() == body

#func _on_sight_range_body_entered(body : HitboxComponent):
	#var new_object : ObjectClass = ObjectClass.new()
	#new_object.id = body
	#
	### BASE INTEREST RATING, MULTIPLIED BY CREATURE DETAILS
	#tracked_objects[new_object] = 0.0

func _on_sight_range_body_exited(body : HitboxComponent):
	for object in tracked_objects:
		if object.id == body:
			tracked_objects.erase(body)
			break
