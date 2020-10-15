extends Control

onready var player_handler = $"../player_handler"

var reload_timer_0:Timer
var reload_timer_1:Timer

var tst_timer

func _ready():
	player_handler.connect("player_0_HP",self, "_on_player_0_HP_update")
	player_handler.connect("player_1_HP",self, "_on_player_1_HP_update")
	player_handler.connect("player_0_lives",self, "_on_player_0_lives_update")
	player_handler.connect("player_1_lives",self, "_on_player_1_lives_update")
	player_handler.connect("player_0_swap_weapon",self, "_on_player_0_swap_weapon")
	player_handler.connect("player_1_swap_weapon",self, "_on_player_1_swap_weapon")
	
	tst_timer = Timer.new()
	add_child(tst_timer)
	tst_timer.start()
	$VBoxContainer_0/Reload_bar.max_value = tst_timer.wait_time
	$VBoxContainer_0/Reload_bar.value = tst_timer.time_left


func _on_player_0_HP_update(value: int)->void: $VBoxContainer_0/HP_bar.value = value
func _on_player_1_HP_update(value: int)->void: $VBoxContainer_1/HP_bar.value = value
func _on_player_0_lives_update(value: int)->void: $VBoxContainer_0/Lives_Container/lives_num.text = str(value)
func _on_player_1_lives_update(value: int)->void: $VBoxContainer_1/Lives_Container/lives_num.text = str(value)
func _on_player_0_swap_weapon(timer)->void: 
	reload_timer_0 = timer
	$VBoxContainer_0/Reload_bar.max_value = timer.wait_time *100
func _on_player_1_swap_weapon(timer)->void: 
	reload_timer_1 = timer
	$VBoxContainer_1/Reload_bar.max_value = timer.wait_time *100

func _process(delta):
	$VBoxContainer_0/Reload_bar.value = $VBoxContainer_0/Reload_bar.max_value - (reload_timer_0.time_left * 100)
	$VBoxContainer_1/Reload_bar.value = $VBoxContainer_1/Reload_bar.max_value - (reload_timer_1.time_left * 100)
	pass
