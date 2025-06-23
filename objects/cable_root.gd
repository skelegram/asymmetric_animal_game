extends Node2D

@onready var cable_anchor : StaticBody2D = $CableAnchor
var cable_segment : PackedScene = preload("res://objects/cable_segment.tscn")

@export var cable_nodes : int = 0
var previous_cable : Node


func _ready():
	generate_chain()


func generate_chain() -> void:
	for cable in cable_nodes:
		# create new cable segment
		var new_segment = cable_segment.instantiate()
		add_child(new_segment)
		
		# define unique conditions for first cable in chain
		var previous_link = cable_anchor
		var cable_offset = Vector2(0, new_segment.cable_length / 2)
		
		# else, define default spawn conditions
		if previous_cable:
			previous_link = previous_cable
			cable_offset = Vector2(0, previous_cable.cable_length / 2)
		
		# run defined conditions
		new_segment.pin_link = previous_link
		new_segment.rotation = self.rotation
		new_segment.position = self.position + cable_offset
		
		previous_cable = new_segment
