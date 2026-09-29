# Beatmap Generator
## How to Use

1. Attach the `beatmap_generator.gd` script to a Node in your scene (or open `beatmap_generator.tscn`) while working inside the Godot editor.
2. Select the Node in the **Scene Tree** to view its properties in the **Inspector**.
3. Assign your target `AudioStreamMP3` song file to the **Music** parameter.
4. Configure your desired BPM, delays, spawn modes, and difficulty settings.
5. Toggle the **Generate Beatmap** checkbox in the Inspector to `true`.
6. The generated JSON file will automatically be saved to your configured **Output Folder**.

## Inspector Parameters

* **`Music`** (`AudioStreamMP3`): The audio file used to calculate total song length and determine precise note timing.
* **`BeatsPerMinute`** (`float`): The tempo of the track, used to set the base interval between generated notes.
* **`SongOffset`** (`float`): Time offset (in seconds) to compensate for leading silence or synchronization.
* **`IntroDelay`** (`float`): Buffer duration (in seconds) at the start of the track before notes start appearing.
* **`OutroDelay`** (`float`): Buffer duration (in seconds) before the end of the track where note generation stops.
* **`OutputFolder`** (`String`): Output directory where the JSON beatmap is saved (e.g., `res://BeatmapGenerator/Beatmaps/`).
* **`SpawnMode`** (`Enum`):
  * `LANES_8`: Spawns notes distributed across 8 directional lanes.
  * `FREE_ROAM`: Spawns notes at randomized angles using `TAU`.
* **`DifficultyCurve`** (`Curve`): Optional curve resource to dynamically alter note density over the duration of the track.
* **`Generate Beatmap`** (`bool`): In-editor trigger switch. Toggling this to `true` instantly generates the JSON beatmap.
