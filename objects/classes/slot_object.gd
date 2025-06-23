extends Marker2D
class_name SlotObject

var stored_item : WeaponObject

@export var slot_weight : WeaponObject.weight_type
@export var slot_weight_limit : WeaponObject.weight_type

func stow(target):
	target.reparent(self)
	target.global_position = self.global_position
	stored_item = target

func unstow(stored_item):
	stored_item.reparent(self.get_parent())
	stored_item.global_position = self.get_parent().global_position
	stored_item = null
