extends TileMap

func damage_tile(projectile_rotation, collision):
	var collided_tile_v = world_to_map(collision.position+(Vector2.RIGHT.rotated(projectile_rotation) * 0.1))
	if get_cellv(collided_tile_v) == 0:
		set_cellv(collided_tile_v, -1)
