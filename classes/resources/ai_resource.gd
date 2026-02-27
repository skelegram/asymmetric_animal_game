extends Resource
class_name AIResource

@export var max_pack_size : int = 1
@export var navigation_attempts : int = 5
@export var pack_members : Array[CreatureResource] = []
@export var tracked_objects : Dictionary[ObjectResource, float] = {}
@export var tracked_locations : Dictionary[Vector2, float] = {}
@export var seed_val : float = 0
@export_range(-50.0, 50.0) var awareness_influence : int
@export var awareness : int
@export_range(-50.0, 50.0) var aggression_influence : int
@export var aggression : int
