class_name Player extends CharacterBody2D

var move_speed: float = 100.0
var last_direction: String = "down"

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: PlayerStateMachine = $PlayerStateMachine

func _ready() -> void:
	# Oyun başladığında State Machine'i bu karakter (self) ile başlatıyoruz
	state_machine.Initialize(self)
