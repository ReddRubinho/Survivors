extends CharacterBody2D
@export var speed: float = 200.0
func _physics_process(_delta):
	var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	velocity = direction * speed
	move_and_slide()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
