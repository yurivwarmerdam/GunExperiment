extends Node

export var initial_lives:int = 3

var player_prototype = preload("res://Player.tscn")

var players:Array = []

signal player_0_HP(value)
signal player_0_lives(value)
signal player_0_swap_weapon(timer)
signal player_1_HP(value)
signal player_1_lives(value)
signal player_1_swap_weapon(timer)

func _ready():
	spawn_player(str(players.size()),Vector2(128,64))
	spawn_player(str(players.size()),Vector2(1760,64))

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_just_pressed("spawn_player"):
		spawn_player(str(players.size()),Vector2(100,500))

func spawn_player(number:String, new_position:Vector2):
	var new_player = player_prototype.instance()
	new_player.name = "Player_" + number
	new_player.left = "left_" + number
	new_player.right = "right_" + number
	new_player.up = "up_"+number
	new_player.down = "down_"+number
	new_player.jump = "jump_"+number
	new_player.shoot = "shoot_"+number
	new_player.select = "select_"+number
	new_player.position = new_position
	new_player.max_lives = initial_lives
	new_player.connect("HP_update", self, "_on_player_"+number+"_HP_update")
	new_player.connect("lives_update", self, "_on_player_"+number+"_lives_update")
	new_player.connect("swap_weapon", self, "_on_player_"+number+"_swap_weapon")
	add_child(new_player)
	players.append(new_player)

func _on_player_0_HP_update(value): emit_signal("player_0_HP", value)
func _on_player_0_lives_update(value): emit_signal("player_0_lives", value)
func _on_player_0_swap_weapon(timer): emit_signal("player_0_swap_weapon", timer)
func _on_player_1_HP_update(value):	emit_signal("player_1_HP", value)
func _on_player_1_lives_update(value): emit_signal("player_1_lives", value)
func _on_player_1_swap_weapon(timer): emit_signal("player_1_swap_weapon", timer)
