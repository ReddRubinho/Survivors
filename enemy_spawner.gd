extends Node2D

@export var enemy_scene: PackedScene

func spawn_enemy():
	var enemy= enemy_scene.instantiate()
	enemy.position = Vector2(40, 30)
	get_parent().add_child.call_deferred(enemy)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	spawn_enemy()
