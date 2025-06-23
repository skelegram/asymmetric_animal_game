extends Node2D

@onready var pin_link :
	get:
		return $PinJoint2D.node_a

@onready var cable_length : int :
	get:
		return $Cable/CollisionShape2D.shape.size.y

func _process(delta):
	position = Vector2.ZERO
	print(global_position, " | ", position)
