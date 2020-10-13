extends RigidBody2D


#deprecated
func _on_Bullet_body_entered(body):
	if body is TileMap:
		print("tiles")	
		
	if !body.is_in_group("player"):
		print("hit battleship")
		var my_pos = (self.position/32).floor()
		print(my_pos)
		body.set_cellv(my_pos+Vector2.LEFT, -1)
		body.set_cellv(my_pos+Vector2.RIGHT, -1)
		body.set_cellv(my_pos+Vector2.UP, -1)
		body.set_cellv(my_pos+Vector2.DOWN, -1)
		
		body.set_cellv(my_pos+Vector2(1,1), -1)
		body.set_cellv(my_pos+Vector2(-1,1), -1)
		body.set_cellv(my_pos+Vector2(1,-1), -1)
		body.set_cellv(my_pos+Vector2(-1,-1), -1)
		queue_free()
	else:
		print("bloop")
		queue_free()
