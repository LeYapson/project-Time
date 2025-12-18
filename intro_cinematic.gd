extends Node2D

@onready var anim = $AnimationPlayer
@onready var player = $player  # Assurez-vous que le joueur est dans la scène
@onready var player_anim = $player/Sprite2D  # Assurez-vous que le joueur est dans la scène

var move_speed := 200.0

func _ready():
	anim.play("control_room")
	player_anim.play("Idle")

func _process(delta):
	# Détecte n'importe quelle touche pressée UNE FOIS pour lancer la cinématique
	if  Input.is_anything_pressed():
		start_cinematic()

		# Vérifie si le joueur est sorti de l'écran
		if player.position.x > get_viewport_rect().size.x + 100:
			end_cinematic()

func start_cinematic():
	player_anim.play("walk")
	player.move_and_slide()

func end_cinematic():
	# Stoppe le joueur et passe au niveau suivant
	if player:
		player.linear_velocity = Vector2.ZERO
		player.freeze = true
	get_tree().change_scene_to_file("res://level_01.tscn")
