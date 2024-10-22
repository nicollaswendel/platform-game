extends Node

var life = 3
var score = 0

func GameOver():
	await get_tree().create_timer(0.3).timeout
	score = 0
	life = 3
	get_tree().reload_current_scene()
	
	pass

func LoseLife(valor : int):
	life -= valor
	
	if life <= 0:
		GameOver()
	pass
