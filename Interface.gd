extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
onready var player_handler = $"../PlayerHandler"

func _ready():

	player_handler.connect("player_0_HP",self, "_on_player_0_HP_update")
	player_handler.connect("player_1_HP",self, "_on_player_1_HP_update")
	player_handler.connect("player_0_lives",self, "_on_player_0_lives_update")
	player_handler.connect("player_1_lives",self, "_on_player_1_lives_update")
	

func _on_player_0_HP_update(value: int)->void: $VBoxContainer_0/HP_bar.value = value
func _on_player_1_HP_update(value: int)->void: $VBoxContainer_1/HP_bar.value = value
func _on_player_0_lives_update(value: int)->void: $VBoxContainer_0/Lives_Container/lives_num.text = str(value)
func _on_player_1_lives_update(value: int)->void: $VBoxContainer_1/Lives_Container/lives_num.text = str(value)
