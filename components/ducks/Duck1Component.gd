class_name Duck1Component extends BaseDuckComponent

static func create(
	location: Vector2,
	is_global: bool = true,
)->Duck1Component:
	var duck = load("res://components/ducks/Duck1Component.tscn")\
		.instantiate() as Duck1Component
	if not is_global:
		duck.position = location
	else:
		duck.global_position = location
	return duck
