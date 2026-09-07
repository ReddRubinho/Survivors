extends CharacterBody2D
signal level_up_signal

@export var speed: float = 200.0
@export var max_health: int = 100
@export var experience: int = 0
@export var level: int = 1
@export var experience_to_next_level: int = 100

var health: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health


func add_experience(amount: int):
	experience += amount
	
	if experience >= experience_to_next_level:
		level_up()


func level_up():
	level += 1
	experience -= experience_to_next_level
	experience_to_next_level *= 1.2
	print("level ", level, "experience needed: ", experience_to_next_level)
	level_up_signal.emit()


func increase_speed(amount: float):
	speed *= amount


func increase_max_health(amount: float):
	var new_max_health = round(max_health * amount)
	health += new_max_health - max_health
	max_health = new_max_health


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


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = direction * speed
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
