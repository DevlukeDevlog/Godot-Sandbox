# Sound & Music Managers

A lightweight, efficient audio management system for Godot 4.7 featuring a **SoundManager** for 2D and UI sound effects and a **MusicManager** for background tracks.

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

## SoundManager

### Inspector Settings
* **`num_players`** (`int`, default `8`): Number of pre-allocated `AudioStreamPlayer` nodes in the pool.
* **`bus_name`** (`String`, default `"Audio"`): Target audio bus.
* **`sound_cooldown_ms`** (`int`, default `50`): Minimum delay in milliseconds between playback requests for the exact same audio stream to prevent audio stacking.

### API Reference

#### `Play_Sound(stream, volume_db, randomise_pitch, bypass_cooldown, custom_pitch) -> AudioStreamPlayer`
Plays a non-positional sound effect (UI, background SFX) using the pooled audio players.
* **`stream`** (`AudioStream`): The audio resource to play.
* **`volume_db`** (`float`, default `0.0`): Volume adjustment in decibels.
* **`randomise_pitch`** (`bool`, default `false`): Applies minor random pitch variation (`0.9` to `1.0`) to avoid audio fatigue.
* **`bypass_cooldown`** (`bool`, default `false`): Ignores rate-limiting cooldown checks.
* **`custom_pitch`** (`float`, default `1.0`): Baseline pitch multiplier.

#### `Play_Sound_2D(stream, position, volume_db, randomise_pitch, bypass_cooldown, custom_pitch) -> AudioStreamPlayer2D`
Instantiates a 2D spatial sound emitter in world space that automatically frees itself upon completion (`queue_free`).
* **`stream`** (`AudioStream`): The audio resource to play.
* **`position`** (`Vector2`): World space coordinates where the sound originates.
* **`volume_db`** (`float`, default `0.0`): Volume adjustment in decibels.
* **`randomise_pitch`** (`bool`, default `false`): Applies minor random pitch variation (`0.9` to `1.0`).
* **`bypass_cooldown`** (`bool`, default `false`): Ignores rate-limiting cooldown checks.
* **`custom_pitch`** (`float`, default `1.0`): Baseline pitch multiplier.

### Code Examples

```gdscript
# Play a standard UI click sound
SoundManager.Play_Sound(preload("res://Assets/Audio/click.wav"))

# Play a footstep with volume adjustment and pitch randomization
SoundManager.Play_Sound(
	preload("res://Assets/Audio/footstep.wav"), 
	volume_db = -2.0, 
	randomise_pitch = true
)

# Play a 2D positional sound at an enemy's position
SoundManager.Play_Sound_2D(
	preload("res://Assets/Audio/explosion.wav"), 
	global_position, 
	volume_db = 1.5, 
	randomise_pitch = true
)
```

## MusicManager
### Inspector Settings
* **`bus_name`** (`String`, default `"Music"`): Target audio bus.

### API Reference

#### `Play_Music(stream, volume_db, fade_duration)`
Transitions seamlessly to a new track using a Sine tween. If the active track is already playing, updates its volume smoothly instead of restarting playback. Passing `null` initiates a fade-out.
* **`stream`** (`AudioStream`): The background track to play (or `null` to stop).
* **`volume_db`** (`float`, default `0.0`): Target volume in decibels.
* **`fade_duration`** (`float`, default `0.5`): Duration of the crossfade transition in seconds.

#### `Stop_Music(fade_duration)`
Fades out the active music track and stops playback.
* **`fade_duration`** (`float`, default `1.5`): Fade-out duration in seconds.

### Code Examples

```gdscript
# Play a level theme with a 1-second crossfade
MusicManager.Play_Music(
	preload("res://Assets/Audio/level_theme.mp3"), 
	volume_db = -4.0, 
	fade_duration = 1.0
)

# Stop the current music with a slow 2-second fade-out
MusicManager.Stop_Music(2.0)
```
