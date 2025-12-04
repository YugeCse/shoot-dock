## 主场景
class_name MainScene extends Control

@export
var player_gun: Sprite2D

@export
var audio_player: AudioStreamPlayer

@export
var gun_shoot_audio: AudioStream

@export
var gun_shoot_duck_audio: AudioStream

@export
var gun_shoot_effect: PackedScene

@export
var player_gun_speed: float = 300.0

func _ready() -> void:
	set_process_input(true)

func _physics_process(delta: float) -> void:
	var move_dir = Vector2.ZERO
	if Input.is_action_pressed('ui_left'):
		move_dir.x = -1.0
	elif Input.is_action_pressed('ui_right'):
		move_dir.x = 1.0
	elif Input.is_action_pressed('ui_up'):
		move_dir.y = -1.0
	elif Input.is_action_pressed('ui_down'):
		move_dir.y = 1.0
	if Input.is_action_just_pressed('ui_shoot'):
		_play_gun_shoot_audio(false)
		var duck = _find_shoot_duck()
		if duck:
			duck.hurt() #鸭子被击中
			_play_gun_shoot_audio(true) #播放放枪声音
			_show_gun_shoot_effect(player_gun.global_position) #显示放枪特效
	player_gun.position += move_dir * delta * player_gun_speed

## 查找被枪杀的鸭子
func _find_shoot_duck() -> BaseDuckComponent:
	var shoot_radius = Vector2(10.0, 10.0)
	var shoot_position = \
		player_gun.global_position + player_gun.get_rect().get_center()
	var shoot_rect = \
		Rect2(shoot_position - shoot_radius/2.0, shoot_radius)
	var duck_nodes = get_tree().get_nodes_in_group('Duck')
	if len(duck_nodes) > 0:
		queue_redraw()
		for node in duck_nodes:
			if node is BaseDuckComponent:
				var rect = node.get_collision_rect()
				if rect.intersects(shoot_rect):
					return node
	return null #没有任何鸭子被击中

## 播放放枪的声音[br]
## 参数： {hit} - 是否被击中
func _play_gun_shoot_audio(hit: bool):
	if not hit:
		print('提示：没有鸭子未被击中')
		audio_player.stream = gun_shoot_audio
	else:
		print('提示：鸭子被击中')
		audio_player.stream = gun_shoot_duck_audio
	audio_player.play() #播放音频

## 显示打枪的效果[br]
## 参数：{location}-全局坐标
func _show_gun_shoot_effect(location: Vector2):
	var effect = gun_shoot_effect.instantiate() as GunShoot
	effect.global_position = location
	$Camera2D.add_child(effect)

func _on_button_sound_play_button_down() -> void:
	$BackgroundMusicPlayer.stream_paused = true
	$Camera2D/UIControl/ButtonSoundPlay.visible = false
	$Camera2D/UIControl/ButtonSoundPlay2.visible = true

func _on_button_sound_play_2_button_down() -> void:
	$BackgroundMusicPlayer.stream_paused = false
	$Camera2D/UIControl/ButtonSoundPlay.visible = true
	$Camera2D/UIControl/ButtonSoundPlay2.visible = false

func _on_button_win_close_button_down() -> void:
	get_tree().quit()
