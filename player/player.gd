extends CharacterBody2D

const GRAVITY: int = 600
const MAX_SPEED: int = 300
var jumpVelocity: int = -260

@onready var pipeSpawner = get_node("/root/Main/PipeSpawner")
@onready var dieSound = $Die
@onready var jumpSound = $Jump
@onready var main = get_node("/root/Main")

func _ready():
	velocity = Vector2.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$AnimationPlayer.play("Jump")
	
	# Update Jump Velocity when pipe's speed is 300
	if (pipeSpawner.pipeSpeed >= 300 && jumpVelocity == -260):
		jumpVelocity = -300

	# Add Gravity when player starts the game
	if (main.isStarted):
		velocity.y += GRAVITY * delta
		velocity.y = min(velocity.y, MAX_SPEED)
	
	# Handle jump nput
	if Input.is_action_just_pressed("jump"):
		jumpSound.play()
		if (!main.isStarted):
			main.isStarted = true
		velocity.y = jumpVelocity
		rotation = deg_to_rad(-20)
		
	updateRotation()
	move_and_slide()

func updateRotation():
	if (velocity.y > 0 && rad_to_deg(rotation) < 0):
		rotation = deg_to_rad(20)
	elif (velocity.y < 0 && rad_to_deg(rotation) > 0):
		rotation = deg_to_rad(-20)


func _on_bottom_death_area_body_entered(_body):
	dieSound.play()
	queue_free()
	main.isDead = true
	$"../PipeSpawner".stop()
