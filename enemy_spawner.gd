extends Node2D

@export_category("Enemigos")
@export var enemy_scene: PackedScene

@export_category("Poblacion")

@export var base_enemies:int = 50

@export_category("Escalado por nivel")
@export var level_multiplier = 1.0


@export_category("Escalado por tiempo")
@export var time_multiplier = 0.0

@export_category("Distancia de aparicion")
@export_range(100.0, 300.0, 1.0)
var min_spawn_percentage: float = 110.0
@export_range(100.0, 300.0, 1.0)
var max_spawn_percentage: float = 140.0



@export_category("Jugador")
@export var player: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_enemy_population()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_enemy_population()


func update_enemy_population() -> void:
	if not player: 
		return
	
	var target_population = calculate_enemy_population()
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	var enemy_count = enemies.size()
	
	print(enemy_count, " enemigos")
	
	if enemy_count >= target_population:
		return
	
	
	var enemies_to_spawn = target_population - enemy_count
	
	for i in enemies_to_spawn:
		spawn_enemy()


func calculate_enemy_population() -> int:
	var player_level = player.level 
	
	var population = base_enemies
	
	population += player.level * level_multiplier
	
	return roundi(population)


func spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	
	var angle = randf_range(0.0, TAU)
	
	var viewport_size = get_viewport().get_visible_rect().size
	
	var camera = player.get_node("Camera2D")
	var zoom = camera.zoom
	
	var visible_size = viewport_size / zoom
	var half_size = visible_size / 2.0
	
	var direction = Vector2.RIGHT.rotated(angle)
	
	var horizontal_distance = INF
	var vertical_distance = INF
	
	if abs(direction.x) > 0.001:
		horizontal_distance = half_size.x / abs(direction.x)
	
	if abs(direction.y) > 0.001:
		vertical_distance = half_size.y / abs(direction.y)
	
	var screen_edge_distance = min(
		horizontal_distance,
		vertical_distance
	)
	
	var spawn_percentage = randf_range(
		min_spawn_percentage,
		max_spawn_percentage
	) / 100.0
	
	var spawn_distance = screen_edge_distance * spawn_percentage
	
	var spawn_position = player.global_position + direction * spawn_distance
	
	enemy.global_position = spawn_position
	
	get_tree().current_scene.add_child.call_deferred(enemy)
