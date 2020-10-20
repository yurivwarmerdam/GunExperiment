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
	var collision = handle_movement(delta)
	handle_collision(collision)
	pass

func handle_movement(delta) -> KinematicCollision2D:
	var frame_displacement:Vector2 = Vector2(VHoriz,0) * delta
	VVert+=gravity*delta
	frame_displacement.y = VVert *delta
	rotation=frame_displacement.angle()
	return move_and_collide(frame_displacement)

func handle_collision(collision):
	if collision:
		if collision.collider.is_in_group("world"):
			collision.collider.damage_tile(rotation, collision)
		if collision.collider.is_in_group("player"):
			collision.collider.take_damage(damage)
		queue_free()
	pass

#debug function:
func tracer():
	var marker = pellet_marker.instance()
	marker.position = position
	get_tree().get_root().add_child(marker)
