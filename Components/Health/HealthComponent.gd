extends Node2D
class_name HealthComponent

@export var maxHealth = 100

var health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	reset_health()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_health():
	health = maxHealth

func remove_health(amount:int):
	health -= amount
