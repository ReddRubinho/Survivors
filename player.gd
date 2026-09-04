extends CharacterBody2D
@export var speed: float = 200.0
@export var max_health: int = 100
var health: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

func _take_damage(amount: int):
	health -= amount
	
	if health <= 0:
		die()

func die():
	var camera = get_node("Camera2D")
	var camera_position = camera.global_position
	
	remove_child(camera)
	get_parent().add_child(camera)
	
	camera.global_position = camera_position
	
	queue_free()

func _physics_process(_delta):
	var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = direction * speed
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
