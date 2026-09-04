extends CharacterBody2D
@export var max_health: int = 30
var health: int
var is_dead: bool = false

var player: Node2D

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	if not is_instance_valid(player):
		return
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health
	player = get_tree().get_first_node_in_group("player")


func take_damage(amount:int):
	if is_dead:
		return
	
	health -= amount
	
	if health <= 0:
		die()


func die():
	is_dead = true
	player.add_experience(10)
	print(player.experience)
	$DeathTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body._take_damage(10)


func _on_death_timer_timeout() -> void:
	queue_free()
