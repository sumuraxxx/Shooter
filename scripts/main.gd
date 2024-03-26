extends Node

@export var max_trees = 30

var enemy_scene = preload("res://scenes/enemy.tscn")
var tree_scene = preload("res://scenes/tree.tscn")

var spawn_enemy_timer = 0
var spawn_enemy_interval = 2

@onready var tilemap = $TileMap

func _ready():
	get_tree().paused = false
	generation_trees()
	

func generation_trees() -> void:
	for i in range(max_trees):
		var tile_position = Vector2(randi_range(0, tilemap.get_used_rect().size.x), randi_range(0, tilemap.get_used_rect().size.y))
		var tree = tree_scene.instantiate()
		tree.position = tilemap.map_to_local(tile_position)
		add_child(tree)
		

func _process(delta):
	spawn_enemy_timer += delta
	if spawn_enemy_timer >= spawn_enemy_interval:
		spawn_enemy_timer = 0
		spawn_enemy()
		

func spawn_enemy():
	var tile_position = Vector2(randi_range(0, tilemap.get_used_rect().size.x), randi_range(0, tilemap.get_used_rect().size.y))
	
	var enemy = enemy_scene.instantiate()
	enemy.position = tilemap.map_to_local(tile_position)
	add_child(enemy)
