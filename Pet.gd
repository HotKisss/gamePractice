extends Sprite


onready var anim = get_node("AnimationPlayer")
onready var player = get_node("../mainPlayer")
onready var timer = get_node("Timer")
var points = [25, 30, 40, 26, 34]
var canMove = true
var randNum
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	anim.play("Fly")
	timer.start(3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	move()
	if timer.is_stopped():
		canMove = false
		position.x = move_toward(position.x, player.position.x + randNum, 1)

func move():
	if canMove:
		var posX = player.position.x
		var posY = player.position.y - 40
		position = Vector2(posX, posY)



func _on_Timer_timeout():
	randNum = rand_range(-20, 40)
	timer.stop()
