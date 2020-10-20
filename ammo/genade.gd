extends "res://ammo/KinematicBullet.gd"

var explosion = preload("res://explosion.tscn")

func handle_collision(collision):
	if collision:
		var new_explosion = explosion.instance()
		new_explosion.position=position
		get_tree().get_root().add_child(new_explosion)
		queue_free()
	pass
