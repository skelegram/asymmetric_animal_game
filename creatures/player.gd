extends PhysicsObject
class_name Creature

@onready var label := $UI/Panel/Label
@onready var camera := $Camera2D
@onready var body := $Skeleton/Torso
@onready var hand_l := $Skeleton/Torso/HandL
@onready var hand_r := $Skeleton/Torso/HandR
@onready var pickup_range := $Skeleton/Torso/PickupRange
@onready var pickup_collider := $Skeleton/Torso/PickupRange/CollisionShape2D
@onready var frills_sprite := $Sprites/Frills
@onready var frills_collider := $Skeleton/Torso/Frills/CollisionShape2D
@onready var holster_set := $Skeleton/Torso/Holsters

@export var move_speed := 100.0
@export var camera_zoom := 2.0

var buildup := 0.0
var buildup_increment := 0.4
var buildup_cap := 100.0

var linear_force = 5
var target = self.get_global_mouse_position()

var nearby_items := {}


func get_input():
	# basic movement and rotaion
	body.look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("left", "right", "up", "down")
	# Input dir is the intended direction. While possible, try to prioritise this. However, ragdolling
	# or limb damage overrides this. The overall goal will always be to follow the input dir
	# (or "abstract goal"), but other factors may get in the way that affect result (or "realised goal").
	
	## e.g. 'var actual_direction = ...'
	
	var dist = position.distance_to(target)
	constant_force = input_direction * linear_force * dist
	#velocity = input_direction * move_speed=
	
	# pickup / drop objects
	#if Input.is_action_pressed("pickup"):
		## make some manager function so that items and holsters are related
		## and can recognise / autoattach to each other
		#closest_item.reparent()
	#if Input.is_action_pressed("drop")
	
	# raising/lowering defensive frills (resembeling a blue-tongued lizard)
	if Input.is_action_pressed("sprint"):
		frills_sprite.visible = true
		frills_collider.disabled = false
	if Input.is_action_just_released("sprint"):
		frills_sprite.visible = false
		frills_collider.disabled = true


func attack():
	# created a 'weapon class' so you can make a basic prototype
	# of a critter that can walk and punch glass, for example
	# ...check youtube and that good channel about OOP coding in godot
	## this should probably be a "use" function that CALLS any attached weapons
	## it's possible to add built-in claws too I suppose
	pass


func spore_update(delta):
	buildup += buildup_increment * delta
	label.text = "Build-up % : " + str(roundi(buildup))
	if buildup > buildup_cap:
		print(self, ": Lethal Buildup. Terminating...")
		queue_free()

func _ready():
	pickup_collider.disabled = false

func _physics_process(delta):
	spore_update(delta)
	
	get_input()


func calc_closest_item():
	var closest_item : Node
	for item in nearby_items:
		# BUG to fix this, make sure no items spawn inside the pickup range
		# or try googling the problem. maybe doing a append of all colliding bodies
		# as the game loads (inside _ready)
		if (pickup_range.global_position.distance_to(nearby_items[item])
		< pickup_range.global_position.distance_to(nearby_items[closest_item])):
			closest_item = item
			## BUG add another check to ensure item is dropped. maybe check parent's class (make sure it isn't a holster/handle class)
	return closest_item

func _on_pickup_range_body_entered(body) -> void:
	nearby_items[body] = body.global_position
	#calc_closest_item()

func _on_pickup_range_body_exited(body) -> void:
	nearby_items.erase(body)
	#calc_closest_item()
