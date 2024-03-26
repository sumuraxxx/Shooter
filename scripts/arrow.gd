class_name Arrow
extends Area2D

@export var speed := 500.0

var movement_vector := Vector2(0, 1)

func _physics_process(delta):
	if position.x > 1000 or position.y > 1000:
		queue_free()
	global_position += movement_vector.rotated(rotation) * speed * delta


func _on_body_entered(body):
	if body is Enemy:
		body.queue_free()
	if body is PTree:
		body.queue_free()	
	$CPUParticles2D.emitting = true
	$Sprite2D.visible = false
	$CollisionShape2D.queue_free()
	await get_tree().create_timer(0.8).timeout
	queue_free()
	
