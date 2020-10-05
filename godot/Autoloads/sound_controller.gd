extends Node

const MUSIC_LAYERS: int = 3
const EFFECT_LAYERS: int = 20
var _effect: Array = []
var _music: Array = []
onready var _tween: Tween = null

# Settings that should be put into an Options script
const DEFAULT_MUSIC_VOLUME: int = -12
const DEFAULT_EFFECT_VOLUME: int = -12


func _ready() -> void:
	_tween = Tween.new()
	add_child(_tween)
	
	for i in range(MUSIC_LAYERS):
		_music.append(AudioStreamPlayer.new())
		_music[i].bus = str("BGM",i)
		_music[i].volume_db = DEFAULT_MUSIC_VOLUME
		_music[i].connect("finished", self, "sig_music_finished", [i])
		add_child(_music[i])
	
	for i in range(EFFECT_LAYERS):
		_effect.append(AudioStreamPlayer.new())
		_effect[i].volume_db= DEFAULT_EFFECT_VOLUME
		_effect[i].bus = str("SFX",i)
		_effect[i].connect("finished", self, "sig_effect_finished", [i])
		add_child(_effect[i])

func pub_get_audio_effect_player(channel: int) -> AudioStreamPlayer:
	return _effect[channel]

func pub_play_music(path:String, channel: int = 0, \
	volume_db : int = DEFAULT_MUSIC_VOLUME) -> void:
	
	var stream = load(path)
	if (stream == null):
		print("Could not load ", path)
	_music[channel].volume_db = volume_db
	_music[channel].stop()
	_music[channel].stream = stream
	_music[channel].play()

func pub_crossfade_music_channels(channel_from : int, channel_to : int):
	var from = _music[channel_from]
	var to = _music[channel_to]
	
	_tween.stop_all()
	_tween.interpolate_property(from, "volume_db", null, -100, 3, Tween.TRANS_LINEAR)
	_tween.interpolate_property(to, "volume_db", null, DEFAULT_MUSIC_VOLUME, 0.5, Tween.TRANS_LINEAR)
	_tween.start()

func pub_set_music_volume_db(channel: int, volume_db: int):
	_music[channel].volume_db = volume_db

func pub_set_effect_volume_db(channel: int, volume_db: int):
	_effect[channel].volume_db = volume_db

func pub_set_music_pitch_scale(channel: int, pitch_scale: float):
	_music[channel].pitch_scale = pitch_scale

func pub_set_effect_pitch_scale(channel: int, pitch_scale: float):
	_music[channel].pitch_scale = pitch_scale

func pub_play_effect(path:String, channel: int = 0, \
	volume_db : int = DEFAULT_EFFECT_VOLUME) -> void:
	
	var stream = load(path)
	if (stream == null):
		print("Could not load ", path)
	_effect[channel].volume_db = volume_db
	_effect[channel].stop()
	_effect[channel].stream = stream
	_effect[channel].play()


func pub_stop_music()-> void:
	for i in range(MUSIC_LAYERS):
		_music[i].stop()


func pub_stop_effect(channel: int) -> void:
	_effect[channel].stop()


func pub_stop_effects()-> void:
	for i in range(0,EFFECT_LAYERS):
		_effect[i].stop()


func pub_stop_all() -> void:
	pub_stop_music()
	pub_stop_effects()


func sig_music_finished(channel: int) -> void:
	pass


func sig_effect_finished(channel: int) -> void:
	_effect[channel].stop()
	pass
