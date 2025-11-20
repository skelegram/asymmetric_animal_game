extends Node2D

func toxin_tick():
	for sibling in get_parent().get_children():
		if sibling.has_method("hurt"):
			sibling.hurt()
			print(sibling.name,  " murked by toxin damage.")

func _on_timer_timeout():
	toxin_tick()
