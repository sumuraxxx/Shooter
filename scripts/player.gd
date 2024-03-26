class_name Player
extends CharacterBody2D

signal health_change
signal mana_change

@export var speed: int = 100
@export var max_mana := 100

var is_life = true
var health := 100
var current_mana := max_mana
var teleportation_cost := 100
var mana_regeneration_rate := 10

@onready var animation = $AnimationPlayer
@onready var bow = $Bow

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if current_mana >= teleportation_cost:
			current_mana -= teleportation_cost
			emit_signal("mana_change")
			teleportation()
			restore_mana()
		
				
func player_movement() -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_top", "move_bottom")
	velocity = direction * speed
	

func update_animation() -> void:
	var direction = 'idle'
	bow.visible = true
	
	if velocity.x < 0:
		direction = 'move_left'
	
	if velocity.x > 0:
		direction = 'move_right'
	
	if velocity.y < 0:
		direction = 'move_up'
		bow.visible = false
		
	if velocity.y > 0:
		direction = 'move_down'	
	
	animation.play(direction)


func update_sounds() -> void:
	if velocity != Vector2(0, 0):
		if $Walking/Timer.time_left == 0:
			$Walking.pitch_scale = 1 + randf_range(-0.1, 0.1)
			$Walking.playing = true
			$Walking/Timer.wait_time = randf_range(0.2, 0.5)
			$Walking/Timer.start()
	
	
func teleportation() -> void:
	$CPUParticles2D.emitting = true
	var mouse_position = get_global_mouse_position()
	await get_tree().create_timer(1).timeout
	global_position = mouse_position
	$CPUParticles2D.emitting = true
	

func restore_mana() -> void:
	while current_mana < max_mana:
		current_mana += mana_regeneration_rate
		emit_signal("mana_change")
		await get_tree().create_timer(1).timeout
	
	
func take_damage(damage: int) -> void:
	health -= damage
	emit_signal("health_change")
	if is_health_below_zero():
		is_life = false
		get_tree().change_scene_to_file("res://scenes/respawn_scene.tscn")


func is_health_below_zero() -> bool:
	if health <= 0:
		return true
	return false	
	
				
func _physics_process(delta):
	player_movement()
	update_animation()
	update_sounds()
	move_and_slide()
	
