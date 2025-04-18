extends StaticBody2D
class_name SlotObject

@onready var storage_slot : bool = true
@onready var pinjoint : PinJoint2D = $PinJoint2D
@export var slot_weight : PhysicsObject.weight_type = PhysicsObject.weight_type.UNIVERSAL

var stored_item : PhysicsObject

func stow(target):
	print("pickup START: ", pinjoint.node_b)
	target.global_position = pinjoint.global_position
	pinjoint.node_b = target.get_path()
	if not storage_slot:
		target.freeze = true
		
	stored_item = target
	print("pickup STOP: ", pinjoint.node_b)

func unstow(stored_item):
	print("drop START: ", pinjoint.node_b)
	stored_item.reparent(self.get_parent())
	stored_item.global_position = self.get_parent().global_position
	pinjoint.node_b = NodePath("")
	if not storage_slot:
		stored_item.freeze = false
	stored_item = null
	print("drop STOP: ", pinjoint.node_b)
