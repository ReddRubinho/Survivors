extends Area2D
@export var speed: float = 500.0
@export var max_distance: float = 500.0

var direction: Vector2
var distance_traveled: float = 0.0 

func _physics_process(delta: float) -> void:
	var movement = direction * speed * delta
	position += movement
	
	distance_traveled += movement.length()
	
	if distance_traveled >= max_distance:
		queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(10)
		queue_free()
