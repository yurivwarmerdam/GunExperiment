extends KinematicBody2D

var pellet_marker = preload("res://pellet_marker.tscn")

export var gravity: int = 400 #m/s^2
export var damage:int = 10

var velocity: Vector2 = Vector2(600,600)
var VHoriz:float
var VVert:float

func _ready():
	VHoriz = (Vector2.RIGHT.rotated(rotation) * velocity).x
	VVert = (Vector2.RIGHT.rotated(rotation) * velocity).y
	pass


func _physics_process(delta):
	#tracer()
	var frame_displacement:Vector2 = Vector2(VHoriz,0) * delta
	VVert+=gravity*delta
	frame_displacement.y = VVert *delta
	rotation=frame_displacement.angle()
	
	var collision = move_and_collide(frame_displacement)
	if collision:
		if collision.collider.is_in_group("world"):
			var collided_tile = collision.collider.world_to_map(collision.position+(Vector2.RIGHT.rotated(rotation) * 0.1))
			collision.collider.set_cellv(collided_tile, -1)
		queue_free()
		if collision.collider.is_in_group("player"):
			collision.collider.take_damage(damage)
	pass

#debug function:
func tracer():
	var marker = pellet_marker.instance()
	marker.position = position
	get_tree().get_root().add_child(marker)
