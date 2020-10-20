extends "res://ammo/KinematicBullet.gd"

func _ready():
	damage = 100
	velocity = Vector2(2000,2000)
	._ready()

func handle_movement(delta) -> KinematicCollision2D:
	var frame_displacement:Vector2 = Vector2(VHoriz,VVert) * delta
	return move_and_collide(frame_displacement)

var collided_tile
func handle_collision(collision):
	if collision:
		if collision.collider.is_in_group("world"):
			collision.collider.damage_tile(rotation, collision)
			var this_collided_tile = collision.collider.world_to_map(collision.position+(Vector2.RIGHT.rotated(rotation) * 0.1))
			if this_collided_tile == collided_tile:
				queue_free()
			collided_tile = this_collided_tile
		if collision.collider.is_in_group("player"):
			collision.collider.take_damage(damage)
			queue_free()
	pass
