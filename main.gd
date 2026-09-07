extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_level_up_signal() -> void:
	print("EL jugador ha subido de nivel!")
	$UpgradeMenu.visible = true
	get_tree().paused = true


func _on_button_pressed() -> void:
	$Player.increase_speed(1.10)
	$UpgradeMenu.visible = false
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	$Player/Weapon.increase_attack_speed(0.5)
	$UpgradeMenu.visible = false
	get_tree().paused = false


func _on_button_3_pressed() -> void:
	$Player/Weapon.damage *= 3.00
	$UpgradeMenu.visible = false
	get_tree().paused = false
