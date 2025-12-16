extends Area2D

@export var recharge_speed := 50.0  # Vitesse de recharge rapide
var is_recharging := false
var player_in_area = null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Player":
		player_in_area = body
		is_recharging = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_area = null
		is_recharging = false

func _physics_process(delta):
	if is_recharging and player_in_area:
		# Recharge rapide du jetpack
		if player_in_area.jetpack_fuel < player_in_area.jetpack_max_fuel:
			player_in_area.jetpack_fuel = min(
				player_in_area.jetpack_fuel + recharge_speed * delta,
				player_in_area.jetpack_max_fuel
			)
			player_in_area.can_use_jetpack = true
			# Effet visuel optionnel
			modulate = Color(0, 1, 1)  # Cyan quand recharge
		else:
			modulate = Color(1, 1, 1)  # Blanc quand plein
