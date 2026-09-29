extends Node

@export var bus_name: String = "Music"

var _player_a: AudioStreamPlayer
var _player_b: AudioStreamPlayer
var _active_player: AudioStreamPlayer

var _fade_tween: Tween

func _ready() -> void:
	_player_a = AudioStreamPlayer.new()
	_player_b = AudioStreamPlayer.new()
	_player_a.process_mode = Node.PROCESS_MODE_ALWAYS
	_player_b.process_mode = Node.PROCESS_MODE_ALWAYS
	
	add_child(_player_a)
	add_child(_player_b)
	
	_player_a.bus = bus_name
	_player_b.bus = bus_name
	
	_active_player = _player_a

func Play_Music(stream: AudioStream, volume_db: float = 0.0, fade_duration: float = 0.5) -> void:
	if not stream:
		Stop_Music(fade_duration)
		return
	
	if _active_player.stream == stream and _active_player.playing:
		if _fade_tween and _fade_tween.is_valid():
			_fade_tween.kill()
		_active_player.volume_db = volume_db
		return
	
	var inactive_player = _player_b if _active_player == _player_a else _player_a
	
	inactive_player.stream = stream
	inactive_player.volume_db = -80.0 
	inactive_player.play()
	
	if _fade_tween and _fade_tween.is_valid():
		_fade_tween.kill()
		
	_fade_tween = create_tween().set_parallel(true)
	_fade_tween.set_trans(Tween.TRANS_SINE)
	_fade_tween.set_ease(Tween.EASE_IN_OUT)
	
	if _active_player.playing:
		_fade_tween.tween_property(_active_player, "volume_db", -80.0, fade_duration)
		_fade_tween.chain().tween_callback(_active_player.stop)
	
	_fade_tween.tween_property(inactive_player, "volume_db", volume_db, fade_duration)
	
	_active_player = inactive_player

func Stop_Music(fade_duration: float = 1.5) -> void:
	if not _active_player.playing:
		return
		
	if _fade_tween and _fade_tween.is_valid():
		_fade_tween.kill()
		
	_fade_tween = create_tween()
	_fade_tween.set_trans(Tween.TRANS_SINE)
	_fade_tween.set_ease(Tween.EASE_IN_OUT)
	
	_fade_tween.tween_property(_active_player, "volume_db", -80.0, fade_duration)
	_fade_tween.tween_callback(_active_player.stop)
