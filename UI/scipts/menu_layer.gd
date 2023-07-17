extends CanvasLayer

@onready var main = get_node("/root/Main")

func _process(_delta):
	if (main.isDead && !$GameOverMenu.visible):
		showGameOverMenu(main.score, max(main.bestScore, main.score))

func _input(event):
	if (event.is_action_pressed("jump") && !main.isStarted):
		visible = false
		$StartMenu.visible = false

func showGameOverMenu(score, bestScore):
	$GameOverMenu/Score.text = "Score: " + str(score)
	$GameOverMenu/BestSCore.text = "Best Score: " + str(bestScore)
	visible = true
	$GameOverMenu.visible = true


func _on_restart_pressed():
	get_tree().reload_current_scene()


func _on_button_pressed():
	if (visible):
		visible = false
		$StartMenu.visible = false
