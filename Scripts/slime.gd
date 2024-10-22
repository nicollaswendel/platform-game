extends CharacterBody2D

@onready var animator = $AnimatedSprite2D

@export var speed = 20
@export var range = 1

var real_speed = 0
var dirX = -1
var life = 2

func _ready():
	
	real_speed = speed
	
	$Timer.wait_time = range
	
	pass

func _physics_process(delta):
	
	Move(delta)
	
	
	pass

func Move(delta):
	
	velocity.x = dirX * real_speed
	
	move_and_slide()
	
	pass

func ChangeSide():
	
	if dirX == 1:
		dirX = -1
		$AnimatedSprite2D.flip_h = false
	else:
		dirX = 1
		$AnimatedSprite2D.flip_h = true
	
	pass

func _on_timer_timeout():
	
	ChangeSide()
	
	pass

func TakeDamage():
	
	animator.play("Hit")
	real_speed = 0
	life -= 1
	await get_tree().create_timer(0.4).timeout
	animator.play("Idle")
	real_speed = speed
	
	if life <= 0:
		queue_free()
	
	pass


func _on_damage_area_body_entered(body):
	
	if body.name == "Player":
		if body.global_position.x >= global_position.x:
			body.KnockBack("Right")
			Global.LoseLife(1)
		else:
			body.KnockBack("Left")
			Global.LoseLife(1)
	pass
