extends CanvasLayer

@onready var fuel_bar = $FuelBar
@onready var fuel_label = $FuelBar/Label
var player = null

func _ready():
	# Trouver le joueur
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	if player:
		# Mettre à jour la barre de carburant
		var fuel_percent = (player.jetpack_fuel / player.jetpack_max_fuel) * 100
		fuel_bar.value = fuel_percent
		fuel_label.text = "Jetpack: %d%%" % int(fuel_percent)
		
		# Changer la couleur selon le niveau
		if fuel_percent > 50:
			fuel_bar.modulate = Color(0, 1, 0)  # Vert
		elif fuel_percent > 25:
			fuel_bar.modulate = Color(1, 1, 0)  # Jaune
		else:
			fuel_bar.modulate = Color(1, 0, 0)  # Rouge
