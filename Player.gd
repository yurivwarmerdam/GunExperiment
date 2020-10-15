extends KinematicBody2D

export var max_HP = 100
export var max_lives = 3

#export var reload = 100

export var move_speed = 500
export var jump_force = 1000
export var gravity = 50
export var max_fall_speed = 1000
export var aim_speed = 5

export var left:String = "left_0"
export var right:String = "right_0"
export var up:String = "up_0"
export var down:String = "down_0"
export var jump:String = "jump_0"
export var shoot:String = "shoot_0"
export var select:String = "select_0"

signal HP_update(value)
signal lives_update(value)
signal swap_weapon(timer)

onready var anim_player = $AnimationPlayer
onready var sprite = $Sprite
onready var arm = $arm

const HALF_PI = PI/2

var is_dead = false
var y_velocity = 0
var facing_right = true
var arm_rotation_r = HALF_PI
var spawn_point:Vector2
var HP:int
var lives:int

var weapons = []
var current_weapon_id = 0
var current_weapon

func _ready():
	weapons = arm.get_children()
	current_weapon = weapons[current_weapon_id]
	emit_signal("swap_weapon", current_weapon.get_node("Timer"))
	spawn_point = position
	set_HP(max_HP)
	set_lives(max_lives)

# warning-ignore:unused_argument
func _physics_process(delta):
	if !is_dead:
		handle_movement()

# warning-ignore:unused_argument
func _process(delta):
	if !is_dead:
		handle_aim(delta)
		if Input.is_action_just_pressed(shoot):
			current_weapon.single_fire()
		if Input.is_action_pressed(shoot):
			current_weapon.auto_fire()
		if Input.is_action_just_pressed(select):
			swap_weapon()

func handle_movement():
	var move_dir = 0
	if Input.is_action_pressed(left):
		move_dir -=1
	if Input.is_action_pressed(right):
		move_dir +=1
# warning-ignore:return_value_discarded
	move_and_slide(Vector2(move_dir*move_speed,y_velocity), Vector2(0,-1))

	var grounded = is_on_floor()
	var ceilinged = is_on_ceiling()
	y_velocity += gravity
	if grounded and Input.is_action_just_pressed(jump):
		y_velocity = -jump_force
	if grounded and y_velocity >= 5:
		y_velocity = 5
	if y_velocity > max_fall_speed:
		y_velocity = max_fall_speed

	if ceilinged and y_velocity <0:
		y_velocity = 0

	if facing_right and move_dir <0:
		flip()
	if !facing_right and move_dir>0:
		flip()
		
	if grounded:
		if move_dir == 0:
			play_animation("Idle")
		else:
			play_animation("Walk")
	else:
		play_animation("Jump")

func handle_aim(delta):
	var aim:float = 0
	if Input.is_action_pressed(up):
		aim -= delta * aim_speed
	if Input.is_action_pressed(down):
		aim += delta * aim_speed
	arm_rotation_r = clamp(arm_rotation_r + aim, 0,PI)
	var final_rotation = (arm_rotation_r if facing_right else -arm_rotation_r) -HALF_PI
	arm.rotation = final_rotation

func flip():
	facing_right = !facing_right
	sprite.flip_h = !sprite.flip_h

func play_animation(animation_name:String):
	if anim_player.is_playing() and anim_player.current_animation == animation_name:
		return
	anim_player.play(animation_name)

func take_damage(damage:int) ->void:
	set_HP(HP-damage)
	if HP <=0: die()

func set_HP(value):
	HP = value
	emit_signal("HP_update", HP)
	
func set_lives(value):
	lives = value
	emit_signal("lives_update", lives)

func die() ->void:
	is_dead = true
	if lives > 0:
		set_lives(lives-1)
		$CollisionShape2D.disabled = true
		$CollisionShape2D2.disabled = true
		visible = false
		var respawn_timer = Timer.new()
		respawn_timer.one_shot = true
		respawn_timer.connect("timeout", self,"_on_respawn_timer_timeout")
		add_child(respawn_timer)
		respawn_timer.start()
	else:
		#TODO: do proper game over handling....
		$CollisionShape2D.disabled = true
		$CollisionShape2D2.disabled = true
		visible = false
		pass
	pass

func _on_respawn_timer_timeout():
	respawn()
	pass

func respawn():
	set_HP(max_HP)
	position = spawn_point
	$CollisionShape2D.disabled = false
	$CollisionShape2D2.disabled = false
	visible = true
	is_dead = false
	pass

func swap_weapon():
	current_weapon_id = (current_weapon_id + 1) % weapons.size()
	var new_weapon = weapons[current_weapon_id]
	current_weapon.hide()
	new_weapon.show()
	current_weapon = new_weapon
	emit_signal("swap_weapon", current_weapon.get_node("Timer"))
