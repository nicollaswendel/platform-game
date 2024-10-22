extends Area2D

func _on_area_entered(area):
	
	if area.name == "InteractionArea":
		await get_tree().create_timer(1).timeout
		get_tree().reload_current_scene()
		Global.life -= 1
		Global.score = 0
	
	pass
