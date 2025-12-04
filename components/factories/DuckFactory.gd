class_name DuckFactory extends Node

@export
var duck_container: Node

func _ready() -> void:
	print('执行了DuckFactory...')

func _on_timer_timeout() -> void:
	var duck_type = randi() % 2
	var duck: BaseDuckComponent
	var position = Vector2(200 + randf() * 624.0, 600)
	if duck_type == 0:
		duck = Duck0Component.create(position, false)
	elif duck_type == 1:
		duck = Duck1Component.create(position, false)
	else: return
	duck.speed = randf() * 70.0 + 50.0
	duck.gravity = randf() * 200.0 + 9.8
	duck_container.add_child(duck) #添加鸭子到对应的视图容器中
