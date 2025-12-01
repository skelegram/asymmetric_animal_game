extends Node
class_name MaterialType

var materials : Dictionary = {
	"Rock" : Nutrients.new()}

func _ready():
	materials["Rock"].init_carb = 0.0
	materials["Rock"].init_prot = 0.0
	materials["Rock"].init_fat = 0.0
	materials["Rock"].init_wat = 0.0
	materials["Rock"].init_vita = 0.0
	materials["Rock"].init_min = 0.0
	materials["Rock"].init_fib = 0.0
