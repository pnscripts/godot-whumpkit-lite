@tool
extends "res://addons/whumpkit_lite/whumpkit_component.gd"
## Trauma-based camera shake for a [Camera2D].
##
## Add trauma on impacts with [method add_trauma]. The visible shake is
## [code]trauma ^ trauma_power[/code], so small hits barely move the camera and
## big ones throw it around. Trauma decays linearly. Offsets come from seeded
## [FastNoiseLite], so the same seed gives the same motion.
##
## The shake is applied as a change on top of whatever the camera already has:
## your own offset and rotation code keeps working.
##
## The roll only shows when the camera's [member Camera2D.ignore_rotation] is
## off. Godot turns it on for every new Camera2D, so the node warns in the
## editor and once at run time when [member max_roll_degrees] is above 0 and the
## camera would hide the roll. It never changes the camera setting itself:
## turning it off also makes the view follow any rotation of the camera's
## parents.

signal settled

## Camera to shake. Empty means the parent, if it is a Camera2D.
@export var camera: Camera2D:
	set(value):
		camera = value
		update_configuration_warnings()
## Current trauma, 0 to 1.
@export_range(0.0, 1.0) var trauma := 0.0
## Trauma lost per second.
@export var decay := 1.4
## Exponent applied to trauma. 2 or 3 feel natural.
@export_range(1.0, 4.0) var trauma_power := 2.0
## Largest offset in pixels at full trauma.
@export var max_offset := Vector2(28.0, 20.0)
## Largest roll in degrees at full trauma. The roll shows only when the
## camera's [member Camera2D.ignore_rotation] is off; set this to 0 for a shake
## without roll.
@export var max_roll_degrees := 3.5:
	set(value):
		max_roll_degrees = value
		update_configuration_warnings()
## Noise speed. Higher is more jittery.
@export var frequency := 22.0
## Noise seed. Same seed, same shake.
@export var noise_seed := 1:
	set(value):
		noise_seed = value
		_noise.seed = value

var _noise := FastNoiseLite.new()
var _time := 0.0
var _applied_offset := Vector2.ZERO
var _applied_roll := 0.0
var _roll_warned := false


func _init() -> void:
	_noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	_noise.frequency = 1.0
	_noise.seed = noise_seed


func _ready() -> void:
	super._ready()
	if camera == null and get_parent() is Camera2D:
		camera = get_parent()


## Explains why the roll would not show, or returns an empty string when it
## does (or when [member max_roll_degrees] is 0).
func get_roll_warning() -> String:
	var cam := _target_camera()
	if cam == null or is_zero_approx(max_roll_degrees) or not cam.ignore_rotation:
		return ""
	return ("Max Roll Degrees is %s, but the camera \"%s\" has Ignore Rotation on "
		+ "(the Camera2D default), so the roll never shows on screen. Turn off "
		+ "Ignore Rotation on that camera, or set Max Roll Degrees to 0.") % [max_roll_degrees, cam.name]


func _get_configuration_warnings() -> PackedStringArray:
	var out := PackedStringArray()
	var msg := get_roll_warning()
	if msg != "":
		out.append(msg)
	return out


func _notification(what: int) -> void:
	if what == NOTIFICATION_PARENTED or what == NOTIFICATION_UNPARENTED:
		update_configuration_warnings()


func _target_camera() -> Camera2D:
	if camera != null:
		return camera
	if get_parent() is Camera2D:
		return get_parent()
	return null


## Add trauma (clamped to 1).
func add_trauma(amount: float) -> void:
	trauma = clampf(trauma + amount, 0.0, 1.0)


## Visible shake amount, 0 to 1.
func get_shake() -> float:
	return pow(trauma, trauma_power)


## Offset and roll the shake would apply right now: [code][Vector2, float][/code].
func sample() -> Array:
	var s := get_shake()
	var t := _time * frequency
	var off := Vector2(max_offset.x * s * _noise.get_noise_2d(t, 0.0),
		max_offset.y * s * _noise.get_noise_2d(t, 1000.0))
	var roll := deg_to_rad(max_roll_degrees) * s * _noise.get_noise_2d(t, 2000.0)
	return [off, roll]


func step(delta: float) -> void:
	if camera == null:
		return
	var was_shaking := trauma > 0.0
	if was_shaking and not _roll_warned:
		_warn_if_roll_hidden()
	_time += delta
	var res := sample()
	camera.offset += res[0] - _applied_offset
	camera.rotation += res[1] - _applied_roll
	_applied_offset = res[0]
	_applied_roll = res[1]
	trauma = maxf(trauma - decay * delta, 0.0)
	if was_shaking and trauma == 0.0:
		_clear()
		settled.emit()


func _warn_if_roll_hidden() -> void:
	_roll_warned = true
	var msg := get_roll_warning()
	if msg != "":
		push_warning("WhumpkitLiteShake2D: " + msg)


## Remove the shake right away.
func stop() -> void:
	trauma = 0.0
	_clear()


func _clear() -> void:
	if camera:
		camera.offset -= _applied_offset
		camera.rotation -= _applied_roll
	_applied_offset = Vector2.ZERO
	_applied_roll = 0.0


func _exit_tree() -> void:
	_clear()
