extends "res://weapons/prototype_weapon.gd"

var genade = preload("res://ammo/genade.tscn")

func auto_fire() ->void:
	if timer.is_stopped():
		var new_grenade = genade.instance()
		new_grenade.position =  $muzzle.get_global_position()
		new_grenade.global_rotation = global_rotation
		get_tree().get_root().add_child(new_grenade)
		timer.start()
