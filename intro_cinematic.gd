extends Node2D

@onready var anim = $AnimationPlayer

func _ready():
	anim.play("control_room")



func _on_next_part_body_entered(body: Node2D) -> void:
	if body.name == "player":
		get_tree().change_scene_to_file("res://intro_next.tscn")  # Passe à la cinématique
