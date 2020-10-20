extends TileMap

func damage_tile(projectile_rotation, collision):
	var collided_tile_v = world_to_map(collision.position+(Vector2.RIGHT.rotated(projectile_rotation) * 0.1))
	damage_tile_map(collided_tile_v)

func damage_tile_map(at_pos:Vector2):
	if get_cellv(at_pos) == 0:
		set_cellv(at_pos, -1)
