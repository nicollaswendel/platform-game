extends CanvasLayer

func _process(delta):
	
	$Life/LifeText.text = str(Global.life)
	
	$Score/ScoreText.text = str(Global.score)
	
	pass
