extends CanvasLayer

const TEST_AUDIO = preload("uid://c5hmu67ve668l")
const TEST_MUSIC = preload("uid://cmefwj6u6dhny")

func _on_play_music_button_pressed() -> void:
	MusicManager.Play_Music(TEST_MUSIC, -6.0)

func _on_stop_music_button_pressed() -> void:
	MusicManager.Stop_Music()

func _on_play_audio_button_pressed() -> void:
	AudioManager.Play_Sound(TEST_AUDIO, -3.0, true)
