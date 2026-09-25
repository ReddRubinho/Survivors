extends Node2D
@export_category("Mision")
@export var mission_duration: float = 1800.0

var mission_time: float
var displayed_seconds: int = -1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mission_time = 0.0
	update_mission_timer()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mission_time >= mission_duration:
		mission_finished()
		return
	
	mission_time += delta
	update_mission_timer()


func mission_finished() -> void:
	print("se acaba el tiempo")
	get_tree().paused = true


func update_mission_timer() -> void:
	var total_seconds = floori(mission_time)
	
	if total_seconds == displayed_seconds:
		return
	
	displayed_seconds = total_seconds
	
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	$HUD/MissionTimer.text = "%02d:%02d" % [minutes, seconds]
	$HUD/EnemyCount.text = "Enemigos: %d / %d" % [
		get_tree().get_nodes_in_group("enemy").size(), 
		$EnemySpawner.calculate_enemy_population(), 
		]
	$HUD/PlayerLevel.text = "Nivel: %d " % $Player.level


func _on_player_level_up_signal() -> void:
	print("EL jugador ha subido de nivel!")
	$UpgradeMenu.visible = true
	get_tree().paused = true
	$Player.increase_max_health(1.20)
	


func _on_button_pressed() -> void:
	$Player.increase_speed(1.10)
	$UpgradeMenu.visible = false
	get_tree().paused = false


func _on_button_2_pressed() -> void:
	$Player/Weapons/Pistol.increase_attack_speed(0.5)
	$UpgradeMenu.visible = false
	get_tree().paused = false


func _on_button_3_pressed() -> void:
	$Player/Weapons/Pistol.increase_damage(3.0)
	$UpgradeMenu.visible = false
	get_tree().paused = false
