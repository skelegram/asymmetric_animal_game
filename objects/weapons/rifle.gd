extends ItemClass

@onready var muzzle_flash = $MuzzleFlash

func _ready():
	randomize()

func shoot():
	muzzle_flash.frame = randi_range(0, muzzle_flash.sprite_frames)
	muzzle_flash.show()
	await get_tree().create_timer(1).timeout
