extends PhysicsObject
class_name Creature

# components
@onready var interact_component :  = $Components/InteractComponent
@onready var interact_collider := $Components/InteractComponent/CollisionShape2D

@onready var label := $UI/Panel/Label
@onready var camera := $Camera2D
@onready var body := $Skeleton/Torso
@onready var hand_l := $Skeleton/Torso/HandL
@onready var hand_r := $Skeleton/Torso/HandR
@onready var frills_sprite := $Sprites/Frills
@onready var frills_collider := $Skeleton/Torso/Frills/CollisionShape2D

@onready var inventory := $Skeleton/Torso/Inventory

@export var move_speed := 100.0
@export var camera_zoom := 2.0

var buildup := 0.0
var buildup_increment := 0.4
var buildup_cap := 100.0

var linear_force = 5

var nearby_items := []


func get_input():
	# basic movement and rotaion
	body.look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	# Input dir is the intended direction. While possible, try to prioritise this. However, ragdolling
	# or limb damage overrides this. The overall goal will always be to follow the input dir
	# (or "abstract goal"), but other factors may get in the way that affect result (or "realised goal").
	
	var dist = self.global_position.distance_to(input_direction * move_speed)
	constant_force = input_direction * linear_force * dist
	
	# pickup / drop objects
	if Input.is_action_just_pressed("pickup"):
		var closest_item = calc_closest_item()
		print(1.1)
		if closest_item: 
			print(1.2)
			hand_r.stow(closest_item)
	if Input.is_action_just_pressed("drop"):
		print(2.1)
		if hand_r.get_child_count() > 2:
			print(hand_r.get_children())
			print(2.2)
			hand_r.unstow(hand_r.get_child(2))
		
	
	# raising/lowering defensive frills (resembeling a blue-tongued lizard)
	if Input.is_action_pressed("sprint"):
		frills_sprite.visible = true
		frills_collider.disabled = false
	if Input.is_action_just_released("sprint"):
		frills_sprite.visible = false
		frills_collider.disabled = true


func spore_update(delta):
	buildup += buildup_increment * delta
	label.text = "Build-up % : " + str(roundi(buildup))
	if buildup > buildup_cap:
		print(self, ": Lethal Buildup. Terminating...")
		queue_free()


func _ready():
	# tries to detect overlapping items by toggling a delayed collision shape
	interact_component.get_child(0).disabled = false


func _physics_process(delta):
	spore_update(delta)
	
	get_input()


func attack():
	# created a 'weapon class' so you can make a basic prototype
	# of a critter that can walk and punch glass, for example
	# ...check youtube and that good channel about OOP coding in godot
	## this should probably be a "use" function that CALLS any attached weapons
	## it's possible to add built-in claws too I suppose
	pass


func calc_closest_item():
	var closest_item
	for item in nearby_items:
		if closest_item == null: closest_item = item
		
		if (interact_component.global_position.distance_to(item.global_position)
		< interact_component.global_position.distance_to(closest_item.global_position)):
			closest_item = item
			## BUG add another check to ensure item is dropped. maybe check parent's class (make sure it isn't a holster/handle class)
	return closest_item


func _on_interact_component_body_entered(body):
	#print(body, ', ', body is RigidBody2D and body != self, body.grabbable)
	if body is RigidBody2D and body != self:
		#if body.grabbable:
			#print(true)
			nearby_items.append(body)


func _on_interact_component_body_exited(body):
	nearby_items.erase(body)
