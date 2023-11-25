extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D

const lines: Array[String] = [
	"Hey there!"
]


func _ready():
	sprite.play("idle")
	print(Callable(self, "_on_interact"))
	interaction_area.interact = Callable(self, "_on_interact")
	print(InteractionArea)
	
func _on_interact():
	sprite.play("talk")
	print("hello")
