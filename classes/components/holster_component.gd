extends StaticBody2D
class_name Holster

@onready var pinjoint : PinJoint2D = $PinJoint2D

var stored_item : ObjectClass
# functions as a pouch with true or a hand with false
@export var storage_slot : bool = true
@export var slot_weight : ObjectData.weight_type = ObjectData.weight_type.UNIVERSAL
@export var parent_body : Node


func _physics_process(delta):
	if stored_item and parent_body:
		stored_item.linear_velocity = parent_body.linear_velocity
		stored_item.angular_velocity = parent_body.angular_velocity


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
