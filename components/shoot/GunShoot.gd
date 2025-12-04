class_name GunShoot extends AnimatedSprite2D

func _ready() -> void:
	animation_finished.connect(queue_free)
