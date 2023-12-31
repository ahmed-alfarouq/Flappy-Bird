extends Node

const PIPEPAIR = preload("res://pipes/pipe_pair.tscn")
@onready var pipeSpeed = 200
@onready var main = get_node("/root/Main")
@onready var isStarted = false

func _process(_delta):
	if (!isStarted):
		isStarted = main.isStarted
		if (isStarted):
			$SpawnTimer.start()
			$IncreaseSpeedTimer.start()

func spawnPipe():
	var screen = get_viewport().get_camera_2d().get_viewport_rect()
	var pipe = PIPEPAIR.instantiate()
	add_child(pipe, true)
	
	# Determine pipes position
	pipe.position.x = screen.end.x + 30
	pipe.position.y = randf_range(130, -130)

func _on_spawn_timer_timeout():
	if (isStarted):
		spawnPipe()

func _on_increase_speed_timer_timeout():
	if (isStarted && pipeSpeed < 450):
		pipeSpeed += 20
	elif (isStarted && pipeSpeed >= 450):
		pipeSpeed += 2

func stop():
	queue_free()
