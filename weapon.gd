extends Node2D
@export var projectile_scene: PackedScene
@export var attack_cooldown: float = 0.3
var attack_timer: float = 0.0


func get_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest_enemy = null
	var nearest_distance = INF
	
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		
		if distance < nearest_distance:
			nearest_distance = distance
			nearest_enemy = enemy
	return nearest_enemy


func _physics_process(delta: float) -> void:
	var enemy = get_nearest_enemy()
	if enemy:
		look_at(enemy.global_position)
		
		attack_timer -= delta
		
		if attack_timer <= 0:
			var projectile = projectile_scene.instantiate()
			get_parent().get_parent().add_child(projectile)
			
			projectile.global_position = $Sprite2D.global_position
			projectile.direction = global_position.direction_to(enemy.global_position)
			
			attack_timer = attack_cooldown


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
