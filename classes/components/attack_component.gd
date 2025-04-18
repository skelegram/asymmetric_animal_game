extends Area2D
class_name AttackComponent

@export var damage_types : Array[DamageType]

func attack(damage_type : DamageType):
	pass


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		var attack = AttackType
		attack.attack_damage
		attack.damage_types
		attack.attack_position
		attack.attack_vector
	pass
