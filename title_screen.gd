extends Node2D


# Dans TitleScreen.gd
func _process(delta):
	
	$station.position.y += sin(Time.get_ticks_usec() * 0.000001) * 0.2  # Mouvement léger


func _ready():
	$playButton.pressed.connect(_on_play_button_pressed)


func _on_play_button_pressed() -> void:
	$playButton.hide()
	$AnimationPlayer.play("distorsion")  # Lance l'animation de la faille
	$AnimationPlayer2.play("fondu")  # Lance l'animation de la faille
	await $AnimationPlayer.animation_finished
	await $AnimationPlayer2.animation_finished
	get_tree().change_scene_to_file("res://level_01.tscn")  # Passe à la cinématique
