class_name Duck0Component extends BaseDuckComponent

static func create(
	location: Vector2,
	is_global: bool = true,
)->Duck0Component:
	var duck = load("res://components/ducks/Duck0Component.tscn")\
		.instantiate() as Duck0Component
	if not is_global:
		duck.position = location
	else:
		duck.global_position = location
	return duck
