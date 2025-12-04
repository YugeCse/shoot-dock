extends Node2D


func _on_button_play_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/MainScene.tscn")

func _on_button_sound_play_button_down() -> void:
	$BackgroundMusicPlayer.stream_paused = true
	$Camera2D/ButtonSoundPlay.visible = false
	$Camera2D/ButtonSoundPlay2.visible = true

func _on_button_sound_play_2_button_down() -> void:
	$BackgroundMusicPlayer.stream_paused = false
	$Camera2D/ButtonSoundPlay.visible = true
	$Camera2D/ButtonSoundPlay2.visible = false

func _on_button_win_close_button_down() -> void:
	get_tree().quit()
