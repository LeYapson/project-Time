extends CharacterBody2D

var speed = 200
@onready var anim = $Sprite2D
var is_moving = false
func _ready():
	$Timer.start(3.0)  # Attend 3 secondes avant de bouger
	anim.play("Idle") # Animation d'attente

func _on_timer_timeout():
	is_moving = true
	anim.play("walk")  # Animation de course

func _physics_process(delta):
	if is_moving:
		velocity.x = speed
		move_and_slide()
