extends CanvasLayer

@onready var buildup_label = $Control/MarginContainer/Label

var buildup = 0


func update_buildup(value):
	buildup_label.text = "label : " + str(value)
	
