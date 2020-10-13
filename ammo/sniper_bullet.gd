extends "res://ammo/KinematicBullet.gd"

func _ready():
	damage = 90
	velocity = Vector2(2000,2000)
	._ready()

func handle_movement(delta) -> KinematicCollision2D:
	var frame_displacement:Vector2 = Vector2(VHoriz,VVert) * delta
	return move_and_collide(frame_displacement)
