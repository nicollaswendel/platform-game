extends Node2D

@export var next_level = ""

func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
		await get_tree().create_timer(0.2).timeout
		get_tree().change_scene_to_file(next_level)
	
	pass
