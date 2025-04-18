extends Node2D
class_name FungalNode

var scene = preload("res://objects/creatures/fungal_node.gd")

# a simple example of primative communication between spore colonies
## use "emit_signal("fungal_ping", self)" to send it
signal fungal_ping(data)

# controls hibernation due to external conditions
var dormant := false

# stores every single fungal node in the connected colony
var colony := []


func _ready():
	print(typeof(scene))


func create_spore(spore_scene : Object, spore_class : FungalNode):
	var new_spore = spore_scene.instantiate()
	
	colony.append(new_spore)
	return new_spore


func kill_spore():
	colony.erase(self)
