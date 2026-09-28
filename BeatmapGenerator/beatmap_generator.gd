@tool
class_name BeatmapGenerator
extends Node

enum SpawnMode {
	LANES_8,     
	FREE_ROAM  
}

@export var Music: AudioStreamMP3 = null
@export var BeatsPerMinute: float = 120.0
@export var SongOffset: float = 0.0
@export var IntroDelay: float = 2.0
@export var OutroDelay: float = 2.0
@export var OutputFolder: String = "res://BeatmapGenerator/Beatmaps/"

@export_group("Generation Settings")
@export var spawn_mode: SpawnMode = SpawnMode.LANES_8
@export var difficulty_curve: Curve = null 

@export var generate_beatmap: bool = false:
	set(value):
		if value and Engine.is_editor_hint():
			_generate_beatmap()
			generate_beatmap = false

func _generate_beatmap() -> void:
	if not Music:
		push_warning("No AudioStreamMP3 assigned to BeatmapGenerator!")
		return
		
	var song_length := Music.get_length()
	if song_length <= 0.0:
		push_warning("Invalid or zero-length audio stream!")
		return
		
	var beat_map_data: Array = []
	var base_beat_interval := 60.0 / BeatsPerMinute
	var current_time := maxf(SongOffset, IntroDelay)
	var end_time := song_length - OutroDelay
	
	while current_time <= end_time:
		var progress := clampf(current_time / song_length, 0.0, 1.0)
		var difficulty_multiplier := 1.0
		if difficulty_curve:
			difficulty_multiplier = maxf(difficulty_curve.sample(progress), 0.1)
		
		var note_entry := _create_note_entry(current_time)
		beat_map_data.append(note_entry)
		
		var dynamic_interval = base_beat_interval / difficulty_multiplier
		current_time += dynamic_interval
		
	var final_output := {
		"total_beats": beat_map_data.size(),
		"bpm": BeatsPerMinute,
		"beatmap": beat_map_data
	}
	
	_save_to_json(final_output)

func _create_note_entry(time: float) -> Dictionary:
	var entry := {
		"time": snappedf(time, 0.001)
	}
	
	match spawn_mode:
		SpawnMode.LANES_8:
			entry["lane"] = randi() % 8
		SpawnMode.FREE_ROAM:
			entry["angle"] = snappedf(randf() * TAU, 0.001)
			
	return entry

func _save_to_json(data: Dictionary) -> void:
	var err := DirAccess.make_dir_recursive_absolute(OutputFolder)
	if err != OK and err != ERR_ALREADY_EXISTS:
		push_error("Failed to create folder: ", OutputFolder, " Error code: ", err)
		return
		
	var file_name = "generated_beatmap.json"
	if Music and Music.resource_path and not Music.resource_path.is_empty():
		file_name = Music.resource_path.get_file().get_basename() + "_beatmap.json"
		
	var full_path = OutputFolder.path_join(file_name)
	
	var file := FileAccess.open(full_path, FileAccess.WRITE)
	if file:
		var json_string = JSON.stringify(data, "\t")
		file.store_string(json_string)
		file.close()
		print("Beatmap successfully saved to: ", full_path)
		
		if Engine.is_editor_hint():
			EditorInterface.get_resource_filesystem().scan()
	else:
		push_error("Failed to save beatmap file at path: ", full_path, " Error: ", FileAccess.get_open_error())
