class_name Enemy extends CharacterBody2D

@export var speed: int = 50

var damage := 10
var speed_attack_in_sec := 1.0
var player_in_area = false
var is_idle = false

@onready var target: CharacterBody2D = $"../Player"
@onready var nav_agent = $NavigationAgent2D

func _ready() -> void:
	$AnimatedSprite2D.play()
	make_path()
	

func movement() -> void:
	if !player_in_area:
		var direction = to_local(nav_agent.get_next_path_position()).normalized()	
		velocity = direction * speed
	

func make_path() -> void:
	nav_agent.target_position = target.global_position
	

func update_animation() -> void:
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0 or !is_idle:
		$AnimatedSprite2D.flip_h = true
		
				
func _physics_process(delta):
	movement()
	update_animation()
	move_and_slide()
		

func _on_timer_timeout():
	make_path()


func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_area = true
		velocity = Vector2.ZERO
		$AnimatedSprite2D.animation = "idle"
		
		if body.global_position.x > global_position.x:
			is_idle = true
			
		deal_damage_player(body)	


func deal_damage_player(player: Player) -> void:
	while player_in_area:
		if player_in_area:
			player.take_damage(damage)
		if player.is_life:	
			await get_tree().create_timer(speed_attack_in_sec).timeout	
	
	
func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_area = false
		$AnimatedSprite2D.animation = "walk"
