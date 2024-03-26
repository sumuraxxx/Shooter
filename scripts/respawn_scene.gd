extends Node2D


func _on_area_2d_body_entered(body):
	$WorldEnvironment.environment.glow_strength += 1
	get_tree().paused = true
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	
