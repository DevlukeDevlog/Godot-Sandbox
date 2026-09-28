# Godot Sandbox

A personal collection of reusable components and tools built in Godot 4.7 to speed up game development and prototyping.

## Contents

- **Beatmap Generator**
  - **Description:** An editor tool (`@tool`) that automatically generates rhythm game beatmaps in JSON format from an `AudioStreamMP3` file, supporting custom BPM, lane or free-roam spawning, difficulty curves, and intro/outro delays.
  - **Location:** `BeatmapGenerator/`

  <details>
  <summary><b>How to Use & Parameters</b></summary>

  To use the generator, attach the `BeatmapGenerator.gd` script to a Node in your scene while working in the Godot editor. 

  ### How to Generate
  Assign your audio file, configure your settings in the Inspector, and toggle the **Generate Beatmap** boolean parameter to `true`. The script will automatically calculate the note positions, build the JSON data structure, and save the file to your specified output folder.

  ### Available Parameters
  - **Music:** The `AudioStreamMP3` file used to calculate song length and determine note timing.
  - **BeatsPerMinute:** The tempo of the track used to calculate the base interval between notes.
  - **SongOffset:** Starting time offset for audio synchronization.
  - **IntroDelay:** Buffer time at the beginning of the song before notes begin spawning.
  - **OutroDelay:** Buffer time at the end of the song where note generation stops to create an outro pause.
  - **OutputFolder:** The target directory where the generated JSON beatmap will be saved (`res://BeatmapGenerator/Beatmaps/`).
  - **SpawnMode:** 
    - `LANES_8`: Spawns notes across 8 distinct directional lanes.
    - `FREE_ROAM`: Spawns notes at completely randomized angles using `TAU`.
  - **DifficultyCurve:** An optional `Curve` resource that scales note frequency dynamically based on song progress.
  - **Generate Beatmap:** A toggle switch in the Inspector that triggers the generation process when set to `true` inside the editor.

  </details>
