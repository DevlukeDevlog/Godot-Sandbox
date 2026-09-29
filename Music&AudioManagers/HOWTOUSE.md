# Sound & Music Managers

## Setup & Installation

### 1. File Location
Place these scripts in your project directory (e.g., `res://Audio/SoundManager.gd` and `res://Audio/MusicManager.gd`).

### 2. Audio Buses
1. Open the **Audio** tab at the bottom of the Godot editor.
2. Create two new buses and name them:
   - `Audio` (dedicated to sound effects)
   - `Music` (dedicated to background tracks)
3. Route both buses into the **Master** bus for central volume control.

### 3. Autoload Globals
1. Navigate to **Project -> Project Settings -> Autoload**.
2. Add `SoundManager.gd` with the Node Name `SoundManager`.
3. Add `MusicManager.gd` with the Node Name `MusicManager`.

---

## SoundManager

### API Reference

`Play_Sound(stream, volume_db, randomise_pitch, bypass_cooldown, custom_pitch)`

* **`stream`** (`AudioStream`): The audio resource to play.
* **`volume_db`** (`float`): Volume adjustment in decibels (default `0.0`).
* **`randomise_pitch`** (`bool`): Applies a minor random pitch variation to prevent audio fatigue (default `false`).
* **`bypass_cooldown`** (`bool`): Ignores the rate-limiting cooldown timer for rapid-fire inputs (default `false`).
* **`custom_pitch`** (`float`): Baseline pitch multiplier (default `1.0`).

### Code Examples

```gdscript
# Play a standard interface click sound
SoundManager.Play_Sound(preload("res://Assets/Audio/click.wav"))

# Play a footstep with volume and pitch randomization
SoundManager.Play_Sound(
	preload("res://Assets/Audio/footstep.wav"), 
	volume_db = -2.0, 
	randomise_pitch = true
)
```

---

## MusicManager

### API Reference

`Play_Music(stream, volume_db, fade_duration)`

* **`stream`** (`AudioStream`): The track to play. Passing `null` initiates a fade-out.
* **`volume_db`** (`float`): Target volume in decibels (default `0.0`).
* **`fade_duration`** (`float`): Transition duration in seconds for the crossfade (default `0.5`).

`Stop_Music(fade_duration)`

* **`fade_duration`** (`float`): Fade-out duration in seconds (default `1.5`).

### Code Examples

```gdscript
# Play a level theme with a 1-second crossfade
MusicManager.Play_Music(
	preload("res://Assets/Audio/level_theme.mp3"), 
	volume_db = -4.0, 
	fade_duration = 1.0
)

# Stop the current music with a 2-second fade-out
MusicManager.Stop_Music(2.0)
```