extends Area2D

@export var speed := 300.0  # Vitesse de déplacement
var direction := -1  # 1 = droite, -1 = gauche

func _ready():
	$Timer.timeout.connect(_on_Timer_timeout)

func _on_Timer_timeout():
	# Active/désactive le laser pour un effet de clignotement
	$CollisionShape2D.disabled = not $CollisionShape2D.disabled
	$Sprite2D.visible = not $Sprite2D.visible

func _process(delta):
	# Déplace le laser selon la direction
	position.x += direction * speed * delta

	# Si le laser sort de l'écran, le réinitialiser
	if position.x > 1000:  # Ajuste selon la taille de ton niveau
		position.x = -200
	elif position.x < -200:
		position.x = 1000

func invert_direction():
	direction *= -1  # Inverse la direction


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.die()  # Tue le joueur s'il touche le laser.
