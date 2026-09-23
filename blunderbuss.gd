extends Node2D

@export var projectile_scene: PackedScene
@export var damage: int = 6
@export var attack_cooldown: float = 1.0
@export var projectile_count: int = 6
@export var spread_angle: float = 30.0

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
	
	if enemy :
		look_at(enemy.global_position)
		
		attack_timer -= delta
		
		if attack_timer <= 0:
			var current_projectile_count = randi_range(
				projectile_count - 1,
				projectile_count + 1
			)
			
			for i in current_projectile_count:
				var projectile = projectile_scene.instantiate()
				
				get_tree().current_scene.add_child(projectile)
				
				projectile.damage = damage
				projectile.global_position = $Sprite2D.global_position
				
				var direction = global_position.direction_to(enemy.global_position)
				
				var spread = deg_to_rad(spread_angle)
				var random_angle = randf_range(-spread / 2.0, spread / 2.0)
				
				projectile.direction = direction.rotated(random_angle)
			
			attack_timer = attack_cooldown
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
