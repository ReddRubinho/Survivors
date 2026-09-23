extends Node2D
@export var damage: int = 20
@export var attack_cooldown: float = 0.8
@export var attack_duration:float = 0.25

var attack_timer:float = 0.0
var enemies_hit: Array[Node] = []

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


func attack():
	enemies_hit.clear()
	
	var tween = create_tween()
	
	$Slashpivot.rotation = deg_to_rad(-120)
	
	tween.tween_property(
		$Slashpivot,
		"rotation",
		deg_to_rad(120),
		attack_duration
	)
	tween.tween_property(
		$Slashpivot,
		"rotation",
		0,
		0.1
	)


func _physics_process(delta: float) -> void:
	var nearest_enemy = get_nearest_enemy()
	
	if not nearest_enemy:
		return
	
	look_at(nearest_enemy.global_position)
	
	attack_timer -= delta
	
	if attack_timer <= 0:
		var enemies_in_range = $AttackRange.get_overlapping_bodies()
		print(enemies_in_range.size(), " enemigos")
		
		for enemy in enemies_in_range:
			print("detectado")
			if enemy.is_in_group("enemy"):
				print("atacando...")
				attack()
				attack_timer = attack_cooldown
				break


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hit_area_body_entered(body: Node2D) -> void:
	if not body.is_in_group("enemy"):
		return
	
	if body in enemies_hit:
		return
	
	body.take_damage(damage)
	enemies_hit.append(body)
