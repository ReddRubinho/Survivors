extends CharacterBody2D

var player: Node2D

func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
	
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 100.0
	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_damage_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body._take_damage(10)
