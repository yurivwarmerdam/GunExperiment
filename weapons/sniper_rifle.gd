extends "res://weapons/prototype_weapon.gd"

var bullet = preload("res://ammo/sniper_bullet.tscn")

func single_fire() ->void:
	if timer.is_stopped():
		var new_bullet = bullet.instance()
		new_bullet.position = $muzzle.get_global_position()
		new_bullet.global_rotation = global_rotation
		get_tree().get_root().add_child(new_bullet)
		timer.start()
