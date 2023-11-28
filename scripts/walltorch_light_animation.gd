extends Node2D

@onready var ap = $candle_light/candle_player

func _ready():
	ap.play("candle_light")
