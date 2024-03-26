extends Control

@export var player: Player

@onready var health_bar = $VBoxContainer/PlayerHealthBar
@onready var mana_bar = $VBoxContainer/PlayerManaBar

func _ready():
	player.connect("health_change", update_health_bar)
	health_bar.max_value = player.health
	health_bar.value = health_bar.max_value
	
	player.connect("mana_change", update_mana_bar)
	mana_bar.max_value = player.max_mana
	mana_bar.value = mana_bar.max_value
	
	
func update_health_bar() -> void:
	health_bar.value = player.health	


func update_mana_bar() -> void:
	mana_bar.value = player.current_mana
		
