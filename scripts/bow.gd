extends Node2D

var can_use = true

@onready var arrow_scene = preload("res://scenes/arrow.tscn")
@onready var muzzle = $Muzzle

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		shoot()
		

func change_rotation() -> void:
	rotation = (get_global_mouse_position() - global_position).angle() - PI/2
	

func shoot() -> void:
	if visible and can_use:
		var arrow = arrow_scene.instantiate()
		get_parent().get_parent().add_child(arrow)
		arrow.global_position = muzzle.global_position
		arrow.rotation = rotation
		$AudioStreamPlayer.play()
				
		couwdown_use_bow()
	

func couwdown_use_bow() -> void:
	can_use = false
	await get_tree().create_timer(0.5).timeout
	can_use = true	
	
	
func _physics_process(delta) -> void:
	change_rotation()
	
