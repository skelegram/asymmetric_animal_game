extends RigidBody2D
class_name AbstractCreature

@export var zone_component : Node2D
@export var ai_component : NavigationAgent2D
@export var hitbox_component : Node2D
@onready var raycast : RayCast2D = $RayCast2D

@export_category("Stats")
@export var move_speed : float = 200.0
var direction : Vector2 = Vector2.ZERO
@export var health : float
@export var max_health : float
@export var acid_resistance : float = 8.0
@export var stored_nutrients : Nutrients
@export var new_attack : AttackData
var detected_bodies : Array = []

@export_category("Stomach")
@export var fullness : float = 0.0
@export var max_fullness : float = 10.0
@export var energy_efficiency : float = 0.25
@export var acid_strength : float = 8.0
var stomach_contents : Array[Object] = []

@export_category("Navigation")
@export var ai_starts_awake : bool = false
var ai_awake : bool = false
@export var max_pack_size : int = 1
var pack_members : Array[CharacterBody2D] = []
var tracked_objects : Dictionary[Node2D, float] = {}
var tracked_locations : Dictionary[Vector2, float] = {}
@export var navigation_attempts : int = 5
enum state {IDLE, WANDER}
var current_state : int = state.IDLE

@export_category("Personality")
var rng : RandomNumberGenerator = RandomNumberGenerator.new()
@export var seed_val : float = 0
var awareness : int
@export_range(-100.0, 100.0) var awareness_influence : int
var aggression : int
@export_range(-100.0, 100.0) var aggression_influence : int

@export_category("Inventory")
@onready var pinjoint : PinJoint2D = $PinJoint2D
var stored_item : ObjectClass
# functions as a pouch with true or a hand with false
@export var storage_slot : bool = true
#@export var slot_weight : ObjectData.weight_type = ObjectData.weight_type.UNIVERSAL
@export var parent_body : Node

@export_category("UI")
@export var fullness_bar : TextureProgressBar
@export var carb_bar : ProgressBar
@export var protein_bar : ProgressBar
@export var fat_bar : ProgressBar
@export var water_bar : ProgressBar
@export var vitamin_bar : ProgressBar
@export var mineral_bar : ProgressBar
@export var fiber_bar : ProgressBar


func _ready():
	ai_awake = ai_starts_awake

func _physics_process(_delta) -> void:
	if ai_awake:
		match current_state:
			state.IDLE:
				await get_tree().create_timer(5.0).timeout
				
			state.WANDER:
				if ai_component.is_navigation_finished():
					if not ai_pick_wander_point():
						pass
	
	if stored_item and parent_body:
		stored_item.linear_velocity = parent_body.linear_velocity
		stored_item.angular_velocity = parent_body.angular_velocity
	
	#drain_tick(delta)
	#if stomach_contents.size() > 0:
		#digest_tick(delta)
	#update_bars()
	
	# handle movement
	_get_input()
	#get_parent().look_at(get_global_mouse_position())
	get_parent().apply_torque(get_angle_to(get_global_mouse_position()))
	#get_parent().velocity = direction * get_parent().creature_data.move_speed
	#get_parent().move_and_slide()


func _get_input() -> void:
	var direction : Vector2 = Input.get_vector("left", "right", "up", "down")
	_set_direction(direction)
	
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
		fullness_bar.visible = !fullness_bar.visible


func ai_get_auto_input(request : String = "null", optional_data : Vector2 = Vector2.ZERO) -> void:
	var direction := optional_data
	_set_direction(direction)
	
	if request == "attack":
		pass
	if request == "block":
		pass


func ai_identify_targets() -> void:
	for object in tracked_objects:
		object.visible = ai_has_line_of_sight(object)


func ai_pick_wander_point() -> bool:
	## !!EXPECTING A CIRCLE COLLIDER, CRASHES IF SHAPE DOES NOT MATCH!!
	var hearing_radius : float = hitbox_component.shape.radius
	var wander_point : Vector2 = Vector2(0, 0)
	
	for attempt in navigation_attempts:
		wander_point = Vector2(randf_range(-hearing_radius, hearing_radius), randf_range(-hearing_radius, hearing_radius))
		ai_component.target_position = wander_point
		print(str(get_parent().name) + " reachable space found.")
		return true
	print(str(get_parent().name) + " could not find an reachable space.")
	return false


func ai_has_line_of_sight(body : Node2D) -> bool:
	raycast.target_position = body.global_position
	return raycast.get_collider() == body


func ai_on_sight_range_body_entered(body : Node2D):
	var new_object : ObjectClass = ObjectClass.new()
	new_object.id = body
	
	## BASE INTEREST RATING, MULTIPLIED BY CREATURE DETAILS
	tracked_objects[new_object] = 0.0


func ai_on_sight_range_body_exited(body : Node2D):
	for object in tracked_objects:
		if object.id == body:
			tracked_objects.erase(body)
			break


func _set_direction(new_value : Vector2) -> void:
	direction = new_value


func switch_state(new_state: int):
	pass


func on_hit(attack : AttackData) -> void:
	pass
	#if health_component:
	#	health_component.change_health(attack)


func change_health(attack_data : AttackData) -> void:
	health = clamp(health - attack_data.damage, -max_health, max_health)


func attack() -> void:
	for body in detected_bodies:
		if body is CreatureClass:
			body.on_hit(new_attack)
		elif body is ObjectClass:
			swallow_object(body.object_data)
			body.queue_free()


func _on_body_entered(body) -> void:
	if body == get_parent().get_parent(): return
	if (body is ObjectClass or body is CreatureClass):
		detected_bodies.append(body)


func _on_body_exited(body) -> void:
	if detected_bodies.has(body):
		detected_bodies.erase(body)


func stow(target):
	if not stored_item and parent_body:
		print("pickup START: ", pinjoint.node_b)
		target.global_position = pinjoint.global_position
		
		target.reparent(self)
		target.global_position = global_position
		#pinjoint.node_b = target.get_path()
		#stored_mass = target.mass
		#target.mass = 0.0
		#target.add_collision_exception_with(parent_body)
		#parent_body.add_collision_exception_with(target)
		
		stored_item = target
		print("pickup STOP: ", pinjoint.node_b)


func unstow(stored_item):
	if stored_item and parent_body:
		print("drop START: ", pinjoint.node_b)
		
		stored_item.reparent(self.get_parent())
		stored_item.global_position = global_position
		#pinjoint.node_b = NodePath("")
		#stored_item.mass = stored_mass
		#stored_item.remove_collision_exception_with(parent_body)
		#parent_body.remove_collision_exception_with(stored_item)
		
		stored_item = null
		print("drop STOP: ", pinjoint.node_b)


func swallow_object(new_object : ItemClass) -> void:
	stomach_contents.append(new_object)


#func drain_tick(delta) -> void:
	#storage_component.stored_nutrients.carb -= 2 * delta
	#storage_component.stored_nutrients.protein -= 2 * delta
	#storage_component.stored_nutrients.fat -= 2 * delta
	#storage_component.stored_nutrients.water -= 2 * delta
	#storage_component.stored_nutrients.vitamins -= 2 * delta
	#storage_component.stored_nutrients.minerals -= 2 * delta
	#storage_component.stored_nutrients.fiber -= 2 * delta
	#print(storage_component.stored_nutrients.protein, ", ", protein_bar.value)


#func digest_tick(delta) -> void:
	#for item in stomach_contents:
		#storage_component.stored_nutrients.carb -= item.material_data.nutrient_ref.change_carb_level(-10 * delta)
		#storage_component.stored_nutrients.protein -= item.material_data.nutrient_ref.change_protein_level(-10 * delta)
		#storage_component.stored_nutrients.fat -= item.material_data.nutrient_ref.change_fat_level(-10 * delta)
		#storage_component.stored_nutrients.water -= item.material_data.nutrient_ref.change_water_level(-10 * delta)
		#storage_component.stored_nutrients.vitamins -= item.material_data.nutrient_ref.change_vitamin_level(-10 * delta)
		#storage_component.stored_nutrients.minerals -= item.material_data.nutrient_ref.change_mineral_level(-10 * delta)
		#storage_component.stored_nutrients.fiber -= item.material_data.nutrient_ref.change_fiber_level(-10 * delta)
		#print(storage_component.stored_nutrients.protein, ", ", protein_bar.value, "; ", item)

func update_ui() -> void:
	pass
	#carb_bar.value = storage_component.stored_nutrients.carb
	#protein_bar.value = storage_component.stored_nutrients.protein
	#fat_bar.value = storage_component.stored_nutrients.fat
	#water_bar.value = storage_component.stored_nutrients.water
	#vitamin_bar.value = storage_component.stored_nutrients.vitamins
	#mineral_bar.value = storage_component.stored_nutrients.minerals
	#fiber_bar.value = storage_component.stored_nutrients.fiber
