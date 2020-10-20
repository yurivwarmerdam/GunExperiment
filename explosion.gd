extends Node2D

onready var animated_sprite =  $AnimatedSprite
onready var tilemap:TileMap = get_tree().get_root().get_node("World/TileMap")
onready var tile_size = tilemap.cell_size.x
onready var half_tile = tilemap.cell_size/2
onready var radius = 16

func _ready():
	animated_sprite.frame = 0
	animated_sprite.connect("animation_finished",self,"_on_animation_finished")
	
	

func _on_animation_finished():
	destroy_circle()
	queue_free()
	pass


func destroy_circle():
	var top_left_tile:Vector2 = tilemap.world_to_map(Vector2(position.x - radius, position.y - radius))
	var bottom_right_tile:Vector2 = tilemap.world_to_map(Vector2(position.x + radius, position.y + radius))+Vector2.ONE
	var y_start = top_left_tile.y
	var y_end = bottom_right_tile.y
	
	for y in range(y_start, y_end):
		var x_start = top_left_tile.x
		var x_end = bottom_right_tile.x
		while !rect_intersects_circle(Vector2(x_start*tile_size,y*tile_size)+half_tile):
			x_start+=1
		while !rect_intersects_circle(Vector2(x_end*tile_size,y*tile_size)+half_tile):
			x_end-=1
		for x in range(x_start,x_end+1):
			tilemap.damage_tile_map(Vector2(x,y))
		
func rect_intersects_circle(tile_center:Vector2) ->bool:
	var difference:Vector2 = tile_center - position
	var difference_positive:Vector2 = difference.abs()
	var closest:Vector2 = difference_positive - half_tile
	var closest_positive:Vector2 = Vector2(max(closest.x,0), max(closest.y, 0))
	return closest_positive.length() <= radius
