extends StaticBody2D

var life = 3

func Hit():
	
	$Sprite2D.play("Hit")
	life -= 1
	
	if life <= 0:
		Break()
		
	pass

func Break():
	
	$CPUParticles2D.restart()
	$Sprite2D.hide()
	$CollisionShape2D.queue_free()
	
	await get_tree().create_timer(1).timeout
	
	queue_free()
	
	pass
