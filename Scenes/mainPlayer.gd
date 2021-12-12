extends KinematicBody2D

const UP_DIRECTION := Vector2.UP

const pet = preload("res://Pet.tscn")
const speed := 300.0
const gravity := 2250.0
const jump := 600.0
var alreadySpawned = false
var anim
var _velocity := Vector2.ZERO
onready var mainScene = get_node("..")

func _ready():
	print(mainScene)
	anim = get_node("AnimatedSprite")
	anim.play("Idle")

func _physics_process(delta: float) -> void:
	spawnPet()
	var _horizontal_direction = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	if Input.is_action_pressed("move_right"):
		anim.flip_h = false
		anim.play("Run")
	elif Input.is_action_pressed("move_left"):
		anim.play("Run")
		anim.flip_h = true
	else:
		anim.play("Idle")
	_velocity.x = _horizontal_direction * speed
	_velocity.y += gravity * delta
	
	#var is_falling := _velocity.y > 0.0 and not is_on_floor()
	var is_jumping := Input.is_action_just_pressed("jump") and is_on_floor()
	#var is_jump_cancelled := Input.is_action_just_pressed("jump") and is_falling
	
	if is_jumping:
		_velocity.y = -jump
		
	_velocity = move_and_slide(_velocity, UP_DIRECTION)


func spawnPet():
	if Input.is_action_just_pressed("spawn") and !alreadySpawned:
		alreadySpawned = true
		var petInst = pet.instance()
		mainScene.add_child(petInst)
	




