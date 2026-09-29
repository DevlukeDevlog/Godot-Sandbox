extends Node

@export var num_players: int = 8
@export var bus_name: String = "Audio"
@export var sound_cooldown_ms: int = 50

var available: Array[AudioStreamPlayer] = []
var _sound_timers: Dictionary = {}

func _ready() -> void:
	for i in num_players:
		var player = AudioStreamPlayer.new()
		add_child(player)
		available.append(player)
		player.bus = bus_name

func Play_Sound(stream: AudioStream, volume_db: float = 0.0, randomise_pitch: bool = false, bypass_cooldown: bool = false, custom_pitch: float = 1.0) -> AudioStreamPlayer:
	if not stream:
		return null
	
	if not bypass_cooldown and _is_sound_stacking(stream):
		return null
		
	var player = _get_available_player()
	_prepare_player(player, stream, volume_db, randomise_pitch, custom_pitch)
	player.play()
	return player

func Play_Sound_2D(stream: AudioStream, position: Vector2, volume_db: float = 0.0, randomise_pitch: bool = false, bypass_cooldown: bool = false, custom_pitch: float = 1.0) -> AudioStreamPlayer2D:
	if not stream:
		return null
		
	if not bypass_cooldown and _is_sound_stacking(stream):
		return null
	
	var player = AudioStreamPlayer2D.new()
	player.bus = bus_name
	player.global_position = position
	player.max_distance = 1000.0 
	
	_prepare_player(player, stream, volume_db, randomise_pitch, custom_pitch)
	
	player.finished.connect(func(): player.queue_free())
	add_child(player)
	player.play()
	return player

func _prepare_player(player: Variant, stream: AudioStream, volume_db: float, randomise_pitch: bool, custom_pitch: float) -> void:
	player.stream = stream
	player.volume_db = volume_db
	
	if randomise_pitch:
		player.pitch_scale = custom_pitch * randf_range(0.9, 1.0)
	else:
		player.pitch_scale = custom_pitch

func _is_sound_stacking(stream: AudioStream) -> bool:
	var current_time = Time.get_ticks_msec()
	
	if _sound_timers.has(stream):
		var time_passed = current_time - _sound_timers[stream]
		if time_passed < sound_cooldown_ms:
			return true
			
	_sound_timers[stream] = current_time
	return false

func _get_available_player() -> AudioStreamPlayer:
	for player in available:
		if not player.playing:
			return player
			
	return available[0]
