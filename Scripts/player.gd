extends CharacterBody2D

# @export - adiciona a variável às características do character no editor.
@export var speed = 200.0
@export var jump_velocity = -350.0

var dir
var gravity = 980

@onready var animator = $AnimatedSprite2D
@onready var run_particle = $CPUParticles2D
@onready var jump_particle = $CPUParticles2D2

var jumps = 1

var knock_back = false

func _ready():
	pass

func _physics_process(delta):
	
	Move(delta)
	Animations()
	
	pass

func Move(delta):
	
	dir = Input.get_axis("Left", "Right")
	
	if dir and knock_back == false:
		velocity.x = dir * speed
	elif dir == 0 and knock_back == false:
		velocity.x = 0
	
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		jump_particle.restart()
	
	if Input.is_action_just_pressed("Jump") and jumps > 0:
		jumps -= 1
		velocity.y = jump_velocity
		jump_particle.restart()
		knock_back = false
		animator.play("DoubleJump")
	
	if is_on_floor():
		jumps = 1
		
	move_and_slide()
	
	pass

func KnockBack(side):
	
	if side == "Right":
		knock_back = true
		velocity.y = jump_velocity
		velocity.x = 1 * 120
	elif side == "Left":
		knock_back = true
		velocity.y = jump_velocity
		velocity.x = -1 * 120
	
	pass

func Animations():
	
	if velocity.x != 0 and is_on_floor():
		animator.play("Run")
		run_particle.emitting = true
	elif velocity.x == 0 and is_on_floor():
		animator.play("Idle")
		run_particle.emitting = false
		
	if !is_on_floor() and jumps >= 1 and knock_back == false:
		animator.play("Jump")
		run_particle.emitting = false
		
	if dir > 0:
		animator.flip_h = false
	elif dir < 0:
		animator.flip_h = true
	
	pass

func _on_interaction_area_body_entered(body):
	
	if body.is_in_group("Box") and body.global_position.y > global_position.y:
		body.Hit()
		velocity.y = jump_velocity * 1.5
	elif body.is_in_group("Box") and body.global_position.y < global_position.y:
		body.Hit()
		velocity.y = -jump_velocity
	
	if body.is_in_group("TileMap"):
		jump_particle.restart()
		knock_back = false
	
	if body.is_in_group("Enemy"):
		body.TakeDamage()
		velocity.y = jump_velocity * 1.5
	
	pass
