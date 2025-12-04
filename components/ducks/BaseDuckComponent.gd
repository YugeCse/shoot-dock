## 鸭子组件基类
class_name BaseDuckComponent 
extends CharacterBody2D

@export
var speed: float = 120.0

@export
var gravity: float = 9.8

@export
var direction: Vector2 = Vector2.LEFT

@export
var sprite: AnimatedSprite2D

@export
var collision_shape: CollisionShape2D

@export
var audio_player: AudioStreamPlayer

@export
var duck_state: Enums.DuckState = Enums.DuckState.alive

func _ready() -> void:
	var dir = [Vector2.LEFT, Vector2.RIGHT].pick_random()
	if dir == Vector2.RIGHT:
		sprite.flip_h = true
	direction = dir #更新方向
	if not audio_player: return
	audio_player.play() #播放音频
	audio_player.finished.connect(func(): audio_player.queue_free())

func _physics_process(delta: float) -> void:
	var limit_rect = Rect2(-300, -300, 1624, 1368)
	if not limit_rect.has_point(position):
		queue_free()
		print('鸭子: 飞出范围，从游戏中删除')
		return
	if duck_state == Enums.DuckState.alive:
		velocity.y = -gravity
		velocity.x = speed * (-1 if direction == Vector2.LEFT else 1)
	elif duck_state == Enums.DuckState.dead:
		velocity.x = 0.0
		velocity.y = 120.0
	else: 
		velocity = Vector2.ZERO
	move_and_collide(velocity * delta) #移动并处理

## 被击中
func hurt():
	collision_shape.disabled = true
	duck_state = Enums.DuckState.hit
	sprite.play("hit")
	sprite.animation_finished.connect(dead)

## 鸭子被打死
func dead():
	duck_state = Enums.DuckState.dead
	sprite.play('dead')
	sprite.animation_finished.disconnect(dead)

## 获取碰撞矩形
func get_collision_rect()->Rect2:
	var shape = collision_shape.shape as RectangleShape2D
	return Rect2(global_position, shape.size)
